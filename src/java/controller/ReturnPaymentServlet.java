package controller;

import dao.DAODatPhong;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import model.DatPhong;
import model.TaiKhoan;

@WebServlet(name = "ReturnPaymentServlet", urlPatterns = {"/returnPayment"})
public class ReturnPaymentServlet extends HttpServlet {

    private DAODatPhong daoDatPhong = new DAODatPhong();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> params = new TreeMap<>();
        for (String paramName : request.getParameterMap().keySet()) {
            String paramValue = request.getParameter(paramName);
            if (paramValue != null && !paramValue.isEmpty()) {
                params.put(paramName, paramValue);
            }
        }

        System.out.println("VNPay Response Params: " + params);
        String vnp_SecureHash = params.remove("vnp_SecureHash");

        StringBuilder hashData = new StringBuilder();
        for (var entry : params.entrySet()) {
            hashData.append(entry.getKey()).append("=").append(entry.getValue()).append("&");
        }
        hashData.setLength(hashData.length() - 1);
        System.out.println("Hash Data: " + hashData.toString());

        String calculatedHash = hmacSHA512(config.VNPayConfig.vnp_HashSecret, hashData.toString());
        System.out.println("Calculated Hash: " + calculatedHash);
        System.out.println("VNPay Secure Hash: " + vnp_SecureHash);

        if (calculatedHash.equalsIgnoreCase(vnp_SecureHash)) {
            String vnp_ResponseCode = params.get("vnp_ResponseCode");
            if ("00".equals(vnp_ResponseCode)) {
                TaiKhoan user = (TaiKhoan) request.getSession().getAttribute("user");
                if (user == null) {
                    response.sendRedirect("pages/login.jsp");
                    return;
                }

                String orderInfo = params.get("vnp_OrderInfo");
                String[] orderDetails = orderInfo.split("_");
                int idPhong = Integer.parseInt(orderDetails[1]);
                String ngayDenStr = orderDetails[2];
                String ngayTraStr = orderDetails[3];
                int giaThue = Integer.parseInt(params.get("vnp_Amount")) / 100;

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date ngayDen = null;
                try {
                    ngayDen = sdf.parse(ngayDenStr);
                } catch (ParseException ex) {
                    Logger.getLogger(ReturnPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                Date ngayTra = null;
                try {
                    ngayTra = sdf.parse(ngayTraStr);
                } catch (ParseException ex) {
                    Logger.getLogger(ReturnPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                Date ngayDat = new Date();

                DatPhong datPhong = new DatPhong();
                datPhong.setTaiKhoan(user.getTenTaiKhoan());
                datPhong.setIdPhong(idPhong);
                datPhong.setNgayDat(ngayDat);
                datPhong.setNgayDen(ngayDen);
                datPhong.setNgayTra(ngayTra);
                datPhong.setDichVu("Không có");
                datPhong.setGhiChu("Đã thanh toán qua VNPay");
                datPhong.setThanhTien(giaThue);
                datPhong.setDaHuy(false);

                boolean isInserted = daoDatPhong.insert(datPhong);
                if (isInserted) {
                    request.setAttribute("message", "Thanh toán và đặt phòng thành công! Mã đơn: " + datPhong.getId());
                } else {
                    request.setAttribute("error", "Lỗi khi lưu đặt phòng.");
                }
            } else {
                request.setAttribute("error", "Thanh toán thất bại. Mã lỗi: " + vnp_ResponseCode);
            }
        } else {
            request.setAttribute("error", "Dữ liệu không hợp lệ hoặc bị thay đổi.");
        }

        request.getRequestDispatcher("/datphong/datphongthanhcong.jsp").forward(request, response);
    }

    private String hmacSHA512(String key, String data) throws IOException {
        try {
            Mac mac = Mac.getInstance("HmacSHA512");
            mac.init(new SecretKeySpec(key.getBytes("UTF-8"), "HmacSHA512"));
            byte[] hmac = mac.doFinal(data.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hmac) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new IOException("Lỗi tạo HMAC SHA512", e);
        }
    }
}
