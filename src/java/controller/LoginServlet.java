package controller;

import dao.DAOTaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;
import model.TaiKhoan;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        TaiKhoan user = DAOTaiKhoan.getByDangNhap(username, password);
        if (user != null) {
            // Lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // Session timeout 30 phút
            
            // Nếu chọn "Ghi nhớ đăng nhập", lưu vào cookie
            if ("on".equals(remember)) {
                // Mã hóa mật khẩu bằng Base64 (Nên thay thế bằng hashing trong thực tế)
                String encodedPassword = Base64.getEncoder().encodeToString(password.getBytes());
                
                Cookie userCookie = new Cookie("username", user.getTenTaiKhoan());
                Cookie passCookie = new Cookie("password", encodedPassword);
                
                userCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                passCookie.setMaxAge(7 * 24 * 60 * 60);
                
                userCookie.setHttpOnly(true);
                passCookie.setHttpOnly(true);
                
                userCookie.setSecure(true);
                passCookie.setSecure(true);
                
                response.addCookie(userCookie);
                response.addCookie(passCookie);
            }
            
            response.sendRedirect("/roombooking/home");
        } else {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
