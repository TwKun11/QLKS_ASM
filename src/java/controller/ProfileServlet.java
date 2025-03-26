package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.TaiKhoanService;
import model.TaiKhoan;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    private TaiKhoanService taiKhoanService;

    @Override
    public void init() throws ServletException {
        super.init();
        taiKhoanService = new TaiKhoanService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
        // Hiện tại doGet bị comment, nếu cần sử dụng thì uncomment và chỉnh sửa
        /*
        HttpSession session = request.getSession(false);
        TaiKhoan user = null;

        if (session != null) {
            String tenTaiKhoan = (String) session.getAttribute("tenTaiKhoan");
            if (tenTaiKhoan != null) {
                try {
                    user = taiKhoanService.getByTenTaiKhoan(tenTaiKhoan);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        if (user == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("username".equals(cookie.getName())) {
                        String usernameFromCookie = cookie.getValue();
                        try {
                            user = taiKhoanService.getByTenTaiKhoan(usernameFromCookie);
                            if (user != null) {
                                request.getSession().setAttribute("tenTaiKhoan", usernameFromCookie);
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        break;
                    }
                }
            }
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        session.setAttribute("user", user);
        request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
        */
        processRequest(request, response); // Giữ nguyên hành vi mặc định nếu không dùng doGet
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
            System.out.println(taiKhoanService.update(user));

            if (taiKhoanService.update(user)) {
                user = taiKhoanService.getByTenTaiKhoan(tenTaiKhoan);
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
    }
}