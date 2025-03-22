/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DAOKhachSan;
import dao.DAOLoaiKhachSan;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.LoaiKhachSan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminLoaiKhachSanServlet", urlPatterns = {"/loaikhachsans"})
public class AdminLoaiKhachSanServlet extends HttpServlet {

    private DAOLoaiKhachSan daoLoaiKhachSan;
    private DAOKhachSan daoKhachSan; // Thêm DAO Khách Sạn để lấy số lượng

    @Override
    public void init() throws ServletException {
        daoLoaiKhachSan = new DAOLoaiKhachSan();
        daoKhachSan = new DAOKhachSan(); // Khởi tạo DAO Khách Sạn
    }

    private void listLoaiKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<LoaiKhachSan> danhSach = daoLoaiKhachSan.getAll();
        request.setAttribute("loaikhachsans", danhSach);
        request.getRequestDispatcher("jsp/loaikhachsan/listLoaiKhachSan.jsp").forward(request, response);
    }

    // Hiển thị form thêm mới
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("jsp/loaikhachsan/createLoaiKhachSan.jsp").forward(request, response);
    }

    // Thêm loại khách sạn
    private void insertLoaiKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ten = request.getParameter("ten");
        String moTa = request.getParameter("moTa");
        String urlHinhAnh = request.getParameter("urlHinhAnh");

        // Lấy số lượng khách sạn có loại này
        int soKhachSan = daoKhachSan.countByLoaiKhachSan(ten);

        LoaiKhachSan lks = new LoaiKhachSan(0, ten, moTa, urlHinhAnh, soKhachSan);
        
        boolean isInserted = daoLoaiKhachSan.insert(lks);
        if (isInserted) {
            request.setAttribute("message", "Thêm thành công!");
        } else {
            request.setAttribute("message", "Thêm thất bại!");
        }

        response.sendRedirect("loaikhachsans?action=list");
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        List<LoaiKhachSan> danhSach = daoLoaiKhachSan.getAll();
        LoaiKhachSan loaiKhachSan = danhSach.stream().filter(tp -> tp.getId() == id).findFirst().orElse(null);
        request.setAttribute("loaiKhachSan", loaiKhachSan);
        request.getRequestDispatcher("jsp/loaikhachsan/updateLoaiKhachSan.jsp").forward(request, response);
    }

    private void updateLoaiKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String ten = request.getParameter("ten");
        String moTa = request.getParameter("moTa");
        String urlHinhAnh = request.getParameter("urlHinhAnh");
        int soKhachSan = daoKhachSan.countByLoaiKhachSan(ten);
        
        LoaiKhachSan lks = new LoaiKhachSan(id, ten, moTa, urlHinhAnh);
        daoLoaiKhachSan.update(lks);
        response.sendRedirect("loaikhachsans?action=list");
    }

    private void deleteLoaiKhachSan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        daoLoaiKhachSan.delete(id);
        response.sendRedirect("loaikhachsans?action=list");
    }

    private void searchLoaiKhachSan(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String keyword = request.getParameter("name");

    // Kiểm tra nếu từ khóa rỗng hoặc null, trả về danh sách đầy đủ
    List<LoaiKhachSan> danhSach = daoLoaiKhachSan.getAll();
    List<LoaiKhachSan> ketQuaTimKiem;

    if (keyword == null || keyword.trim().isEmpty()) {
        ketQuaTimKiem = danhSach; // Trả về toàn bộ danh sách nếu không có từ khóa
    } else {
        String keywordLower = keyword.toLowerCase().trim();
        ketQuaTimKiem = danhSach.stream()
                .filter(tp -> tp.getTen().toLowerCase().contains(keywordLower))
                .toList();
    }

    request.setAttribute("loaikhachsans", ketQuaTimKiem);
    request.getRequestDispatcher("jsp/loaikhachsan/listLoaiKhachSan.jsp").forward(request, response);
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
            out.println("<title>Servlet LoaiKhachSanServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoaiKhachSanServlet at " + request.getContextPath() + "</h1>");
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
                listLoaiKhachSan(request, response);
                break;
            case "create":
                showCreateForm(request, response);
                break;
            case "update":
                showUpdateForm(request, response);
                break;
            case "delete":
                deleteLoaiKhachSan(request, response);
                break;
            case "search":
                searchLoaiKhachSan(request, response);
                break;    
            default:
                listLoaiKhachSan(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "create":
                insertLoaiKhachSan(request, response);
                break;
            case "update":
                updateLoaiKhachSan(request, response);
                break;
            case "search":
                searchLoaiKhachSan(request, response);
                break;     
            default:
                listLoaiKhachSan(request, response);
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
