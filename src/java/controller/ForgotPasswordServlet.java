package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.TaiKhoanService;
import model.TaiKhoan;
import utils.EmailUtility;

import java.io.IOException;
import java.util.Random;
import jakarta.mail.MessagingException;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {
    private TaiKhoanService taiKhoanService;

    @Override
    public void init() throws ServletException {
        super.init();
        taiKhoanService = new TaiKhoanService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        try {
            TaiKhoan user = taiKhoanService.getByTenTaiKhoan(username);
            if (user != null && user.getEmail().equals(email)) {
                // Tạo mã OTP ngẫu nhiên 6 chữ số
                String otp = String.format("%06d", new Random().nextInt(1000000));
                
                // Gửi OTP qua email
                try {
                    EmailUtility.sendOTP(email, otp);
                } catch (MessagingException e) {
                    request.setAttribute("error", "Lỗi khi gửi email. Vui lòng thử lại!");
                    request.getRequestDispatcher("/pages/forgotPassword.jsp").forward(request, response);
                    return;
                }
                
                // Lưu OTP và username vào session để sử dụng sau này
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("resetUsername", username);
                
                response.sendRedirect("/roombooking/pages/verifyOTP.jsp");
            } else {
                request.setAttribute("error", "Tài khoản hoặc email không chính xác!");
                request.getRequestDispatcher("/pages/forgotPassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}