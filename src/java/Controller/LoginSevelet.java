package Controller;

import DAO.UserDAO;
import DTO.User;
import Utils.MaHoa;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginSevelet extends HttpServlet {

    private final String INDEX_PAGE = "index.jsp";
    private final String LOGIN_PAGE = "login.jsp";
    private final String ADMIN_PAGE = "admin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE; // Default to login page

        try {
            String tenDangNhap = request.getParameter("UserName");
            String matKhau = request.getParameter("Password");

            if (tenDangNhap == null || matKhau == null || tenDangNhap.trim().isEmpty() || matKhau.isEmpty()) {
                request.getSession().setAttribute("flashError", "Enter your username and password.");
                response.sendRedirect(request.getContextPath() + "/" + LOGIN_PAGE);
                return;
            }
            tenDangNhap = tenDangNhap.trim();

            matKhau = MaHoa.toSHA1(matKhau); // Hash the password

            User kh = new User();
            kh.setAccountName(tenDangNhap);
            kh.setPassword(matKhau);

            UserDAO khd = new UserDAO();
            User khachHang = khd.selectByUsernameAndPassWord(kh, true);

            if (khachHang != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", khachHang);

                // Check if Remember Me checkbox is checked
                if (request.getParameter("rememberMe") != null) {
                    rememberMe(request, response, tenDangNhap, matKhau);
                } else {
                    forgetMe(request, response);
                }

                url = ADMIN_PAGE; // Redirect to admin page after successful login
            } else {
                khachHang = khd.selectByUsernameAndPassWord(kh, false);
                if (khachHang != null && khachHang.isAuthentication()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", khachHang);

                    // Check if Remember Me checkbox is checked
                    if (request.getParameter("rememberMe") != null) {
                        rememberMe(request, response, tenDangNhap, matKhau);
                    } else {
                        forgetMe(request, response);
                    }

                    url = INDEX_PAGE; // Redirect to index page after successful login
                } else {
                    // A forward-scoped attribute would not survive the redirect
                    // below, which is why the login page never showed an error.
                    request.getSession().setAttribute("flashError",
                            "Incorrect username or password, or the account has not been confirmed yet.");
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            response.sendRedirect(request.getContextPath() + "/" + url);
        }
    }

    /**
     * Remembers the sign-in for a day. HttpOnly because only the server reads
     * these back (see header.jsp); it keeps the stored credential away from
     * any script on the page.
     */
    private static void rememberMe(HttpServletRequest request, HttpServletResponse response,
            String userName, String hashedPassword) {
        Cookie cUserName = new Cookie("UserName", userName);
        Cookie cPassword = new Cookie("Password", hashedPassword);
        for (Cookie cookie : new Cookie[]{cUserName, cPassword}) {
            cookie.setMaxAge(24 * 60 * 60); // 1 day
            cookie.setHttpOnly(true);
            cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
            response.addCookie(cookie);
        }
    }

    /**
     * Drops the remembered sign-in. The expiring cookie has to carry the same
     * path as the one that set it, or the browser keeps the original.
     */
    private static void forgetMe(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return;
        }
        String path = request.getContextPath().isEmpty() ? "/" : request.getContextPath();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("UserName") || cookie.getName().equals("Password")) {
                cookie.setValue("");
                cookie.setMaxAge(0);
                cookie.setPath(path);
                response.addCookie(cookie);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
