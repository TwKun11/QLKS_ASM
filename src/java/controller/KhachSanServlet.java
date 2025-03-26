package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.KhachSanService;
import service.LoaiKhachSanService;
import model.KhachSan;
import model.LoaiKhachSan;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "KhachSanServlet", urlPatterns = {"/khachsan"})
public class KhachSanServlet extends HttpServlet {
    
    // Thêm các instance của Service
    private KhachSanService khachSanService;
    private LoaiKhachSanService loaiKhachSanService;

    private static final int PAGE_SIZE = 5;

    @Override
    public void init() throws ServletException {
        super.init();
        khachSanService = new KhachSanService();
        loaiKhachSanService = new LoaiKhachSanService();
    }

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy tham số từ request
        String loaiKhachSanParam = request.getParameter("loaiKhachSan");
        String danhGiaParam = request.getParameter("danhGia");
        String giapBienParam = request.getParameter("giapBien");
        String thanhPhoParam = request.getParameter("thanhPho");
        String pageParam = request.getParameter("page");

        Integer loaiKhachSan = null;
        Integer danhGia = null;
        Boolean giapBien = null;
        Integer idThanhPho = null;
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
            idThanhPho = Integer.parseInt(thanhPhoParam);
        }
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        try {
            List<KhachSan> listKhachSan = khachSanService.getKhachSanByFilter(loaiKhachSan, danhGia, giapBien, idThanhPho, page, PAGE_SIZE);
            int totalItems = khachSanService.countKhachSanByFilter(loaiKhachSan, danhGia, giapBien, idThanhPho);

            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            List<LoaiKhachSan> categoriesKhachSans = loaiKhachSanService.getAll();
            request.setAttribute("listLoaiKhachSan", categoriesKhachSans);
            request.setAttribute("listKhachSan", listKhachSan);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("loaiKhachSan", loaiKhachSan);
            request.setAttribute("danhGia", danhGia);
            request.setAttribute("giapBien", giapBien);
            request.setAttribute("idThanhPho", idThanhPho);

            request.getRequestDispatcher("/pages/khachsan.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy dữ liệu khách sạn");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<KhachSan> listKhachSan = null;

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                listKhachSan = khachSanService.searchKhachSan(keyword);
            } else {
                listKhachSan = khachSanService.getAll();
            }

            request.setAttribute("listKhachSan", listKhachSan);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/pages/khachsan.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy dữ liệu khách sạn");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}