package Controller;

import DAO.UserDAO;
import DTO.User;
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
 * Step 2 of the password reset: check the emailed code.
 *
 * The account is taken from the session, not from a hidden form field - the
 * old form posted the account id alongside the code, so anyone could aim a
 * guessed code at any account. A correct code no longer mails out a temporary
 * password; it authorises the visitor to choose one on the next screen.
 */
public class CheckCodeServelet extends HttpServlet {

    private final String VERIFY_PAGE = "authenticate.jsp";
    private final String FORGOT_PAGE = "forgotpassword.jsp";
    private final String RESET_PAGE = "resetpassword.jsp";

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

        String email = Validate.clean((String) session.getAttribute(ForgotPasswordServelet.SESSION_EMAIL));
        if (email.isEmpty()) {
            // Deep link or expired session - start over rather than crash.
            request.setAttribute("errorMessage",
                    "Your reset request expired. Please enter your email address again.");
            forward(request, response, FORGOT_PAGE);
            return;
        }

        String code = Validate.clean(request.getParameter("Code"));
        int attempts = attemptsSoFar(session);

        if (attempts >= VerificationCode.MAX_ATTEMPTS) {
            request.setAttribute("errorMessage",
                    "Too many incorrect codes. Request a new one to continue.");
            forward(request, response, VERIFY_PAGE);
            return;
        }

        try {
            UserDAO dao = new UserDAO();
            User user = dao.selectByUserEmail(email);

            if (VerificationCode.matches(user, code)) {
                // Single use: burn the code before handing out the reset ticket.
                dao.clearVerificationCode(user.getIdAccount());
                session.setAttribute(ForgotPasswordServelet.SESSION_VERIFIED_ID, user.getIdAccount());
                session.setAttribute(ForgotPasswordServelet.SESSION_ATTEMPTS, 0);
                forward(request, response, RESET_PAGE);
                return;
            }

            attempts++;
            session.setAttribute(ForgotPasswordServelet.SESSION_ATTEMPTS, attempts);

            if (user != null && VerificationCode.isExpired(user)) {
                request.setAttribute("errorMessage",
                        "That code has expired. Request a new one below.");
            } else {
                int left = VerificationCode.MAX_ATTEMPTS - attempts;
                request.setAttribute("errorMessage", left > 0
                        ? "That code is not correct. " + left + " attempt" + (left == 1 ? "" : "s") + " left."
                        : "Too many incorrect codes. Request a new one to continue.");
            }
        } catch (SQLException | ClassNotFoundException ex) {
            log("Could not verify a reset code", ex);
            request.setAttribute("errorMessage",
                    "Something went wrong on our side. Please try again in a moment.");
        }

        forward(request, response, VERIFY_PAGE);
    }

    private static int attemptsSoFar(HttpSession session) {
        Object value = session.getAttribute(ForgotPasswordServelet.SESSION_ATTEMPTS);
        return value instanceof Integer ? (Integer) value : 0;
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Verifies the one-time password reset code";
    }
}
