/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import dao.DAODatPhong;
import dao.DAOPhong;
import dao.DAOTaiKhoan;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author HuuThanh
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String ADMIN = "admin/admin_home.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
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
        DAODatPhong dpDao = new DAODatPhong();
        DAOTaiKhoan tkDao = new DAOTaiKhoan();

        String url = ADMIN;
        try {
            int mostbookerroom = dpDao.getMostBookedRoom();
            int totalUsers = tkDao.getTotalTaiKhoan();
            int totalRevenue = dpDao.getTotalRevenue();
            int bookedRoomCount = dpDao.getBookedRoomCount();
            log("Total Users: " + totalUsers);

            request.setAttribute("MOSTBOOKERROOM", mostbookerroom);
            request.setAttribute("TOTALUSERS", totalUsers);
            request.setAttribute("TOTALREVENUE", totalRevenue);
            request.setAttribute("BOOKERROOMCOUNT", bookedRoomCount);

        } catch (Exception ex) {
            log("AdminServlet error:" + ex.getMessage());
        } finally {
            request.getRequestDispatcher(ADMIN).forward(request, response);
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
        doGet(request, response);
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
