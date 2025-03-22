/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DAOKhachSan;
import dao.DAOPhong;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.KhachSan;
import model.Phong;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminPhongServlet", urlPatterns = {"/phongs"})
public class AdminPhongServlet extends HttpServlet {

    private DAOPhong daoPhong;
    DAOKhachSan DAOKhachSan = new DAOKhachSan();

    @Override
    public void init() throws ServletException {
        daoPhong = new DAOPhong();
    }

    private void listPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Phong> danhSach = daoPhong.getAll();
        request.setAttribute("phongs", danhSach);
        request.getRequestDispatcher("jsp/phong/listPhong.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách Khách Sạn
            List<KhachSan> danhSachKhachSan = DAOKhachSan.getAll();
            request.setAttribute("danhSachKhachSan", danhSachKhachSan);

            // Kiểm tra dữ liệu có tồn tại không
            if (danhSachKhachSan == null || danhSachKhachSan.isEmpty()
                    || danhSachKhachSan == null || danhSachKhachSan.isEmpty()) {
                request.setAttribute("errorMessage", "Không có dữ liệu cần thiết để tạo khách sạn.");
                request.getRequestDispatcher("phongs?action=list").forward(request, response);
                return;
            }

            // Chuyển đến trang JSP tạo khách sạn
            request.getRequestDispatcher("jsp/phong/createPhong.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi khi hiển thị form tạo phòng: " + e.getMessage(), e);
            response.sendRedirect("phongs?action=list"); // Điều hướng nếu có lỗi
        }
    }

    private void insertPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ request và kiểm tra dữ liệu đầu vào
            String ten = request.getParameter("ten");
            String dienTichStr = request.getParameter("dienTich");
            String giaThueStr = request.getParameter("giaThue");
            String tienNghi = request.getParameter("tienNghi");
            String moTa = request.getParameter("moTa");
            String loaiGiuongStr = request.getParameter("loaiGiuong"); // Loại giường giờ là int
            String tenKhachSan = request.getParameter("tenKhachSan");

            if (ten == null || dienTichStr == null || giaThueStr == null || tienNghi == null
                    || moTa == null || loaiGiuongStr == null || tenKhachSan == null) {
                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
                showCreateForm(request, response);
                return;
            }

            // Chuyển đổi giá trị số
            int dienTich, giaThue, loaiGiuong;
            try {
                dienTich = Integer.parseInt(dienTichStr);
                giaThue = Integer.parseInt(giaThueStr);
                loaiGiuong = Integer.parseInt(loaiGiuongStr); // Chuyển đổi từ String sang int
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Diện tích, giá thuê và loại giường phải là số hợp lệ!");
                showCreateForm(request, response);
                return;
            }

            // Lấy thông tin khách sạn từ tên
            KhachSan khachSan = DAOKhachSan.getByName(tenKhachSan);
            if (khachSan == null) {
                request.setAttribute("errorMessage", "Khách sạn không tồn tại!");
                showCreateForm(request, response);
                return;
            }

            int idKhachSan = khachSan.getId();

            // Tạo đối tượng Phòng
            Phong phong = new Phong(0, ten, dienTich, giaThue, tienNghi, moTa, loaiGiuong, idKhachSan, tenKhachSan);

            // Thêm vào cơ sở dữ liệu
            daoPhong.insert(phong);

            // Chuyển hướng về danh sách phòng sau khi thêm thành công
            response.sendRedirect("phongs?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm phòng!");
            showCreateForm(request, response);
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
            out.println("<title>Servlet PhongServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PhongServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private void searchPhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("name");
        List<Phong> danhSach = daoPhong.getAll();

        List<Phong> ketQuaTimKiem = danhSach.stream()
                .filter(p -> p.getTen().toLowerCase().contains(keyword.toLowerCase()))
                .toList();

        request.setAttribute("phongs", ketQuaTimKiem);
        request.getRequestDispatcher("jsp/phong/listPhong.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Phong phong = daoPhong.getById(id);

            if (phong == null) {
                request.setAttribute("errorMessage", "Phòng không tồn tại!");
                response.sendRedirect("phongs?action=list");
                return;
            }

            // Lấy danh sách Khách sạn
            List<KhachSan> danhSachKhachSan = DAOKhachSan.getAll();

            request.setAttribute("phong", phong);
            request.setAttribute("danhSachKhachSan", danhSachKhachSan);

            request.getRequestDispatcher("jsp/phong/updatePhong.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID Phòng không hợp lệ!");
            response.sendRedirect("phongs?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi hiển thị form cập nhật!");
            response.sendRedirect("phongs?action=list");
        }
    }

    private void updatePhong(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Phong existingPhong = daoPhong.getById(id);

            if (existingPhong == null) {
                request.setAttribute("errorMessage", "Phòng không tồn tại!");
                response.sendRedirect("phongs?action=list");
                return;
            }

            // Lấy thông tin từ form
            String ten = request.getParameter("ten");
            int dienTich = Integer.parseInt(request.getParameter("dienTich"));
            int giaThue = Integer.parseInt(request.getParameter("giaThue"));
            String tienNghi = request.getParameter("tienNghi");
            String moTa = request.getParameter("moTa");
            int loaiGiuong = Integer.parseInt(request.getParameter("loaiGiuong"));
            int idKhachSan = Integer.parseInt(request.getParameter("idKhachSan"));

            // Kiểm tra ID Khách sạn có hợp lệ không
            KhachSan khachSan = DAOKhachSan.getById(idKhachSan);
            if (khachSan == null) {
                request.setAttribute("errorMessage", "Khách sạn không hợp lệ!");
                request.setAttribute("phong", existingPhong);
                request.getRequestDispatcher("jsp/phongs/updatePhong.jsp").forward(request, response);
                return;
            }

            // Cập nhật thông tin phòng
            existingPhong.setTen(ten);
            existingPhong.setDienTich(dienTich);
            existingPhong.setGiaThue(giaThue);
            existingPhong.setTienNghi(tienNghi);
            existingPhong.setMoTa(moTa);
            existingPhong.setLoaiGiuong(loaiGiuong);
            existingPhong.setIdKhachSan(idKhachSan);
            existingPhong.setTenKhachSan(khachSan.getTen()); // Lấy tên khách sạn từ object KhachSan
            existingPhong.setKhachSan(khachSan);

            // Thực hiện cập nhật
            boolean updateSuccess = daoPhong.update(existingPhong);
            if (updateSuccess) {
                response.sendRedirect("phongs?action=list");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi cập nhật phòng!");
                request.setAttribute("phong", existingPhong);
                request.getRequestDispatcher("jsp/phong/updatePhong.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ!");
            request.getRequestDispatcher("jsp/phong/updatePhong.jsp").forward(request, response);
        }
    }

    private void deletePhong(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID từ request
            int id = Integer.parseInt(request.getParameter("id"));

            // Gọi hàm delete trong DAO
            boolean isDeleted = daoPhong.delete(id);

            if (!isDeleted) {
                request.setAttribute("errorMessage", "Xóa vĩnh viễn thất bại!");
                listPhong(request, response);
                return;
            }

            // Chuyển hướng về danh sách phòng sau khi xóa thành công
            response.sendRedirect("phongs?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ!");
            listPhong(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi xóa vĩnh viễn phòng!");
            listPhong(request, response);
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
            case "delete":
                deletePhong(request, response);
                break;
            case "search":
                searchPhong(request, response);
                break;
            default:
                listPhong(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                insertPhong(request, response);
                break;
            case "update":
                updatePhong(request, response);
                break;
            case "list":
                listPhong(request, response);
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
