/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.DAOThanhPho;
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
import model.ThanhPho;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminThanhPhoServlet", urlPatterns = {"/thanhphos"})
public class AdminThanhPhoServlet extends HttpServlet {

    private DAOThanhPho daoThanhPho;

    @Override
    public void init() throws ServletException {
        daoThanhPho = new DAOThanhPho();
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
    private void listThanhPho(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ThanhPho> danhSach = daoThanhPho.getAll();
        request.setAttribute("cities", danhSach);
        request.getRequestDispatcher("jsp/thanhpho/listThanhPho.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("jsp/thanhpho/createThanhPho.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        List<ThanhPho> danhSach = daoThanhPho.getAll();
        ThanhPho thanhPho = danhSach.stream().filter(tp -> tp.getId() == id).findFirst().orElse(null);
        request.setAttribute("thanhPho", thanhPho);
        request.getRequestDispatcher("jsp/thanhpho/updateThanhPho.jsp").forward(request, response);
    }

    private void insertThanhPho(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String ten = request.getParameter("ten");
        String moTa = request.getParameter("moTa");
        String urlHinhAnh = request.getParameter("urlHinhAnh");
        ThanhPho thanhPho = new ThanhPho(0, ten, moTa, urlHinhAnh);
        daoThanhPho.insert(thanhPho);
        response.sendRedirect("thanhphos?action=list");
    }

    private void updateThanhPho(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String ten = request.getParameter("ten");
        String moTa = request.getParameter("moTa");
        String urlHinhAnh = request.getParameter("urlHinhAnh");
        ThanhPho thanhPho = new ThanhPho(id, ten, moTa, urlHinhAnh, 0);
        daoThanhPho.update(thanhPho);
        response.sendRedirect("thanhphos?action=list");
    }

    private void deleteThanhPho(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        daoThanhPho.delete(id);
        response.sendRedirect("thanhphos?action=list");
    }

    private void searchThanhPho(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("name");
        List<ThanhPho> danhSach = daoThanhPho.getAll();

        // Lọc danh sách thành phố theo từ khóa
        List<ThanhPho> ketQuaTimKiem = danhSach.stream()
                .filter(tp -> tp.getTen().toLowerCase().contains(keyword.toLowerCase()))
                .toList();

        request.setAttribute("cities", ketQuaTimKiem);
        request.getRequestDispatcher("jsp/thanhpho/listThanhPho.jsp").forward(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ThanhPhoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ThanhPhoServlet at " + request.getContextPath() + "</h1>");
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
                showEditForm(request, response);
                break;
            case "delete":
                deleteThanhPho(request, response);
                break;
            case "search":
                searchThanhPho(request, response);
                break;
            default:
                listThanhPho(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                insertThanhPho(request, response);
                break;
            case "update":
                updateThanhPho(request, response);
                break;
            case "list":
                listThanhPho(request, response);
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
