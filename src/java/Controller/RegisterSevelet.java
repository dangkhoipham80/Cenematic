package Controller;

import DAO.UserDAO;
import DTO.User;
import Utils.AppUrl;
import Utils.Email;
import Utils.MaHoa;
import Utils.Validate;
import Utils.VerificationCode;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterSevelet extends HttpServlet {

    private final String SUCCESS_PAGE = "registered.jsp";
    private final String REGISTER_PAGE = "register.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Registering is not idempotent; a GET is almost always a stale link.
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String userName = Validate.clean(request.getParameter("userName"));
        String firstname = Validate.clean(request.getParameter("firstname"));
        String lastname = Validate.clean(request.getParameter("lastname"));
        String password = request.getParameter("password");
        String passwordAgain = request.getParameter("passwordAgain");
        String address = Validate.clean(request.getParameter("address"));
        String phoneNumber = Validate.clean(request.getParameter("phoneNumber"));
        String email = Validate.clean(request.getParameter("email"));
        String yearOfBirth = Validate.clean(request.getParameter("yearOfBirth"));
        boolean receiveEmail = request.getParameter("agreeMails") != null;
        boolean agreedToTerms = request.getParameter("agreeTerms") != null;

        // Echo everything except the passwords so a rejected form comes back filled in.
        request.setAttribute("userName", userName);
        request.setAttribute("firstname", firstname);
        request.setAttribute("lastname", lastname);
        request.setAttribute("address", address);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("email", email);
        request.setAttribute("yearOfBirth", yearOfBirth);
        request.setAttribute("agreeMails", receiveEmail);

        // Field name -> message, rendered next to the input it belongs to.
        Map<String, String> errors = new LinkedHashMap<>();
        putIfError(errors, "userName", Validate.username(userName));
        putIfError(errors, "password", Validate.password(password));
        putIfError(errors, "firstname", Validate.name(firstname, "first name"));
        putIfError(errors, "lastname", Validate.name(lastname, "last name"));
        putIfError(errors, "address", Validate.address(address));
        putIfError(errors, "phoneNumber", Validate.phone(phoneNumber));
        putIfError(errors, "email", Validate.email(email));

        if (!errors.containsKey("password") && !equalsSafe(password, passwordAgain)) {
            errors.put("passwordAgain", "Passwords do not match.");
        }

        Date dateOfBirth = null;
        if (!yearOfBirth.isEmpty()) {
            try {
                dateOfBirth = Date.valueOf(yearOfBirth);
                if (dateOfBirth.getTime() > System.currentTimeMillis()) {
                    errors.put("yearOfBirth", "Your date of birth cannot be in the future.");
                }
            } catch (IllegalArgumentException ex) {
                errors.put("yearOfBirth", "Use the date picker to enter a valid date.");
            }
        }

        String formError = null;
        if (!agreedToTerms) {
            formError = "You need to accept the cinema's terms before creating an account.";
        }

        try {
            UserDAO userDAO = new UserDAO();

            if (!errors.containsKey("userName") && userDAO.kiemTraTenDangNhap(userName)) {
                errors.put("userName", "That username is taken. Try another one.");
            }
            if (!errors.containsKey("email") && userDAO.kiemTraEmail(email)) {
                errors.put("email", "An account already uses this email address.");
            }

            if (!errors.isEmpty() || formError != null) {
                request.setAttribute("fieldErrors", errors);
                request.setAttribute("errorMessage", formError != null
                        ? formError
                        : "Please fix the highlighted fields and try again.");
                forward(request, response, REGISTER_PAGE);
                return;
            }

            String idAccount = System.currentTimeMillis() + "" + new Random().nextInt(1000);
            User user = new User(idAccount, null, userName, firstname, lastname, null, address,
                    phoneNumber, dateOfBirth, email, receiveEmail, MaHoa.toSHA1(password), false);

            if (userDAO.insert(user) <= 0) {
                request.setAttribute("fieldErrors", errors);
                request.setAttribute("errorMessage",
                        "We could not create your account just now. Please try again in a moment.");
                forward(request, response, REGISTER_PAGE);
                return;
            }

            user.setVerificationCode(VerificationCode.issue());
            user.setEffectiveTime(VerificationCode.expiresIn(VerificationCode.SIGNUP_MINUTES));
            user.setAuthentication(false);

            boolean emailSent = false;
            if (userDAO.updateVerifyInformation(user) > 0) {
                emailSent = Email.sendEmail(user.getEmail(),
                        "Xác thực tài khoản tại CINEMATIC.vn", getNoiDung(request, user));
            }

            request.setAttribute("email", user.getEmail());
            request.setAttribute("emailSent", emailSent);
            forward(request, response, SUCCESS_PAGE);
        } catch (SQLException | ClassNotFoundException ex) {
            log("Registration failed for username " + userName, ex);
            request.setAttribute("fieldErrors", errors);
            request.setAttribute("errorMessage",
                    "Something went wrong on our side. Please try again in a moment.");
            forward(request, response, REGISTER_PAGE);
        }
    }

    private static void putIfError(Map<String, String> errors, String field, String message) {
        if (message != null) {
            errors.put(field, message);
        }
    }

    private static boolean equalsSafe(String a, String b) {
        return a == null ? b == null : a.equals(b);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    public static String getNoiDung(HttpServletRequest request, User kh) {
        String link = AppUrl.base(request) + "/UserController?btAction=confirm&maKhachHang="
                + kh.getIdAccount() + "&maXacThuc=" + kh.getVerificationCode();
        return "<p>Cinematic.vn xin ch&agrave;o bạn <strong>" + Validate.escapeHtml(kh.getAccountName()) + "</strong>,</p>\r\n"
                + "<p>Vui l&ograve;ng x&aacute;c thực t&agrave;i khoản của bạn bằng c&aacute;ch click v&agrave;o đường link sau đ&acirc;y:</p>\r\n"
                + "<p><a href=\"" + link + "\">" + link + "</a></p>\r\n"
                + "<p>Đường link n&agrave;y hết hạn sau 24 giờ.</p>\r\n"
                + "<p>Đ&acirc;y l&agrave; email tự động, vui l&ograve;ng kh&ocirc;ng phản hồi email n&agrave;y.</p>\r\n"
                + "<p>Tr&acirc;n trọng cảm ơn.</p>";
    }

    @Override
    public String getServletInfo() {
        return "Creates a customer account and emails a confirmation link";
    }
}
