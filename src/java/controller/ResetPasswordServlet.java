package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.TaiKhoanService;

import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetPassword"})
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TaiKhoanService taiKhoanService;

    @Override
    public void init() throws ServletException {
        super.init();
        taiKhoanService = new TaiKhoanService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu nhập lại có khớp không
        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu không khớp. Vui lòng thử lại.");
            request.getRequestDispatcher("pages/resetPassword.jsp").forward(request, response);
            return;
        }

        // Lấy username từ session
        String username = (String) request.getSession().getAttribute("resetUsername");
        if (username == null) {
            request.setAttribute("error", "Phiên làm việc không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu qua Service
        try {
            boolean isUpdated = taiKhoanService.updatePassword(username, newPassword);
            if (isUpdated) {
                request.getSession().removeAttribute("resetUsername"); // Xóa session reset
                response.sendRedirect("pages/login.jsp");
            } else {
                request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
                request.getRequestDispatcher("pages/resetPassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống. Vui lòng thử lại.");
            request.getRequestDispatcher("pages/resetPassword.jsp").forward(request, response);
        }
    }
}