/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DAOTaiKhoan;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.TaiKhoan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminTaiKhoanServlet", urlPatterns = {"/taikhoans"})
public class AdminTaiKhoanServlet extends HttpServlet {

    private DAOTaiKhoan dAOTaiKhoan;

    @Override
    public void init() throws ServletException {
        dAOTaiKhoan = new DAOTaiKhoan();
    }

    private void listTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<TaiKhoan> danhSach = dAOTaiKhoan.getAll();

        int pageSize = 10; // Số lượng tài khoản trên mỗi trang
        int totalTaiKhoans = danhSach.size();
        int totalPages = (int) Math.ceil((double) totalTaiKhoans / pageSize);

        // Lấy số trang từ request, nếu không có thì mặc định là trang 1
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
                if (currentPage > totalPages) {
                    currentPage = totalPages;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, totalTaiKhoans);
        List<TaiKhoan> danhSachPhanTrang = danhSach.subList(start, end);

        request.setAttribute("taiKhoans", danhSachPhanTrang);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("jsp/taikhoan/listTaiKhoan.jsp").forward(request, response);
    }

    // Hiển thị form thêm mới
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("jsp/taikhoan/createTaiKhoan.jsp").forward(request, response);
    }

    // Thêm loại khách sạn
    protected void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy các tham số từ form
        String tenTaiKhoan = request.getParameter("tenTaiKhoan");
        String matKhau = request.getParameter("matKhau");
        String hoTen = request.getParameter("hoTen");
        boolean gioiTinh = Boolean.parseBoolean(request.getParameter("gioiTinh"));
        String soDienThoai = request.getParameter("soDienThoai");
        String email = request.getParameter("email");
        int idRole = Integer.parseInt(request.getParameter("idRole"));

        // Tạo đối tượng TaiKhoan từ dữ liệu nhập vào
        TaiKhoan taiKhoan = new TaiKhoan();
        taiKhoan.setTenTaiKhoan(tenTaiKhoan);
        taiKhoan.setMatKhau(matKhau);
        taiKhoan.setHoTen(hoTen);
        taiKhoan.setGioiTinh(gioiTinh);
        taiKhoan.setSoDienThoai(soDienThoai);
        taiKhoan.setEmail(email);
        taiKhoan.setIdRole(idRole);

        boolean isSuccess = dAOTaiKhoan.insert(taiKhoan);

        // Xử lý kết quả và điều hướng
        if (isSuccess) {
            // Nếu thành công, chuyển hướng về trang danh sách tài khoản
            response.sendRedirect("taikhoans?action=list");
        } else {
            // Nếu thất bại, hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Thêm tài khoản thất bại. Vui lòng thử lại.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("createTaiKhoan.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String tenTaiKhoan = request.getParameter("tenTaiKhoan");
        TaiKhoan taiKhoan = dAOTaiKhoan.getByTenTaiKhoan(tenTaiKhoan);

        if (taiKhoan != null) {
            request.setAttribute("taiKhoan", taiKhoan);
            request.getRequestDispatcher("jsp/taikhoan/updateTaiKhoan.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Tài khoản không tồn tại!");
            response.sendRedirect("taikhoans?action=list");
        }
    }

    private void updateTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // Lấy dữ liệu từ form
        String tenTaiKhoan = request.getParameter("tenTaiKhoan");
        String matKhau = request.getParameter("matKhau");
        String hoTen = request.getParameter("hoTen");
        boolean gioiTinh = Boolean.parseBoolean(request.getParameter("gioiTinh"));
        String soDienThoai = request.getParameter("soDienThoai");
        String email = request.getParameter("email");
        int idRole = Integer.parseInt(request.getParameter("idRole"));

        TaiKhoan taiKhoan = new TaiKhoan();
        if (taiKhoan != null) {
            // Cập nhật thông tin mới
            taiKhoan.setTenTaiKhoan(tenTaiKhoan);
            taiKhoan.setMatKhau(matKhau);
            taiKhoan.setHoTen(hoTen);
            taiKhoan.setGioiTinh(gioiTinh);
            taiKhoan.setSoDienThoai(soDienThoai);
            taiKhoan.setEmail(email);
            taiKhoan.setIdRole(idRole);

            // Gọi DAO để cập nhật dữ liệu trong DB
            dAOTaiKhoan.update(taiKhoan);
            response.sendRedirect("taikhoans?action=list");
        } else {
            request.setAttribute("message", "Tài khoản không tồn tại!");
            request.getRequestDispatcher("jsp/taikhoan/updateTaiKhoan.jsp").forward(request, response);
        }
    }
    
    private void searchTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("name");
        List<TaiKhoan> danhSach = dAOTaiKhoan.getAll();

        // Lọc danh sách thành phố theo từ khóa
        List<TaiKhoan> ketQuaTimKiem = danhSach.stream()
                .filter(taiKhoan -> taiKhoan.getTenTaiKhoan().toLowerCase().contains(keyword.toLowerCase()))
                .toList();

        request.setAttribute("taiKhoans", ketQuaTimKiem);
        request.getRequestDispatcher("jsp/taikhoan/listTaiKhoan.jsp").forward(request, response);
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
            out.println("<title>Servlet TaiKhoanServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TaiKhoanServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                listTaiKhoan(request, response);
                break;
            case "search":
                searchTaiKhoan(request, response);
                break;
            case "create":
                showCreateForm(request, response);
                break;
            case "update": {
                try {
                    showUpdateForm(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(AdminTaiKhoanServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            default:
                listTaiKhoan(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "create":
                create(request, response);
                break;
            case "update": {
                try {
                    updateTaiKhoan(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(AdminTaiKhoanServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            default:
                listTaiKhoan(request, response);
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
