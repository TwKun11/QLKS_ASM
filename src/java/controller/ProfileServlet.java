/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAOTaiKhoan;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.TaiKhoan;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    DAOTaiKhoan daoTaiKhoan = new DAOTaiKhoan();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        TaiKhoan user = null;
//
//        if (session != null) {
//            String tenTaiKhoan = (String) session.getAttribute("tenTaiKhoan");
//            if (tenTaiKhoan != null) {
//                try {
//                    user = DAOTaiKhoan.getByTenTaiKhoan(tenTaiKhoan);
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//
//        if (user == null) {
//            Cookie[] cookies = request.getCookies();
//            if (cookies != null) {
//                for (Cookie cookie : cookies) {
//                    if ("username".equals(cookie.getName())) {
//                        String usernameFromCookie = cookie.getValue();
//                        try {
//                            user = DAOTaiKhoan.getByTenTaiKhoan(usernameFromCookie);
//                            if (user != null) {
//                                request.getSession().setAttribute("tenTaiKhoan", usernameFromCookie);
//                            }
//                        } catch (SQLException e) {
//                            e.printStackTrace();
//                        }
//                        break;
//                    }
//                }
//            }
//        }
//
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
//            return;
//        }
//
//        session.setAttribute("user", user);
//        request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        String tenTaiKhoan = (String) session.getAttribute("tenTaiKhoan");
        String hoTen = request.getParameter("hoTen");
        boolean gioiTinh = "true".equals(request.getParameter("gioiTinh"));
        String soDienThoai = request.getParameter("soDienThoai");
        String email = request.getParameter("email");
        try {

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                return;
            }

            String matKhauCu = user.getMatKhau();
            int idRole = user.getIdRole();

            user.setHoTen(hoTen);
            user.setGioiTinh(gioiTinh);
            user.setSoDienThoai(soDienThoai);
            user.setEmail(email);
            user.setMatKhau(matKhauCu);
            user.setIdRole(idRole);
            System.out.println(user.getEmail());
            System.out.println(user.getHoTen());
            System.out.println(user.getIdRole());
            System.out.println(user.getMatKhau());
            System.out.println(user.getTenTaiKhoan());
            System.out.println(user.getSoDienThoai());
            System.out.println(daoTaiKhoan.update(user));
            if (daoTaiKhoan.update(user)) {
                user = daoTaiKhoan.getByTenTaiKhoan(tenTaiKhoan);
                request.setAttribute("user", user);
                request.setAttribute("message", "Cập nhật thành công!");
                String returnToProfile = request.getParameter("returnToProfile");
                if (returnToProfile != null && returnToProfile.equals("true")) {
                    response.sendRedirect(request.getContextPath() + "/pages/profile.jsp");
                    return;
                }
            } else {
                request.setAttribute("message", "Cập nhật thất bại!");
            }

            request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
