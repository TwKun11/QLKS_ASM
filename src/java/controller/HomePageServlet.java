package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.KhachSanService;
import service.LoaiKhachSanService;
import service.ThanhPhoService;
import model.KhachSan;
import model.LoaiKhachSan;
import model.ThanhPho;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "HomePageServlet", urlPatterns = {"/home"})
public class HomePageServlet extends HttpServlet {
    
    // Thêm các instance của Service
    private KhachSanService khachSanService;
    private LoaiKhachSanService loaiKhachSanService;
    private ThanhPhoService thanhPhoService;

    @Override
    public void init() throws ServletException {
        super.init();
        khachSanService = new KhachSanService();
        loaiKhachSanService = new LoaiKhachSanService();
        thanhPhoService = new ThanhPhoService();
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
            out.println("<title>Servlet HomePageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        // Lấy tham số 'action' từ request
        String action = request.getParameter("action");

        // Xử lý từng case dựa trên giá trị của 'action'
        switch (action != null ? action : "home") {
            case "home":
                showHomePage(request, response);
                break;
            default:
                showErrorPage(request, response);
                break;
        }
    }

    private void showHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang homePage.jsp
        List<ThanhPho> cityList = thanhPhoService.getAll();
        request.setAttribute("listThanhPho", cityList);
        List<LoaiKhachSan> categoriesKhachSans = loaiKhachSanService.getAll();
        request.setAttribute("listLoaiKhachSan", categoriesKhachSans);
        List<KhachSan> khachSanNoiBac = khachSanService.getKhachSanGoodRate();
        request.setAttribute("khachSanNoiBac", khachSanNoiBac);
        request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
    }

    private void showErrorPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (var out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Error Page</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>404 - Action not found!</h1>");
            out.println("</body>");
            out.println("</html>");
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}