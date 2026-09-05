package Utils;

import java.util.regex.Pattern;

/**
 * Server-side validation for the account forms.
 *
 * The browser checks the same rules for instant feedback, but nothing in the
 * request can be trusted, so every rule is re-applied here. The length limits
 * mirror the {@code account} table columns - exceeding them used to surface as
 * an opaque SQL truncation error instead of a message the user can act on.
 */
public final class Validate {

    /** Matches the {@code accountname nvarchar(50)} column. */
    private static final Pattern USERNAME = Pattern.compile("^[A-Za-z0-9._]{4,50}$");

    /** Deliberately permissive; the confirmation email is the real check. */
    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]{2,}$");

    /** Vietnamese mobile format, and the {@code phonenumber char(10)} column. */
    private static final Pattern PHONE = Pattern.compile("^0[0-9]{9}$");

    public static final int MAX_NAME = 20;
    public static final int MAX_ADDRESS = 255;
    public static final int MAX_EMAIL = 50;
    public static final int MIN_PASSWORD = 8;

    private Validate() {
    }

    /** Trims and collapses {@code null} to an empty string. */
    public static String clean(String value) {
        return value == null ? "" : value.trim();
    }

    public static boolean isBlank(String value) {
        return clean(value).isEmpty();
    }

    /** @return an error message, or {@code null} when the value is acceptable. */
    public static String username(String value) {
        String v = clean(value);
        if (v.isEmpty()) {
            return "Choose a username.";
        }
        if (!USERNAME.matcher(v).matches()) {
            return "4-50 characters, letters, digits, dot or underscore only.";
        }
        return null;
    }

    public static String password(String value) {
        if (value == null || value.isEmpty()) {
            return "Choose a password.";
        }
        if (value.length() < MIN_PASSWORD) {
            return "Use at least " + MIN_PASSWORD + " characters.";
        }
        if (!value.matches(".*[A-Za-z].*") || !value.matches(".*[0-9].*")) {
            return "Mix in at least one letter and one digit.";
        }
        return null;
    }

    public static String email(String value) {
        String v = clean(value);
        if (v.isEmpty()) {
            return "Enter your email address.";
        }
        if (!EMAIL.matcher(v).matches()) {
            return "That does not look like a valid email address.";
        }
        if (v.length() > MAX_EMAIL) {
            return "Email must be " + MAX_EMAIL + " characters or fewer.";
        }
        return null;
    }

    public static String phone(String value) {
        String v = clean(value);
        if (v.isEmpty()) {
            return "Enter your phone number.";
        }
        if (!PHONE.matcher(v).matches()) {
            return "10 digits starting with 0, e.g. 0912345678.";
        }
        return null;
    }

    public static String name(String value, String label) {
        String v = clean(value);
        if (v.isEmpty()) {
            return "Enter your " + label + ".";
        }
        if (v.length() > MAX_NAME) {
            return "Keep your " + label + " under " + MAX_NAME + " characters.";
        }
        return null;
    }

    public static String address(String value) {
        String v = clean(value);
        if (v.isEmpty()) {
            return "Enter your address.";
        }
        if (v.length() > MAX_ADDRESS) {
            return "Keep your address under " + MAX_ADDRESS + " characters.";
        }
        return null;
    }

    /**
     * Escapes a value for interpolation into HTML text or an attribute, so a
     * rejected form can safely echo back what the user typed.
     */
    public static String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        StringBuilder out = new StringBuilder(value.length() + 16);
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '&': out.append("&amp;"); break;
                case '<': out.append("&lt;"); break;
                case '>': out.append("&gt;"); break;
                case '"': out.append("&quot;"); break;
                case '\'': out.append("&#39;"); break;
                default: out.append(c);
            }
        }
        return out.toString();
    }

    /**
     * Hides most of an address for display: {@code someone@gmail.com} becomes
     * {@code so*****@gmail.com}. Confirms which mailbox was used without
     * printing an address the page's visitor may not be entitled to see.
     */
    public static String maskEmail(String email) {
        String v = clean(email);
        int at = v.indexOf('@');
        if (at < 1) {
            return v;
        }
        String local = v.substring(0, at);
        String domain = v.substring(at);
        int keep = Math.min(2, local.length());
        StringBuilder masked = new StringBuilder(local.substring(0, keep));
        for (int i = keep; i < local.length(); i++) {
            masked.append('*');
        }
        return masked + domain;
    }
}
