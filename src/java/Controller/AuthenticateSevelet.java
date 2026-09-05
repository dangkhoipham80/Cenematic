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

/**
 * Handles the confirmation link mailed after registration.
 *
 * The code is now checked for expiry and cleared once used; previously it was
 * compared without a null check (any account that had never been issued a code
 * threw a NullPointerException) and stayed valid indefinitely.
 */
public class AuthenticateSevelet extends HttpServlet {

    private final String NOTIFY_PAGE = "notify.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String maKhachHang = Validate.clean(request.getParameter("maKhachHang"));
        String maXacThuc = Validate.clean(request.getParameter("maXacThuc"));

        boolean ok = false;
        String title;
        String message;

        try {
            UserDAO dao = new UserDAO();
            User user = dao.selectById(new User(maKhachHang));

            if (user == null) {
                title = "Account not found";
                message = "We could not find the account this link belongs to.";
            } else if (user.isAuthentication()) {
                ok = true;
                title = "Already confirmed";
                message = "This account is confirmed - you can sign in whenever you like.";
            } else if (VerificationCode.matches(user, maXacThuc)) {
                user.setAuthentication(true);
                user.setVerificationCode(null);
                user.setEffectiveTime(null);
                dao.updateVerifyInformation(user);
                ok = true;
                title = "You're all set";
                message = "Your account is confirmed. Sign in to start booking tickets.";
            } else if (VerificationCode.isExpired(user)) {
                title = "This link has expired";
                message = "Confirmation links are valid for 24 hours. Register again to get a fresh one.";
            } else {
                title = "Confirmation failed";
                message = "This confirmation link is not valid.";
            }
        } catch (SQLException | ClassNotFoundException ex) {
            log("Could not confirm an account", ex);
            title = "Something went wrong";
            message = "Please try the link again in a moment.";
        }

        request.setAttribute("statusOk", ok);
        request.setAttribute("statusTitle", title);
        request.setAttribute("statusMessage", message);

        RequestDispatcher rd = request.getRequestDispatcher(NOTIFY_PAGE);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Confirms a newly registered account from the emailed link";
    }
}
