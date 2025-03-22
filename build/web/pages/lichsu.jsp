<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, model.DatPhong" %>

<html>
    <head>
        <title>Lịch sử đặt phòng</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            /* Thiết lập layout */
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }



            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            /* Style bảng danh sách */
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                margin-top: 10px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }

            th {
                background: #007bff;
                color: white;
                font-weight: bold;
            }

            tr:nth-child(even) {
                background: #f9f9f9;
            }

            tr:hover {
                background: #f1f1f1;
            }

            /* Popup Styles */
            .popup {
                display: none;
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                text-align: center;
                z-index: 1000;
            }

            .popup-content {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .confirm-btn {
                background: red;
                color: white;
                padding: 10px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }

            .cancel-btn {
                background: gray;
                color: white;
                padding: 10px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }

            /* Footer */
            footer {
                margin-top: auto;
            }
        </style>
    </head>
    <body>

        <%@ include file="/includes/header.jsp" %>
        <div class="">
            <h2>Lịch sử đặt phòng</h2>
            <c:if test="${empty bookings}">
                <p style="color: red; text-align: center;">Không có đơn đặt phòng nào.</p>
            </c:if>

            <!-- Hiển thị thông báo nếu có -->
            <c:if test="${not empty message}">
                <p style="color: green; text-align: center;">${message}</p>
            </c:if>

            <!-- Kiểm tra danh sách đặt phòng -->
            <c:choose>
                <c:when test="${not empty bookings}">
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>ID Phòng</th>
                            <th>Ngày đặt</th>
                            <th>Ngày đến</th>
                            <th>Ngày trả</th>
                            <th>Dịch vụ</th>
                            <th>Thanh Toán</th>
                            <th>Thành Tiền</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>

                        <!-- Duyệt danh sách đặt phòng -->
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>${booking.id}</td>
                                <td>${booking.idPhong}</td>
                                <td>${booking.ngayDat}</td>
                                <td>${booking.ngayDen}</td>
                                <td>${booking.ngayTra}</td>
                                <td>${booking.dichVu}</td>
                                <td>${booking.ghiChu}</td>
                                <td>${booking.thanhTien}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.daHuy}">
                                            <span style="color: red;">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: green;">Đã đặt</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Chỉ hiển thị nút "Hủy đặt phòng" nếu chưa bị hủy -->
                                    <c:if test="${not booking.daHuy}">
                                        <button type="button" onclick="confirmCancel(${booking.id})" style="background: red; color: white; padding: 8px; border: none; cursor: pointer; border-radius: 5px;">Hủy đặt phòng</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center;">Bạn chưa đặt phòng!</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Popup xác nhận -->
        <div id="confirm-popup" class="popup">
            <div class="popup-content">
                <p>Bạn có chắc chắn muốn hủy đặt phòng này không?</p>
                <form id="cancelForm" action="huydatphong" method="post">
                    <input type="hidden" id="cancelId" name="id">
                    <button type="submit" class="confirm-btn">Xác nhận</button>
                    <button type="button" class="cancel-btn" onclick="closePopup()">Hủy bỏ</button>
                </form>
            </div>
        </div>

        <script>
            function confirmCancel(bookingId) {
                document.getElementById("cancelId").value = bookingId;
                document.getElementById("confirm-popup").style.display = "block";
            }

            function closePopup() {
                document.getElementById("confirm-popup").style.display = "none";
            }
        </script>

    <%@ include file="/includes/footer.jsp" %>

    </body>
</html>
