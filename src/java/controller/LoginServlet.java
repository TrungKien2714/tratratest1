package controller;

import dal.CustomerDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet({"/admin/login", "/customer/login", "/manager/login", "/seller/login", "/staff/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String EMAIL_PREFIX = "email_";
    private UserDAO userDAO;
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String role = extractRoleFromURI(request);
        request.setAttribute("role", role);
        request.setAttribute("savedEmail", getSavedEmailFromCookies(request.getCookies(), role));
        request.getRequestDispatcher("../login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = extractRoleFromURI(request);
        String remember = request.getParameter("remember");

        request.setAttribute("role", role);

        try {
            User user = userDAO.authenticate(email, password, role);
            if (user != null) {
                handleSuccessfulLogin(request, response, user, role, email, remember);
            } else {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("../login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("../login.jsp").forward(request, response);
        }
    }

    private String extractRoleFromURI(HttpServletRequest request) {
        return request.getRequestURI().split("/")[2];
    }

    private String getSavedEmailFromCookies(Cookie[] cookies, String role) {
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ((EMAIL_PREFIX + role).equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    private void handleSuccessfulLogin(HttpServletRequest request, HttpServletResponse response, User user,
                                       String role, String email, String remember) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute(role, user);
        session.setMaxInactiveInterval(300);

        Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());
        sessionCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
        sessionCookie.setPath("/");
        response.addCookie(sessionCookie);

        manageRememberMeCookie(response, role, email, remember);

        redirectUser(response, role, request.getContextPath());
    }

    private void manageRememberMeCookie(HttpServletResponse response, String role, String email, String remember) {
        Cookie emailCookie = new Cookie(EMAIL_PREFIX + role, "on".equals(remember) ? email : "");
        emailCookie.setMaxAge("on".equals(remember) ? 7 * 24 * 60 * 60 : 0); // Set expiry
        emailCookie.setPath("/");
        response.addCookie(emailCookie);
    }

    private void redirectUser(HttpServletResponse response, String role, String contextPath) throws IOException {
        switch (role.toLowerCase()) {
            case "customer":
                response.sendRedirect("/tratra");
                break;
            case "admin":
                response.sendRedirect(contextPath + "/admin_page/AdminDashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/home"); // Fallback redirection
                break;
        }
    }
}
