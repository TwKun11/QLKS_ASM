package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.KhachSanService;
import service.PhongService;
import model.KhachSan;
import model.Phong;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "DatPhongServlet", urlPatterns = {"/datphong"})
public class DatPhongServlet extends HttpServlet {
    
    // Thêm các instance của Service
    private KhachSanService khachSanService;
    private PhongService phongService;

    @Override
    public void init() throws ServletException {
        super.init();
        khachSanService = new KhachSanService();
        phongService = new PhongService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        int id = Integer.parseInt(idParam);
        KhachSan khachSan = khachSanService.getById(id);
        if (khachSan != null) {
            request.setAttribute("khachSan", khachSan);
            request.getRequestDispatcher("/datphong/datphong.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idKhachSan = Integer.parseInt(request.getParameter("idKhachSan"));
            String ngayDenStr = request.getParameter("ngayDen");
            String ngayTraStr = request.getParameter("ngayTra");

            if (ngayDenStr == null || ngayTraStr == null) {
                request.setAttribute("message", "Vui lòng nhập đầy đủ ngày đến và ngày trả.");
                forwardToPage(request, response, idKhachSan);
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date ngayDen = sdf.parse(ngayDenStr);
            Date ngayTra = sdf.parse(ngayTraStr);

            if (!ngayDen.before(ngayTra)) {
                request.setAttribute("message", "Ngày nhận phòng phải trước ngày trả phòng.");
                forwardToPage(request, response, idKhachSan);
                return;
            }

            KhachSan khachSan = khachSanService.getById(idKhachSan);
            if (khachSan == null) {
                request.setAttribute("message", "Không tìm thấy khách sạn.");
                forwardToPage(request, response, idKhachSan);
                return;
            }

            List<Phong> danhSachPhong = phongService.layPhongTrong(idKhachSan, ngayDen, ngayTra);

            request.setAttribute("khachSan", khachSan);
            request.setAttribute("danhSachPhong", danhSachPhong);
            request.setAttribute("ngayDen", ngayDenStr);
            request.setAttribute("ngayTra", ngayTraStr);

            request.getRequestDispatcher("/datphong/datphong.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại!");
            forwardToPage(request, response, Integer.parseInt(request.getParameter("idKhachSan")));
        }
    }

    private void forwardToPage(HttpServletRequest request, HttpServletResponse response, int idKhachSan)
            throws ServletException, IOException {
        KhachSan khachSan = khachSanService.getById(idKhachSan);
        if (khachSan != null) {
            request.setAttribute("khachSan", khachSan);
        }
        request.getRequestDispatcher("/datphong/datphong.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đặt phòng khách sạn";
    }
}