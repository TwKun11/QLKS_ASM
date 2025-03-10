package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.TaiKhoan;
import dao.DAOTaiKhoan;
import java.sql.SQLException;

@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/verifyOTP"})
public class VerifyOTPServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String enteredOTP = request.getParameter("otp");
        String sessionOTP = (String) session.getAttribute("otp");
        TaiKhoan pendingUser = (TaiKhoan) session.getAttribute("pendingUser");

        if (enteredOTP != null && sessionOTP != null && enteredOTP.equals(sessionOTP)) {
            DAOTaiKhoan dao = new DAOTaiKhoan();
            dao.insert(pendingUser);
            session.removeAttribute("otp");
            session.removeAttribute("pendingUser");
            response.sendRedirect("/roombooking/pages/success.jsp");
        } else {
            request.setAttribute("errorOTP", "Mã OTP không đúng! Hãy thử lại.");
            request.getRequestDispatcher("/roombooking/pages/verifyOTP.jsp").forward(request, response);
        }
    }
}
