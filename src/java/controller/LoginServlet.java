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
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.Base64;
import model.GoogleAccount;
import model.TaiKhoan;
import utils.GoogleLogin;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    private DAOTaiKhoan daoTaiKhoan = new DAOTaiKhoan();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserInfo(accessToken);

        if (acc == null || acc.getEmail() == null) {
            response.sendRedirect("login.jsp?error=Invalid token");
            return;
        }

        String email = acc.getEmail();
        TaiKhoan user = daoTaiKhoan.getByEmail(email);

       if (user == null) {
            String randomPassword = generateRandomPassword(10);
            String encodedPassword = Base64.getEncoder().encodeToString(randomPassword.getBytes());

            int defaultRoleId = 2; 
            String tenTaiKhoan = email.split("@")[0]; 
            user = new TaiKhoan(tenTaiKhoan, email, encodedPassword, acc.getName(), defaultRoleId);


            boolean isInserted = daoTaiKhoan.insert(user);
            if (!isInserted) {
                response.sendRedirect("pages/login.jsp?error=Failed to create account");
                return;
            }
        }


        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        response.sendRedirect("/roombooking/home");
    }

    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();
        
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            password.append(chars.charAt(index));
        }
        
        return password.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        TaiKhoan user = daoTaiKhoan.getByDangNhap(username, password);
        if (user != null) {
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60);
            
           
            if ("on".equals(remember)) {
               
                String encodedPassword = Base64.getEncoder().encodeToString(password.getBytes());
                
                Cookie userCookie = new Cookie("username", user.getTenTaiKhoan());
                Cookie passCookie = new Cookie("password", encodedPassword);
                
                userCookie.setMaxAge(7 * 24 * 60 * 60);
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
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}