<%@page import="java.util.Map"%>
<%@page import="Utils.Validate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    /** Renders the server-side message for a field, if the form came back rejected. */
    private String errorFor(Map<String, String> errors, String field) {
        String message = errors == null ? null : errors.get(field);
        return message == null ? "" : Validate.escapeHtml(message);
    }

    private String invalidClass(Map<String, String> errors, String field) {
        return errors != null && errors.containsKey(field) ? " is-invalid" : "";
    }
%>
<%
    String ctx = request.getContextPath();

    @SuppressWarnings("unchecked")
    Map<String, String> errors = (Map<String, String>) request.getAttribute("fieldErrors");
    String errorMessage = (String) request.getAttribute("errorMessage");

    String v_userName = Validate.escapeHtml((String) request.getAttribute("userName"));
    String v_firstname = Validate.escapeHtml((String) request.getAttribute("firstname"));
    String v_lastname = Validate.escapeHtml((String) request.getAttribute("lastname"));
    String v_yearOfBirth = Validate.escapeHtml((String) request.getAttribute("yearOfBirth"));
    String v_address = Validate.escapeHtml((String) request.getAttribute("address"));
    String v_phoneNumber = Validate.escapeHtml((String) request.getAttribute("phoneNumber"));
    String v_email = Validate.escapeHtml((String) request.getAttribute("email"));
    boolean v_agreeMails = Boolean.TRUE.equals(request.getAttribute("agreeMails"));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Create an account &middot; Cinematic</title>
        <link rel="stylesheet" href="<%=ctx%>/css/auth.css">
    </head>
    <body class="auth">
        <main class="auth-card auth-card--wide">
            <a class="auth-brand" href="<%=ctx%>/index.jsp">
                <img src="<%=ctx%>/img/bintang%20cinema.png" alt="">
                <span>Cinematic</span>
            </a>

            <div class="auth-head">
                <h1>Create your account</h1>
                <p>One account for booking seats, keeping tickets and tracking your history.</p>
            </div>

            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert--error" role="alert">
                <p><%=Validate.escapeHtml(errorMessage)%></p>
            </div>
            <% } %>

            <form action="<%=ctx%>/UserController" method="post" data-validated data-busy-text="Creating account...">
                <input type="hidden" name="btAction" value="register">

                <section class="form-section">
                    <h2>Account</h2>

                    <div class="field<%=invalidClass(errors, "userName")%>">
                        <input type="text" id="userName" name="userName" placeholder="Username"
                               value="<%=v_userName%>" autocomplete="username" required
                               data-validate="username">
                        <label for="userName">Username<span class="req">*</span></label>
                        <span class="hint">4-50 characters: letters, digits, dot or underscore.</span>
                        <span class="error"><%=errorFor(errors, "userName")%></span>
                    </div>

                    <div class="grid-2">
                        <div>
                            <div class="field field--password<%=invalidClass(errors, "password")%>">
                                <input type="password" id="password" name="password" placeholder="Password"
                                       autocomplete="new-password" required data-validate="password">
                                <label for="password">Password<span class="req">*</span></label>
                                <button type="button" class="pw-toggle" data-pw-toggle="password"
                                        aria-label="Show password">Show</button>
                                <span class="hint">At least 8 characters, with a letter and a digit.</span>
                                <span class="error"><%=errorFor(errors, "password")%></span>
                            </div>
                            <div class="pw-meter" data-pw-meter="password" data-score="0" aria-hidden="true">
                                <span class="bars"><i></i><i></i><i></i><i></i></span>
                                <span class="label"></span>
                            </div>
                        </div>

                        <div class="field field--password<%=invalidClass(errors, "passwordAgain")%>">
                            <input type="password" id="passwordAgain" name="passwordAgain"
                                   placeholder="Confirm password" autocomplete="new-password" required
                                   data-match="password">
                            <label for="passwordAgain">Confirm password<span class="req">*</span></label>
                            <button type="button" class="pw-toggle" data-pw-toggle="passwordAgain"
                                    aria-label="Show password">Show</button>
                            <span class="error"><%=errorFor(errors, "passwordAgain")%></span>
                        </div>
                    </div>
                </section>

                <section class="form-section">
                    <h2>About you</h2>

                    <div class="grid-2">
                        <div class="field<%=invalidClass(errors, "firstname")%>">
                            <input type="text" id="firstname" name="firstname" placeholder="First name"
                                   value="<%=v_firstname%>" autocomplete="given-name" maxlength="20"
                                   required data-validate="name">
                            <label for="firstname">First name<span class="req">*</span></label>
                            <span class="error"><%=errorFor(errors, "firstname")%></span>
                        </div>

                        <div class="field<%=invalidClass(errors, "lastname")%>">
                            <input type="text" id="lastname" name="lastname" placeholder="Last name"
                                   value="<%=v_lastname%>" autocomplete="family-name" maxlength="20"
                                   required data-validate="name">
                            <label for="lastname">Last name<span class="req">*</span></label>
                            <span class="error"><%=errorFor(errors, "lastname")%></span>
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field<%=invalidClass(errors, "yearOfBirth")%>">
                            <input type="date" id="yearOfBirth" name="yearOfBirth" placeholder=" "
                                   value="<%=v_yearOfBirth%>" autocomplete="bday">
                            <label for="yearOfBirth">Date of birth</label>
                            <span class="error"><%=errorFor(errors, "yearOfBirth")%></span>
                        </div>

                        <div class="field<%=invalidClass(errors, "phoneNumber")%>">
                            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Phone number"
                                   value="<%=v_phoneNumber%>" autocomplete="tel" inputmode="numeric"
                                   maxlength="10" required data-validate="phone">
                            <label for="phoneNumber">Phone number<span class="req">*</span></label>
                            <span class="hint">10 digits starting with 0.</span>
                            <span class="error"><%=errorFor(errors, "phoneNumber")%></span>
                        </div>
                    </div>

                    <div class="field<%=invalidClass(errors, "email")%>">
                        <input type="email" id="email" name="email" placeholder="Email"
                               value="<%=v_email%>" autocomplete="email" maxlength="50"
                               required data-validate="email">
                        <label for="email">Email<span class="req">*</span></label>
                        <span class="hint">We send your confirmation link here.</span>
                        <span class="error"><%=errorFor(errors, "email")%></span>
                    </div>

                    <div class="field<%=invalidClass(errors, "address")%>">
                        <input type="text" id="address" name="address" placeholder="Address"
                               value="<%=v_address%>" autocomplete="street-address" maxlength="255"
                               required data-validate="required">
                        <label for="address">Address<span class="req">*</span></label>
                        <span class="error"><%=errorFor(errors, "address")%></span>
                    </div>
                </section>

                <section class="form-section">
                    <label class="check">
                        <input type="checkbox" id="agreeTerms" name="agreeTerms" value="true"
                               required data-gate="submit">
                        <span>I agree to <a href="<%=ctx%>/aboutus.jsp">the cinema's terms</a><span class="req">*</span></span>
                    </label>
                    <label class="check">
                        <input type="checkbox" name="agreeMails" value="true" <%=v_agreeMails ? "checked" : ""%>>
                        <span>Email me about new releases and offers</span>
                    </label>

                    <!-- Enabled in markup so the form still works without JS;
                         auth.js disables it until the terms box is ticked. -->
                    <button type="submit" id="submit" class="btn btn--primary">Create account</button>
                </section>
            </form>

            <div class="auth-foot">
                Already have an account? <a href="<%=ctx%>/login.jsp">Sign in</a>
            </div>
        </main>

        <script src="<%=ctx%>/js/auth.js"></script>
    </body>
</html>
