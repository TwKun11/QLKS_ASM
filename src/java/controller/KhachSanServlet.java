/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAOKhachSan;
import dao.DAOLoaiKhachSan;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;
import model.KhachSan;
import model.LoaiKhachSan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "KhachSanServlet", urlPatterns = {"/khachsan"})
public class KhachSanServlet extends HttpServlet {
    
    // Thêm các instance của DAO
    private DAOKhachSan daoKhachSan = new DAOKhachSan();
    private DAOLoaiKhachSan daoLoaiKhachSan = new DAOLoaiKhachSan();

    private static final int PAGE_SIZE = 5;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet KhachSanServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet KhachSanServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số từ request
        String loaiKhachSanParam = request.getParameter("loaiKhachSan");
        String danhGiaParam = request.getParameter("danhGia");
        String giapBienParam = request.getParameter("giapBien");
        String thanhPhoParam = request.getParameter("thanhPho"); // Thêm tham số thành phố
        String pageParam = request.getParameter("page");

        Integer loaiKhachSan = null;
        Integer danhGia = null;
        Boolean giapBien = null;
        Integer idThanhPho = null; // Thêm biến idThanhPho
        int page = 1;

        // Chuyển đổi tham số thành kiểu dữ liệu phù hợp
        if (loaiKhachSanParam != null && !loaiKhachSanParam.isEmpty()) {
            loaiKhachSan = Integer.parseInt(loaiKhachSanParam);
        }
        if (danhGiaParam != null && !danhGiaParam.isEmpty()) {
            danhGia = Integer.parseInt(danhGiaParam);
        }
        if (giapBienParam != null && !giapBienParam.isEmpty()) {
            giapBien = Boolean.parseBoolean(giapBienParam);
        }
        if (thanhPhoParam != null && !thanhPhoParam.isEmpty()) {
            idThanhPho = Integer.parseInt(thanhPhoParam); // Chuyển đổi idThanhPho
        }
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        try {
            List<KhachSan> listKhachSan = daoKhachSan.getKhachSanByFilter(loaiKhachSan, danhGia, giapBien, idThanhPho, page, PAGE_SIZE);
            int totalItems = daoKhachSan.countKhachSanByFilter(loaiKhachSan, danhGia, giapBien, idThanhPho);

            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            List<LoaiKhachSan> categoriesKhachSans = daoLoaiKhachSan.getAll();
            request.setAttribute("listLoaiKhachSan", categoriesKhachSans);
            request.setAttribute("listKhachSan", listKhachSan);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("loaiKhachSan", loaiKhachSan);
            request.setAttribute("danhGia", danhGia);
            request.setAttribute("giapBien", giapBien);
            request.setAttribute("idThanhPho", idThanhPho); // Thêm thuộc tính idThanhPho

            request.getRequestDispatcher("/pages/khachsan.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy dữ liệu khách sạn");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<KhachSan> listKhachSan = null;

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                listKhachSan = daoKhachSan.searchKhachSan(keyword);
            } else {
                listKhachSan = daoKhachSan.getAll(); // Lấy tất cả nếu không có keyword
            }

            request.setAttribute("listKhachSan", listKhachSan);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/pages/khachsan.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy dữ liệu khách sạn");
        }
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