package controller;

import dao.DAOTaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TaiKhoan;
import utils.EmailUtility;
import utils.OTPGenerator;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        int idRole = 2;

        if (!Pattern.matches("^[a-zA-Z0-9]{5,20}$", username)) {
            request.setAttribute("errorRegister", "Tên tài khoản chỉ chứa chữ cái, số và dài từ 5-20 ký tự!");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        if (!Pattern.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$", password)) {
            request.setAttribute("errorRegister", "Mật khẩu phải có ít nhất 6 ký tự, gồm chữ và số!");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorRegister", "Mật khẩu xác nhận không trùng khớp!");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        if (!Pattern.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", email)) {
            request.setAttribute("errorRegister", "Email không hợp lệ!");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        if (!Pattern.matches("^\\d{10}$", phone)) { 
            request.setAttribute("errorRegister", "Số điện thoại phải có 10 chữ số!");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        DAOTaiKhoan dao = new DAOTaiKhoan();
        try {
            if (dao.getByTenTaiKhoan(username) != null) {
                request.setAttribute("errorRegister", "Tên tài khoản đã tồn tại!");
                request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
                return;
            }

            TaiKhoan tk = new TaiKhoan(username, password, fullName, gender, phone, email, idRole);
            
            // Generate OTP and send email
            String otp = OTPGenerator.generateOTP();
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("pendingUser", tk);
            EmailUtility.sendOTP(email, otp);
            
            // Redirect to OTP verification page
            response.sendRedirect("pages/verifyOTP.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorRegister", "Lỗi hệ thống! Hãy thử lại sau.");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorRegister", "Lỗi gửi email OTP! Hãy thử lại.");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }
}
