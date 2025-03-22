/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nonatomic/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAODatPhong;
import dao.DAOPhong;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DatPhong;
import model.Phong;
import model.TaiKhoan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "XacNhanDatPhong", urlPatterns = {"/xacnhandatphong"})
public class XacNhanDatPhong extends HttpServlet {
    
    // Thêm instance của DAO
    private DAODatPhong daoDatPhong = new DAODatPhong();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private double tinhGiaThue(String giaMotDemStr, String ngayDenStr, String ngayTraStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date ngayDen = sdf.parse(ngayDenStr);
            Date ngayTra = sdf.parse(ngayTraStr);
            long soNgay = (ngayTra.getTime() - ngayDen.getTime()) / (1000 * 60 * 60 * 24);
            int giaMotDem = Integer.parseInt(giaMotDemStr);
            System.out.println("hello");
            return giaMotDem * Math.max(soNgay, 1);
        } catch (ParseException | NumberFormatException e) {
            e.printStackTrace();
            return 0; // Trả về 0 nếu có lỗi
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet XacNhanDatPhong</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet XacNhanDatPhong at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("pages/login.jsp");
            return;
        }
        String tenPhong = request.getParameter("tenPhong");
        String idPhong = request.getParameter("idPhong");
        String ngayDen = request.getParameter("ngayDen");
        String ngayTra = request.getParameter("ngayTra");
        String giaThueStr = request.getParameter("giaThue");
        int giaThue = (int) tinhGiaThue(giaThueStr, ngayDen, ngayTra);
       

        if (idPhong == null || ngayDen == null || ngayTra == null) {
            request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("/datphong/datPhong.jsp").forward(request, response);
            return;
        }

        request.setAttribute("giaThue", giaThue);
        request.setAttribute("tenPhong", tenPhong);
        request.setAttribute("username", user);
        request.setAttribute("idPhong", idPhong);
        request.setAttribute("ngayDen", ngayDen);
        request.setAttribute("ngayTra", ngayTra);
        request.setAttribute("message", "Vui lòng kiểm tra lại thông tin đặt phòng!");

        request.getRequestDispatcher("/datphong/xacnhandatphong.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int giaThue = Integer.parseInt(request.getParameter("giaThue"));
        String idPhong = request.getParameter("idPhong");
        String ngayDenStr = request.getParameter("ngayDen");
        String ngayTraStr = request.getParameter("ngayTra");
        String dichVu = request.getParameter("dichVu") != null ? request.getParameter("dichVu") : "Không có";

        if (idPhong == null || ngayDenStr == null || ngayTraStr == null) {
            request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("/datphong/datPhong.jsp").forward(request, response);
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date ngayDen = sdf.parse(ngayDenStr);
            Date ngayTra = sdf.parse(ngayTraStr);
            Date ngayDat = new Date(); // Lấy ngày hiện tại làm ngày đặt

            DatPhong datPhong = new DatPhong();
            datPhong.setTaiKhoan(user.getTenTaiKhoan());
            datPhong.setIdPhong(Integer.parseInt(idPhong));
            datPhong.setNgayDat(ngayDat);
            datPhong.setNgayDen(ngayDen);
            datPhong.setNgayTra(ngayTra);
            datPhong.setDichVu(dichVu);
            datPhong.setGhiChu("Thanh toán khi nhận phong");
            datPhong.setThanhTien(giaThue); // Giá tạm thời, cần tính toán dựa vào DB
            datPhong.setDaHuy(false);

            boolean isInserted = daoDatPhong.insert(datPhong);

            if (isInserted) {
                request.setAttribute("message", "Đặt phòng thành công! Mã đơn: " + datPhong.getId());
            } else {
                request.setAttribute("error", "Đặt phòng thất bại! Vui lòng thử lại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý dữ liệu.");
        }

        request.getRequestDispatcher("/datphong/datphongthanhcong.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}