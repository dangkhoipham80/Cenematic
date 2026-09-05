package Controller;

import DAO.UserDAO;
import DTO.User;
import Utils.MaHoa;
import Utils.Validate;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Step 3 of the password reset: store the password the visitor chose.
 *
 * Replaces the previous scheme, which generated a password, saved it to the
 * database unhashed and mailed it in clear text. Because logins compare a
 * hash, that unhashed value locked the account out until the user clicked a
 * second link that hashed it in place.
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPasswordServlet"})
public class ResetPasswordServlet extends HttpServlet {

    private final String RESET_PAGE = "resetpassword.jsp";
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

        // Only a session that just passed the code check may set a password,
        // and the id comes from the session so it cannot be swapped in the form.
        String userId = (String) session.getAttribute(ForgotPasswordServelet.SESSION_VERIFIED_ID);
        if (userId == null) {
            request.setAttribute("errorMessage",
                    "Your reset request expired. Please enter your email address again.");
            forward(request, response, FORGOT_PAGE);
            return;
        }

        String password = request.getParameter("password");
        String passwordAgain = request.getParameter("passwordAgain");

        String invalid = Validate.password(password);
        if (invalid == null && !password.equals(passwordAgain)) {
            invalid = "Passwords do not match.";
        }
        if (invalid != null) {
            request.setAttribute("errorMessage", invalid);
            forward(request, response, RESET_PAGE);
            return;
        }

        try {
            UserDAO dao = new UserDAO();
            User user = dao.selectById(new User(userId));
            if (user == null) {
                clearResetState(session);
                request.setAttribute("errorMessage", "That account no longer exists.");
                forward(request, response, FORGOT_PAGE);
                return;
            }

            user.setPassword(MaHoa.toSHA1(password));
            if (!dao.changePassword(user)) {
                request.setAttribute("errorMessage",
                        "We could not save your new password. Please try again in a moment.");
                forward(request, response, RESET_PAGE);
                return;
            }

            clearResetState(session);
            // Anyone signed in on this session was authenticated with the old
            // password; drop them so the reset actually revokes that access.
            session.removeAttribute("user");
            session.setAttribute("flashMessage",
                    "Your password has been updated. You can sign in with it now.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } catch (SQLException | ClassNotFoundException ex) {
            log("Could not reset a password", ex);
            request.setAttribute("errorMessage",
                    "Something went wrong on our side. Please try again in a moment.");
            forward(request, response, RESET_PAGE);
        }
    }

    private static void clearResetState(HttpSession session) {
        session.removeAttribute(ForgotPasswordServelet.SESSION_VERIFIED_ID);
        session.removeAttribute(ForgotPasswordServelet.SESSION_EMAIL);
        session.removeAttribute(ForgotPasswordServelet.SESSION_ATTEMPTS);
        session.removeAttribute(ForgotPasswordServelet.SESSION_SENT_AT);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Saves a new password after the reset code has been verified";
    }
}
