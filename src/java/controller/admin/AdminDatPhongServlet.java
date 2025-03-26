/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import service.DatPhongService;
import service.PhongService;
import service.TaiKhoanService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.DatPhong;
import model.Phong;
import model.TaiKhoan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminDatPhongServlet", urlPatterns = {"/datphongs"})
public class AdminDatPhongServlet extends HttpServlet {

    private DatPhongService datPhongService;
    private PhongService phongService = new PhongService();
    private TaiKhoanService taiKhoanService = new TaiKhoanService();

    @Override
    public void init() throws ServletException {
        datPhongService = new DatPhongService();
    }

    private void listDatPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DatPhong> danhSach = datPhongService.getAll();
        request.setAttribute("datphongs", danhSach);
        request.getRequestDispatcher("jsp/datphong/listDatPhong.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách Phòng
            List<Phong> danhSachPhong = phongService.getAll();
            request.setAttribute("danhSachPhong", danhSachPhong);

            List<TaiKhoan> danhSachTaiKhoan = taiKhoanService.getAll();
            request.setAttribute("danhSachTaiKhoan", danhSachTaiKhoan);

            // Kiểm tra dữ liệu có tồn tại không
            if (danhSachPhong == null || danhSachPhong.isEmpty()) {
                request.setAttribute("errorMessage", "Không có dữ liệu cần thiết để tạo đặt phòng.");
                request.getRequestDispatcher("datphongs?action=list").forward(request, response);
                return;
            }

            if (danhSachTaiKhoan == null || danhSachTaiKhoan.isEmpty()) {
                request.setAttribute("errorMessage", "Không có dữ liệu cần thiết để tạo đặt phòng.");
                request.getRequestDispatcher("datphongs?action=list").forward(request, response);
                return;
            }

            // Chuyển đến trang JSP tạo đặt phòng
            request.getRequestDispatcher("jsp/datphong/createDatPhong.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi khi hiển thị form đặt phòng: " + e.getMessage(), e);
            response.sendRedirect("datphongs?action=list"); // Điều hướng nếu có lỗi
        }
    }

    private void insertDatPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ request và kiểm tra dữ liệu đầu vào
            String taiKhoan = request.getParameter("tenTaiKhoan");
            String idPhongStr = request.getParameter("idPhong");
            String ngayDatStr = request.getParameter("ngayDat");
            String ngayDenStr = request.getParameter("ngayDen");
            String ngayTraStr = request.getParameter("ngayTra");
            String dichVu = request.getParameter("dichVu");
            String ghiChu = request.getParameter("ghiChu");
            String thanhTienStr = request.getParameter("thanhTien");

            if (taiKhoan == null || idPhongStr == null || ngayDatStr == null || ngayDenStr == null
                    || ngayTraStr == null || dichVu == null || ghiChu == null || thanhTienStr == null) {
                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin đặt phòng!");
                showCreateForm(request, response);
                return;
            }

            // Chuyển đổi giá trị số
            int idPhong, thanhTien;
            java.sql.Date ngayDat, ngayDen, ngayTra;
            try {
                idPhong = Integer.parseInt(idPhongStr);
                thanhTien = Integer.parseInt(thanhTienStr);
                ngayDat = java.sql.Date.valueOf(ngayDatStr);
                ngayDen = java.sql.Date.valueOf(ngayDenStr);
                ngayTra = java.sql.Date.valueOf(ngayTraStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Dữ liệu không hợp lệ! Vui lòng kiểm tra lại.");
                showCreateForm(request, response);
                return;
            }

            // Kiểm tra xem phòng có tồn tại không
            Phong phong = phongService.getById(idPhong);
            if (phong == null) {
                request.setAttribute("errorMessage", "Phòng không tồn tại!");
                showCreateForm(request, response);
                return;
            }

            // Tạo đối tượng Đặt Phòng
            DatPhong datPhong = new DatPhong(0, taiKhoan, idPhong, ngayDat, ngayDen, ngayTra, dichVu, ghiChu, thanhTien, false);

            // Thêm vào cơ sở dữ liệu qua service
            datPhongService.insert(datPhong);

            // Chuyển hướng về danh sách đặt phòng sau khi thêm thành công
            response.sendRedirect("datphongs?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm đặt phòng!");
            showCreateForm(request, response);
        }
    }

    private void cancelDatPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            datPhongService.update(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("datphong");
    }

    private void searchDatPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("name");
        List<DatPhong> danhSach = datPhongService.getAll();

        List<DatPhong> ketQuaTimKiem = danhSach.stream()
                .filter(ks -> ks.getTaiKhoan().toLowerCase().contains(keyword.toLowerCase()))
                .toList();

        request.setAttribute("datphongs", ketQuaTimKiem);
        request.getRequestDispatcher("jsp/datphong/listDatPhong.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID từ request
            int id = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin đặt phòng từ service
            DatPhong datPhong = datPhongService.getByID(id);

            if (datPhong == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin đặt phòng!");
                listDatPhong(request, response);
                return;
            }

            // Lấy danh sách phòng và tài khoản để hiển thị trong dropdown
            List<Phong> danhSachPhong = phongService.getAll();
            List<TaiKhoan> danhSachTaiKhoan = taiKhoanService.getAll();

            // Gửi dữ liệu lên JSP
            request.setAttribute("datPhong", datPhong);
            request.setAttribute("danhSachPhong", danhSachPhong);
            request.setAttribute("danhSachTaiKhoan", danhSachTaiKhoan);

            // Chuyển đến trang cập nhật
            request.getRequestDispatcher("jsp/datphong/updateDatPhong.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi khi hiển thị form cập nhật: " + e.getMessage(), e);
            response.sendRedirect("datphongs?action=list");
        }
    }

    private void updateDatPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ request
            int id = Integer.parseInt(request.getParameter("id"));
            String taiKhoan = request.getParameter("taiKhoan");
            int idPhong = Integer.parseInt(request.getParameter("idPhong"));

            Date ngayDat = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("ngayDat"));
            Date ngayDen = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("ngayDen"));
            Date ngayTra = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("ngayTra"));
            String dichVu = request.getParameter("dichVu");
            String ghiChu = request.getParameter("ghiChu");
            int thanhTien = Integer.parseInt(request.getParameter("thanhTien"));

            // Tạo đối tượng DatPhong với thông tin mới
            DatPhong datPhong = new DatPhong(id, taiKhoan, idPhong,
                    new java.sql.Date(ngayDat.getTime()),
                    new java.sql.Date(ngayDen.getTime()),
                    new java.sql.Date(ngayTra.getTime()),
                    dichVu, ghiChu, thanhTien, false);

            // Cập nhật vào cơ sở dữ liệu qua service
            boolean isUpdated = datPhongService.update(datPhong);

            if (!isUpdated) {
                request.setAttribute("errorMessage", "Cập nhật thất bại!");
                showUpdateForm(request, response);
                return;
            }

            // Chuyển hướng về danh sách đặt phòng sau khi cập nhật thành công
            response.sendRedirect("datphongs?action=list");
        } catch (ParseException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ! Vui lòng kiểm tra lại.");
            showUpdateForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật đặt phòng!");
            showUpdateForm(request, response);
        }
    }

    private void removeDatPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID từ request
            int id = Integer.parseInt(request.getParameter("id"));

            // Gọi hàm remove trong service
            boolean isRemoved = datPhongService.delete(id);

            if (!isRemoved) {
                request.setAttribute("errorMessage", "Xóa vĩnh viễn thất bại!");
                listDatPhong(request, response);
                return;
            }

            // Chuyển hướng về danh sách đặt phòng sau khi xóa thành công
            response.sendRedirect("datphongs?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ!");
            listDatPhong(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi xóa vĩnh viễn đặt phòng!");
            listDatPhong(request, response);
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
            out.println("<title>Servlet DatPhongServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DatPhongServlet at " + request.getContextPath() + "</h1>");
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
            case "search":
                searchDatPhong(request, response);
                break;
            case "cancel":
                cancelDatPhong(request, response);
                break;
            case "remove":
                removeDatPhong(request, response);
                break;
            case "update":
                showUpdateForm(request, response);
                break;
            default:
                listDatPhong(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "insert":
                insertDatPhong(request, response);
                break;
            case "update":
                updateDatPhong(request, response);
                break;
            default:
                listDatPhong(request, response);
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