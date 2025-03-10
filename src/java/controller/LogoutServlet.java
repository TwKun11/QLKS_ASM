package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Xóa Cookie đăng nhập
        Cookie userCookie = new Cookie("username", "");
        Cookie passCookie = new Cookie("password", "");

        userCookie.setMaxAge(0);
        passCookie.setMaxAge(0);

        response.addCookie(userCookie);
        response.addCookie(passCookie);

        response.sendRedirect("/roombooking/home");
    }
}
