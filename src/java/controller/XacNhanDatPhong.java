package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.DatPhongService;
import model.DatPhong;
import model.TaiKhoan;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author Admin
 */
@WebServlet(name = "XacNhanDatPhong", urlPatterns = {"/xacnhandatphong"})
public class XacNhanDatPhong extends HttpServlet {

    private DatPhongService datPhongService;

    @Override
    public void init() throws ServletException {
        super.init();
        datPhongService = new DatPhongService();
    }

    private double tinhGiaThue(String giaMotDemStr, String ngayDenStr, String ngayTraStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date ngayDen = sdf.parse(ngayDenStr);
            Date ngayTra = sdf.parse(ngayTraStr);
            long soNgay = (ngayTra.getTime() - ngayDen.getTime()) / (1000 * 60 * 60 * 24);
            int giaMotDem = Integer.parseInt(giaMotDemStr);
            return giaMotDem * Math.max(soNgay, 1);
        } catch (ParseException | NumberFormatException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Hàm gửi email
    private void sendEmail(String toEmail, String tenPhong, String ngayDen, String ngayTra, int giaThue, int maDon) {
        final String username = "atshqlks@gmail.com"; // Thay bằng email của bạn
        final String password = "hqey tjfa spqx fjug";    // Thay bằng mật khẩu ứng dụng (nếu dùng Gmail)

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Xác nhận đặt phòng thành công");
            message.setText("Chào bạn,\n\n"
                    + "Đặt phòng của bạn đã được xác nhận thành công!\n"
                    + "Thông tin đặt phòng:\n"
                    + "Phòng: " + tenPhong + "\n"
                    + "Ngày đến: " + ngayDen + "\n"
                    + "Ngày trả: " + ngayTra + "\n"
                    + "Tổng tiền: " + giaThue + " VND\n"
                    + "Mã đơn: " + maDon + "\n\n"
                    + "Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!\n"
                    + "Trân trọng,\nĐội ngũ hỗ trợ");

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Failed to send email: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("pages/login.jsp");
            return;
        }
        String tenPhong = request.getParameter("tenPhong");
        String idPhong = request.getParameter("idPhong");
        String ngayDen = request.getParameter("ngayDen");
        String ngayTra = request.getParameter("ngayTra");
        String giaThueStr = request.getParameter("giaThue");
        int giaThue = (int) tinhGiaThue(giaThueStr, ngayDen, ngayTra);

        if (idPhong == null || ngayDen == null || ngayTra == null) {
            request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("/datphong/datPhong.jsp").forward(request, response);
            return;
        }

        request.setAttribute("giaThue", giaThue);
        request.setAttribute("tenPhong", tenPhong);
        request.setAttribute("username", user);
        request.setAttribute("idPhong", idPhong);
        request.setAttribute("ngayDen", ngayDen);
        request.setAttribute("ngayTra", ngayTra);
        request.setAttribute("message", "Vui lòng kiểm tra lại thông tin đặt phòng!");

        request.getRequestDispatcher("/datphong/xacnhandatphong.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int giaThue = Integer.parseInt(request.getParameter("giaThue"));
        String idPhong = request.getParameter("idPhong");
        String ngayDenStr = request.getParameter("ngayDen");
        String ngayTraStr = request.getParameter("ngayTra");
        String dichVu = request.getParameter("dichVu") != null ? request.getParameter("dichVu") : "Không có";
        String tenPhong = request.getParameter("tenPhong");

        if (idPhong == null || ngayDenStr == null || ngayTraStr == null) {
            request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("/datphong/datPhong.jsp").forward(request, response);
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date ngayDen = sdf.parse(ngayDenStr);
            Date ngayTra = sdf.parse(ngayTraStr);
            Date ngayDat = new Date();

            // Kiểm tra phòng có sẵn không trước khi đặt
            boolean isAvailable = datPhongService.checkRoomAvailability(Integer.parseInt(idPhong), ngayDenStr, ngayTraStr);
            if (!isAvailable) {
                request.setAttribute("error", "Phòng đã được đặt trong khoảng thời gian này!");
                request.getRequestDispatcher("/datphong/xacnhandatphong.jsp").forward(request, response);
                return;
            }

            DatPhong datPhong = new DatPhong();
            datPhong.setTaiKhoan(user.getTenTaiKhoan());
            datPhong.setIdPhong(Integer.parseInt(idPhong));
            datPhong.setNgayDat(ngayDat);
            datPhong.setNgayDen(ngayDen);
            datPhong.setNgayTra(ngayTra);
            datPhong.setDichVu(dichVu);
            datPhong.setGhiChu("Thanh toán khi nhận phòng");
            datPhong.setThanhTien(giaThue);
            datPhong.setDaHuy(false);

            boolean isInserted = datPhongService.insert(datPhong);

            if (isInserted) {
                request.setAttribute("message", "Đặt phòng thành công! Mã đơn: " + datPhong.getId());
                String userEmail = user.getEmail();
                if (userEmail != null && !userEmail.isEmpty()) {
                    sendEmail(userEmail, tenPhong, ngayDenStr, ngayTraStr, giaThue, datPhong.getId());
                } else {
                    System.out.println("User email not available.");
                }
            } else {
                request.setAttribute("error", "Đặt phòng thất bại! Vui lòng thử lại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
        }

        request.getRequestDispatcher("/datphong/datphongthanhcong.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}