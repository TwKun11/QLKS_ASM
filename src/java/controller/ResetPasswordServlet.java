package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.SQLConnection;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetPassword"})
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        // Cập nhật mật khẩu trong database
        try (Connection conn = SQLConnection.getConnection()) {
            String sql = "UPDATE TaiKhoan SET MatKhau = ? WHERE TenTaiKhoan = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newPassword); // Lưu mật khẩu trực tiếp
                stmt.setString(2, username);
                
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    request.getSession().removeAttribute("resetUsername"); // Xóa session reset
                    response.sendRedirect("pages/login.jsp");
                } else {
                    request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
                    request.getRequestDispatcher("pages/resetPassword.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối database.");
            request.getRequestDispatcher("pages/resetPassword.jsp").forward(request, response);
        }
    }
}
