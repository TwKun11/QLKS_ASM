/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAODatPhong;
import dao.SQLConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DatPhong;
import model.TaiKhoan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "HuyDatPhongServlet", urlPatterns = "/huydatphong")
public class HuyDatPhongServlet extends HttpServlet {
    DAODatPhong daoDatPhong = new DAODatPhong();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HuyDatPhongServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HuyDatPhongServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa có
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/pages/login.jsp");
            return;
        }
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        String username = user.getTenTaiKhoan();
        System.out.println("[DEBUG] Username from session: " + username);

        try {
            List<DatPhong> bookings = daoDatPhong.getAllByUser(username);
            if (bookings == null) {
                bookings = new ArrayList<>();
            }
            System.out.println("[DEBUG] Số đơn đặt phòng: " + bookings.size());

            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/pages/lichsu.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        String username = user.getTenTaiKhoan();
        System.out.println("[DEBUG] Username from session (POST): " + username);

        String idParam = request.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
            return;
        }

        String message = "Hủy đặt phòng thất bại!";
        try (Connection conn = SQLConnection.getConnection()) {
            if (daoDatPhong.update(id)) {
                message = "Hủy đặt phòng thành công!";
            }

            List<DatPhong> bookings = daoDatPhong.getAllByUser(username);
            if (bookings == null) {
                bookings = new ArrayList<>();
            }

            request.setAttribute("bookings", bookings);
            request.setAttribute("message", message);
            request.getRequestDispatcher("/pages/lichsu.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
