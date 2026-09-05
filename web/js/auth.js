/* ---------------------------------------------------------------------------
   Cinematic — behaviour shared by the account pages.

   Everything here is progressive enhancement: with JavaScript disabled the
   forms still submit and the server still validates.
   ------------------------------------------------------------------------ */
(function () {
    "use strict";

    /* --- Show / hide password ------------------------------------------ */

    function wirePasswordToggles() {
        var toggles = document.querySelectorAll("[data-pw-toggle]");
        Array.prototype.forEach.call(toggles, function (button) {
            var input = document.getElementById(button.getAttribute("data-pw-toggle"));
            if (!input) {
                return;
            }
            button.addEventListener("click", function () {
                var hidden = input.type === "password";
                input.type = hidden ? "text" : "password";
                button.textContent = hidden ? "Hide" : "Show";
                button.setAttribute("aria-label", (hidden ? "Hide" : "Show") + " password");
            });
        });
    }

    /* --- Password strength ---------------------------------------------- */

    var STRENGTH_LABELS = ["", "Weak", "Fair", "Good", "Strong"];

    // Deliberately the same rules the server enforces, plus a bonus point for
    // length so the meter keeps rewarding longer passwords.
    function scorePassword(value) {
        if (!value) {
            return 0;
        }
        var score = 0;
        if (value.length >= 8) score++;
        if (value.length >= 12) score++;
        if (/[a-z]/.test(value) && /[A-Z]/.test(value)) score++;
        if (/[0-9]/.test(value) && /[^A-Za-z0-9]/.test(value)) score++;
        return Math.min(score, 4);
    }

    function wireStrengthMeters() {
        var meters = document.querySelectorAll("[data-pw-meter]");
        Array.prototype.forEach.call(meters, function (meter) {
            var input = document.getElementById(meter.getAttribute("data-pw-meter"));
            var label = meter.querySelector(".label");
            if (!input) {
                return;
            }
            input.addEventListener("input", function () {
                var score = scorePassword(input.value);
                meter.setAttribute("data-score", String(score));
                if (label) {
                    label.textContent = STRENGTH_LABELS[score];
                }
            });
        });
    }

    /* --- Inline field validation ---------------------------------------- */

    // Marks the field wrapper invalid and swaps in a message. Returns validity
    // so callers can chain checks on submit.
    function setFieldError(input, message) {
        var field = input.closest(".field");
        if (!field) {
            return !message;
        }
        var error = field.querySelector(".error");
        if (message) {
            field.classList.add("is-invalid");
            if (error) {
                error.textContent = message;
            }
            input.setAttribute("aria-invalid", "true");
        } else {
            field.classList.remove("is-invalid");
            input.removeAttribute("aria-invalid");
        }
        return !message;
    }

    var RULES = {
        required: function (value) {
            return value.trim() ? "" : "This field is required.";
        },
        username: function (value) {
            if (!value.trim()) return "Choose a username.";
            if (!/^[A-Za-z0-9._]{4,50}$/.test(value)) {
                return "4-50 characters, letters, digits, dot or underscore only.";
            }
            return "";
        },
        password: function (value) {
            if (!value) return "Choose a password.";
            if (value.length < 8) return "Use at least 8 characters.";
            if (!/[A-Za-z]/.test(value) || !/[0-9]/.test(value)) {
                return "Mix in at least one letter and one digit.";
            }
            return "";
        },
        email: function (value) {
            if (!value.trim()) return "Enter your email address.";
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(value)) {
                return "That does not look like a valid email address.";
            }
            return "";
        },
        phone: function (value) {
            if (!value.trim()) return "Enter your phone number.";
            if (!/^0[0-9]{9}$/.test(value)) {
                return "10 digits starting with 0, e.g. 0912345678.";
            }
            return "";
        },
        name: function (value) {
            if (!value.trim()) return "This field is required.";
            if (value.trim().length > 20) return "Keep this under 20 characters.";
            return "";
        }
    };

    function validateInput(input) {
        var rule = RULES[input.getAttribute("data-validate")];
        if (!rule) {
            return true;
        }
        return setFieldError(input, rule(input.value));
    }

    function wireValidation() {
        var inputs = document.querySelectorAll("[data-validate]");
        Array.prototype.forEach.call(inputs, function (input) {
            // Only nag once the user has left the field, then keep it live.
            input.addEventListener("blur", function () {
                validateInput(input);
            });
            input.addEventListener("input", function () {
                if (input.closest(".field").classList.contains("is-invalid")) {
                    validateInput(input);
                }
            });
        });

        var confirmInputs = document.querySelectorAll("[data-match]");
        Array.prototype.forEach.call(confirmInputs, function (input) {
            var other = document.getElementById(input.getAttribute("data-match"));
            if (!other) {
                return;
            }
            var check = function () {
                setFieldError(input, input.value && input.value !== other.value
                    ? "Passwords do not match."
                    : "");
            };
            input.addEventListener("input", check);
            other.addEventListener("input", function () {
                if (input.value) {
                    check();
                }
            });
        });

        var forms = document.querySelectorAll("form[data-validated]");
        Array.prototype.forEach.call(forms, function (form) {
            form.addEventListener("submit", function (event) {
                var ok = true;
                var firstBad = null;

                Array.prototype.forEach.call(form.querySelectorAll("[data-validate]"), function (input) {
                    if (!validateInput(input) && !firstBad) {
                        firstBad = input;
                    }
                    ok = validateInput(input) && ok;
                });

                Array.prototype.forEach.call(form.querySelectorAll("[data-match]"), function (input) {
                    var other = document.getElementById(input.getAttribute("data-match"));
                    var matches = !other || input.value === other.value;
                    setFieldError(input, matches ? "" : "Passwords do not match.");
                    if (!matches) {
                        ok = false;
                        if (!firstBad) {
                            firstBad = input;
                        }
                    }
                });

                if (!ok) {
                    event.preventDefault();
                    if (firstBad) {
                        firstBad.focus();
                    }
                }
            });
        });
    }

    /* --- Terms checkbox gates the submit button -------------------------- */

    function wireGates() {
        var gates = document.querySelectorAll("[data-gate]");
        Array.prototype.forEach.call(gates, function (checkbox) {
            var button = document.getElementById(checkbox.getAttribute("data-gate"));
            if (!button) {
                return;
            }
            var sync = function () {
                button.disabled = !checkbox.checked;
            };
            checkbox.addEventListener("change", sync);
            sync();
        });
    }

    /* --- One-time code boxes -------------------------------------------- */

    function wireOtp() {
        var group = document.querySelector("[data-otp]");
        if (!group) {
            return;
        }
        var target = document.getElementById(group.getAttribute("data-otp"));
        var boxes = Array.prototype.slice.call(group.querySelectorAll("input"));
        if (!target || !boxes.length) {
            return;
        }

        // The plain input is what the page ships with, so the form works
        // without JS. Now that we're here, swap in the nicer boxes.
        group.hidden = false;
        var hint = group.nextElementSibling;
        if (hint && hint.classList.contains("otp-hint")) {
            hint.hidden = false;
        }
        var fallback = document.querySelector("[data-otp-fallback]");
        if (fallback) {
            fallback.classList.add("sr-only");
            target.removeAttribute("autofocus");
            // `required` on an off-screen input makes the browser point its
            // validation bubble at something nobody can see.
            target.removeAttribute("required");
            target.setAttribute("tabindex", "-1");
            target.setAttribute("aria-hidden", "true");
        }

        var form = group.closest("form");
        if (form) {
            form.addEventListener("submit", function (event) {
                if (target.value.length === boxes.length) {
                    return;
                }
                event.preventDefault();
                var empty = boxes.filter(function (b) {
                    return !b.value;
                })[0];
                (empty || boxes[0]).focus();
            });
        }

        var sync = function () {
            target.value = boxes.map(function (b) {
                return b.value;
            }).join("");
        };

        boxes.forEach(function (box, index) {
            box.addEventListener("input", function () {
                box.value = box.value.replace(/\D/g, "").slice(0, 1);
                if (box.value && index < boxes.length - 1) {
                    boxes[index + 1].focus();
                }
                sync();
            });

            box.addEventListener("keydown", function (event) {
                if (event.key === "Backspace" && !box.value && index > 0) {
                    boxes[index - 1].focus();
                } else if (event.key === "ArrowLeft" && index > 0) {
                    boxes[index - 1].focus();
                } else if (event.key === "ArrowRight" && index < boxes.length - 1) {
                    boxes[index + 1].focus();
                }
            });

            // Pasting the whole code into any box fills the row.
            box.addEventListener("paste", function (event) {
                var text = (event.clipboardData || window.clipboardData).getData("text") || "";
                var digits = text.replace(/\D/g, "").slice(0, boxes.length);
                if (!digits) {
                    return;
                }
                event.preventDefault();
                digits.split("").forEach(function (digit, offset) {
                    if (boxes[offset]) {
                        boxes[offset].value = digit;
                    }
                });
                sync();
                boxes[Math.min(digits.length, boxes.length - 1)].focus();
            });
        });

        if (boxes.length) {
            boxes[0].focus();
        }
    }

    /* --- Guard against double submits ------------------------------------ */

    function wireSubmitState() {
        Array.prototype.forEach.call(document.querySelectorAll("form[data-busy-text]"), function (form) {
            form.addEventListener("submit", function (event) {
                // Deferred so the other submit handlers get to run first: a
                // cancelled submit must not leave the button stuck on "Sending...".
                window.setTimeout(function () {
                    var button = form.querySelector("button[type=submit]");
                    if (button && !event.defaultPrevented) {
                        button.disabled = true;
                        button.textContent = form.getAttribute("data-busy-text");
                    }
                }, 0);
            });
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        wirePasswordToggles();
        wireStrengthMeters();
        wireValidation();
        wireGates();
        wireOtp();
        wireSubmitState();
    });
})();
