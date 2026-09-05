package Controller;

import DAO.UserDAO;
import DTO.User;
import Utils.Email;
import Utils.Validate;
import Utils.VerificationCode;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Step 1 of the password reset: take an email address and, if it belongs to an
 * account, mail a one-time code.
 *
 * The response is deliberately identical whether or not the address is
 * registered. Reporting "no such account" turned this page into an oracle for
 * checking which of a list of addresses had signed up.
 */
public class ForgotPasswordServelet extends HttpServlet {

    /** Session keys shared with {@link CheckCodeServelet} and {@link ResetPasswordServlet}. */
    static final String SESSION_EMAIL = "resetEmail";
    static final String SESSION_ATTEMPTS = "resetAttempts";
    static final String SESSION_SENT_AT = "resetSentAt";
    static final String SESSION_VERIFIED_ID = "resetVerifiedUserId";

    /** Rate limit for "resend the code", in milliseconds. */
    private static final long RESEND_INTERVAL_MS = 60_000L;

    private final String VERIFY_PAGE = "authenticate.jsp";
    private final String FORGOT_PAGE = "forgotpassword.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/forgotpassword.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // "Resend" comes back from the verify page, which knows the address already.
        boolean resend = "1".equals(request.getParameter("resend"));
        String email = resend
                ? Validate.clean((String) session.getAttribute(SESSION_EMAIL))
                : Validate.clean(request.getParameter("Email"));

        String invalid = Validate.email(email);
        if (invalid != null) {
            request.setAttribute("errorMessage", invalid);
            request.setAttribute("email", email);
            forward(request, response, FORGOT_PAGE);
            return;
        }

        Long lastSent = (Long) session.getAttribute(SESSION_SENT_AT);
        boolean throttled = resend && lastSent != null
                && System.currentTimeMillis() - lastSent < RESEND_INTERVAL_MS;

        if (!throttled) {
            try {
                UserDAO dao = new UserDAO();
                User user = dao.selectByUserEmail(email);
                if (user != null) {
                    user.setVerificationCode(VerificationCode.issue());
                    user.setEffectiveTime(VerificationCode.expiresIn(VerificationCode.RESET_MINUTES));
                    if (dao.updateVerifyPassword(user) > 0) {
                        Email.sendEmail(user.getEmail(),
                                "Đặt lại mật khẩu tại CINEMATIC.vn", getNoiDung(user));
                    }
                }
            } catch (SQLException | ClassNotFoundException ex) {
                // Still fall through to the code page: telling the visitor that
                // the lookup failed would give away that the address exists.
                log("Could not issue a reset code", ex);
            }
            session.setAttribute(SESSION_SENT_AT, System.currentTimeMillis());
        }

        // A fresh code invalidates any progress made against the previous one.
        session.setAttribute(SESSION_EMAIL, email);
        session.setAttribute(SESSION_ATTEMPTS, 0);
        session.removeAttribute(SESSION_VERIFIED_ID);

        // The page heading already names the address and the expiry, so this
        // only adds what it does not say.
        request.setAttribute("infoMessage", throttled
                ? "A code was just sent. Please wait a minute before requesting another one."
                : "Check your inbox, and your spam folder if it isn't there.");
        forward(request, response, VERIFY_PAGE);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    public static String getNoiDung(User user) {
        return "<p>Cinematic.vn xin ch&agrave;o bạn <strong>" + Validate.escapeHtml(user.getAccountName()) + "</strong>,</p>\r\n"
                + "<p>M&atilde; đặt lại mật khẩu của bạn l&agrave; <strong style=\"font-size:20px;letter-spacing:3px\">"
                + user.getVerificationCode() + "</strong></p>\r\n"
                + "<p>M&atilde; n&agrave;y hết hạn sau " + VerificationCode.RESET_MINUTES + " ph&uacute;t "
                + "v&agrave; chỉ sử dụng được một lần.</p>\r\n"
                + "<p>Nếu bạn kh&ocirc;ng y&ecirc;u cầu đặt lại mật khẩu, bạn c&oacute; thể bỏ qua email n&agrave;y.</p>\r\n"
                + "<p>Đ&acirc;y l&agrave; email tự động, vui l&ograve;ng kh&ocirc;ng phản hồi email n&agrave;y.</p>\r\n"
                + "<p>Tr&acirc;n trọng cảm ơn.</p>";
    }

    @Override
    public String getServletInfo() {
        return "Emails a one-time password reset code";
    }
}
