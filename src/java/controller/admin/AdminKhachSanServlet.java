/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DAOKhachSan;
import dao.DAOLoaiKhachSan;
import dao.DAOThanhPho;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.KhachSan;
import model.LoaiKhachSan;
import model.ThanhPho;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminKhachSanServlet", urlPatterns = {"/khachsans"})
public class AdminKhachSanServlet extends HttpServlet {

    private DAOKhachSan daoKhachSan;
    DAOThanhPho DAOThanhPho = new DAOThanhPho();
    DAOLoaiKhachSan DAOLoaiKhachSan = new DAOLoaiKhachSan();

    @Override
    public void init() throws ServletException {
        daoKhachSan = new DAOKhachSan();
    }

    private void listKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<KhachSan> danhSach = daoKhachSan.getAll();
        request.setAttribute("khachsans", danhSach);
        request.getRequestDispatcher("jsp/khachsan/listKhachSan.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách Thành phố
            List<ThanhPho> danhSachThanhPho = DAOThanhPho.getAll();
            request.setAttribute("danhSachThanhPho", danhSachThanhPho);

            // Lấy danh sách Loại khách sạn
            List<LoaiKhachSan> danhSachLoaiKhachSan = DAOLoaiKhachSan.getAll();
            request.setAttribute("danhSachLoaiKhachSan", danhSachLoaiKhachSan);

            // Kiểm tra dữ liệu có tồn tại không
            if (danhSachThanhPho == null || danhSachThanhPho.isEmpty()
                    || danhSachLoaiKhachSan == null || danhSachLoaiKhachSan.isEmpty()) {
                request.setAttribute("errorMessage", "Không có dữ liệu cần thiết để tạo khách sạn.");
                request.getRequestDispatcher("khachsans?action=list").forward(request, response);
                return;
            }

            // Chuyển đến trang JSP tạo khách sạn
            request.getRequestDispatcher("jsp/khachsan/createKhachSan.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi khi hiển thị form tạo khách sạn: " + e.getMessage(), e);
            response.sendRedirect("khachsans?action=list"); // Điều hướng nếu có lỗi
        }
    }

    private void insertKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String ten = request.getParameter("ten");
            String diaChi = request.getParameter("diaChi");
            String soDienThoai = request.getParameter("soDienThoai");
            int cachTrungTam = Integer.parseInt(request.getParameter("cachTrungTam"));
            String moTa = request.getParameter("moTa");
            boolean giapBien = Boolean.parseBoolean(request.getParameter("giapBien"));
            int danhGia = Integer.parseInt(request.getParameter("danhGia"));
            int buaAn = Integer.parseInt(request.getParameter("buaAn"));
            String tenThanhPho = request.getParameter("tenThanhPho");
            String tenLoaiKhachSan = request.getParameter("tenLoaiKhachSan");
            String urlHinhAnhThanhPho = request.getParameter("urlHinhAnhThanhPho");

            // Lấy ID từ tên của Thành Phố và Loại Khách Sạn
            ThanhPho thanhPho = DAOThanhPho.getByName(tenThanhPho);
            LoaiKhachSan loaiKhachSan = DAOLoaiKhachSan.getByName(tenLoaiKhachSan);

            if (thanhPho == null || loaiKhachSan == null) {
                request.setAttribute("errorMessage", "Thành phố hoặc loại khách sạn không hợp lệ!");
                showCreateForm(request, response);
                return;
            }

            int idThanhPho = thanhPho.getId();
            int idLoaiKhachSan = loaiKhachSan.getId();

            // Tạo đối tượng khách sạn
            KhachSan ks = new KhachSan(0, ten, diaChi, soDienThoai, cachTrungTam, moTa, giapBien, danhGia, buaAn, idThanhPho, tenThanhPho, idLoaiKhachSan, tenLoaiKhachSan, urlHinhAnhThanhPho);

            // Lưu vào DB
            daoKhachSan.insert(ks);

            // Chuyển hướng về danh sách
            response.sendRedirect("khachsans?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm khách sạn!");
            showCreateForm(request, response);
        }
    }

    private void searchKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("name");
        List<KhachSan> danhSach = daoKhachSan.getAll();

        List<KhachSan> ketQuaTimKiem = danhSach.stream()
                .filter(ks -> ks.getTen().toLowerCase().contains(keyword.toLowerCase())
                || ks.getDiaChi().toLowerCase().contains(keyword.toLowerCase()))
                .toList();

        request.setAttribute("khachsans", ketQuaTimKiem);
        request.getRequestDispatcher("jsp/khachsan/listKhachSan.jsp").forward(request, response);
    }

    private void updateKhachSan(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            KhachSan existingKhachSan = daoKhachSan.getById(id);

            if (existingKhachSan == null) {
                request.setAttribute("errorMessage", "Khách sạn không tồn tại!");
                response.sendRedirect("khachsans?action=list");
                return;
            }

            String ten = request.getParameter("ten");
            String diaChi = request.getParameter("diaChi");
            String soDienThoai = request.getParameter("soDienThoai");
            int cachTrungTam = Integer.parseInt(request.getParameter("cachTrungTam"));
            String moTa = request.getParameter("moTa");
            boolean giapBien = Boolean.parseBoolean(request.getParameter("giapBien"));
            int danhGia = Integer.parseInt(request.getParameter("danhGia"));
            int buaAn = Integer.parseInt(request.getParameter("buaAn"));
            String tenThanhPho = request.getParameter("tenThanhPho");
            String tenLoaiKhachSan = request.getParameter("tenLoaiKhachSan");
            String urlHinhAnhThanhPho = request.getParameter("urlHinhAnhThanhPho");

            // Lấy ID của Thành phố và Loại khách sạn
            ThanhPho thanhPho = DAOThanhPho.getByName(tenThanhPho);
            LoaiKhachSan loaiKhachSan = DAOLoaiKhachSan.getByName(tenLoaiKhachSan);

            if (thanhPho == null || loaiKhachSan == null) {
                request.setAttribute("errorMessage", "Thành phố hoặc loại khách sạn không hợp lệ!");
                showUpdateForm(request, response);
                return;
            }

            // Cập nhật thông tin khách sạn
            existingKhachSan.setTen(ten);
            existingKhachSan.setDiaChi(diaChi);
            existingKhachSan.setSoDienThoai(soDienThoai);
            existingKhachSan.setCachTrungTam(cachTrungTam);
            existingKhachSan.setMoTa(moTa);
            existingKhachSan.setGiapBien(giapBien);
            existingKhachSan.setDanhGia(danhGia);
            existingKhachSan.setBuaAn(buaAn);
            existingKhachSan.setIdThanhPho(thanhPho.getId());
            existingKhachSan.setTenThanhPho(tenThanhPho);
            existingKhachSan.setIdLoaiKhachSan(loaiKhachSan.getId());
            existingKhachSan.setTenLoaiKhachSan(tenLoaiKhachSan);
            existingKhachSan.setUrlHinhAnhThanhPho(urlHinhAnhThanhPho);

            daoKhachSan.update(existingKhachSan);

            response.sendRedirect("khachsans?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ!");
            showUpdateForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật khách sạn!");
            showUpdateForm(request, response);
        }
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            KhachSan khachSan = daoKhachSan.getById(id);

            if (khachSan == null) {
                request.setAttribute("errorMessage", "Khách sạn không tồn tại!");
                response.sendRedirect("khachsans?action=list");
                return;
            }

            // Lấy danh sách Thành phố và Loại khách sạn để hiển thị trong form
            List<ThanhPho> danhSachThanhPho = DAOThanhPho.getAll();
            List<LoaiKhachSan> danhSachLoaiKhachSan = DAOLoaiKhachSan.getAll();

            request.setAttribute("khachSan", khachSan);
            request.setAttribute("danhSachThanhPho", danhSachThanhPho);
            request.setAttribute("danhSachLoaiKhachSan", danhSachLoaiKhachSan);

            request.getRequestDispatcher("jsp/khachsan/updateKhachSan.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID khách sạn không hợp lệ!");
            response.sendRedirect("khachsans?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi hiển thị form cập nhật!");
            response.sendRedirect("khachsans?action=list");
        }
    }

    private void deleteKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID từ request
            int id = Integer.parseInt(request.getParameter("id"));

            // Gọi hàm delete trong DAO
            boolean isDeleted = daoKhachSan.delete(id);

            if (!isDeleted) {
                request.setAttribute("errorMessage", "Xóa vĩnh viễn thất bại!");
                listKhachSan(request, response);
                return;
            }

            // Chuyển hướng về danh sách khách sạn sau khi xóa thành công
            response.sendRedirect("khachsans?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ!");
            listKhachSan(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi xóa vĩnh viễn khách sạn!");
            listKhachSan(request, response);
        }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "update":
                showUpdateForm(request, response);
                break;
            case "search":
                searchKhachSan(request, response);
                break;
            case "delete":
                deleteKhachSan(request, response);
                break;
            default:
                listKhachSan(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                insertKhachSan(request, response);
                break;
            case "update":
                updateKhachSan(request, response);
                break;
            default:
                response.sendRedirect("khachsans?action=list");
                break;
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
