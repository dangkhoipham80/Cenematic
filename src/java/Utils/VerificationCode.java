package Utils;

import DTO.User;
import java.sql.Timestamp;

/**
 * Lifecycle of the one-time codes used to confirm a new account and to
 * authorise a password reset.
 *
 * The expiry stored in {@code account.effectivetime} used to be written as a
 * {@code java.sql.Date} (midnight, day granularity) and then never read back,
 * so codes stayed valid forever. Issuing and checking both go through here now
 * so the two halves cannot drift apart again.
 */
public final class VerificationCode {

    /** A password reset is high value and always done in one sitting. */
    public static final int RESET_MINUTES = 15;

    /** Confirming a new account can wait until the user next opens their mail. */
    public static final int SIGNUP_MINUTES = 24 * 60;

    /** Wrong guesses allowed before the code is burned. */
    public static final int MAX_ATTEMPTS = 5;

    private VerificationCode() {
    }

    public static String issue() {
        return SoNgauNhien.getSoNgauNhien();
    }

    public static Timestamp expiresIn(int minutes) {
        return new Timestamp(System.currentTimeMillis() + minutes * 60_000L);
    }

    /**
     * @return {@code true} when {@code candidate} is this user's current code
     *         and that code has not expired.
     */
    public static boolean matches(User user, String candidate) {
        if (user == null || candidate == null) {
            return false;
        }
        String expected = user.getVerificationCode();
        if (expected == null || expected.isEmpty()) {
            return false;
        }
        if (isExpired(user)) {
            return false;
        }
        // Length-independent comparison so response timing does not leak the code.
        return constantTimeEquals(expected.trim(), candidate.trim());
    }

    /** A code with no recorded expiry predates this check and is treated as stale. */
    public static boolean isExpired(User user) {
        Timestamp expiry = user.getEffectiveTime();
        return expiry == null || expiry.getTime() < System.currentTimeMillis();
    }

    private static boolean constantTimeEquals(String a, String b) {
        int diff = a.length() ^ b.length();
        for (int i = 0; i < a.length() && i < b.length(); i++) {
            diff |= a.charAt(i) ^ b.charAt(i);
        }
        return diff == 0;
    }
}
