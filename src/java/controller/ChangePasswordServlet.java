package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.TaiKhoan;
import dao.DAOTaiKhoan;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu cũ
        DAOTaiKhoan tkDAO = new DAOTaiKhoan();
        if (!tkDAO.checkPassword(user.getTenTaiKhoan(), oldPassword)) {
            request.setAttribute("message", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("/pages/changepassword.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(newPassword)) {
            request.setAttribute("message", "Mật khẩu mới không được trùng với mật khẩu cũ.");
            request.getRequestDispatcher("/pages/changepassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "Mật khẩu mới không khớp.");
            request.getRequestDispatcher("/pages/changepassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        boolean isUpdated = tkDAO.updatePassword(user.getTenTaiKhoan(), newPassword);
        if (isUpdated) {
            request.setAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại.");
        }

        request.getRequestDispatcher("/pages/changepassword.jsp").forward(request, response);
    }
}
