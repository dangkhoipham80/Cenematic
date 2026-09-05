package Utils;

import javax.servlet.http.HttpServletRequest;

/**
 * Builds absolute URLs for links that leave the application (verification
 * emails). Derived from the incoming request so the app works on any
 * host/port/context path instead of a hardcoded localhost address.
 */
public class AppUrl {

    /** e.g. {@code http://localhost:8080/Cenematic} (no trailing slash). */
    public static String base(HttpServletRequest request) {
        String override = System.getenv("APP_BASE_URL");
        if (override != null && !override.isEmpty()) {
            return override.endsWith("/") ? override.substring(0, override.length() - 1) : override;
        }

        StringBuilder url = new StringBuilder();
        url.append(request.getScheme()).append("://").append(request.getServerName());

        int port = request.getServerPort();
        boolean defaultPort = ("http".equals(request.getScheme()) && port == 80)
                || ("https".equals(request.getScheme()) && port == 443);
        if (!defaultPort) {
            url.append(':').append(port);
        }

        return url.append(request.getContextPath()).toString();
    }
}
