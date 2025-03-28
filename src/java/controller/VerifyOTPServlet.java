package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.TaiKhoanService;
import model.TaiKhoan;

import java.io.IOException;

@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/verifyOTP"})
public class VerifyOTPServlet extends HttpServlet {

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

        HttpSession session = request.getSession();
        String enteredOTP = request.getParameter("otp");
        String sessionOTP = (String) session.getAttribute("otp");
        TaiKhoan pendingUser = (TaiKhoan) session.getAttribute("pendingUser");
        String resetUsername = (String) session.getAttribute("resetUsername");

        if (enteredOTP != null && sessionOTP != null && enteredOTP.equals(sessionOTP)) {
            if (pendingUser != null) { 
                // Xử lý đăng ký tài khoản
                taiKhoanService.insert(pendingUser);
                session.removeAttribute("pendingUser");
                response.sendRedirect("pages/success.jsp");
            } else if (resetUsername != null) { 
                // Chuyển đến trang đặt lại mật khẩu
                response.sendRedirect(request.getContextPath() + "/pages/resetPassword.jsp");
            } else {
                request.setAttribute("errorOTP", "Không tìm thấy thông tin phù hợp.");
                request.getRequestDispatcher("pages/verifyOTP.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorOTP", "Mã OTP không đúng! Hãy thử lại.");
            request.getRequestDispatcher("pages/verifyOTP.jsp").forward(request, response);
        }

        // Xóa OTP khỏi session để tránh bị lợi dụng
        session.removeAttribute("otp");
    }
}