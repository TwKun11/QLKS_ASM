<%-- 
    Document   : createThanhPho
    Created on : Feb 25, 2025, 8:40:08 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="datPhong" class="model.DatPhong" scope="request" />
<jsp:setProperty name="datPhong" property="*" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Đặt Phòng</title>
        <link rel="stylesheet" href="jsp/css/a_style_create.css"/>
        <style>

            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                padding: 20px;
                background-color: #f4f4f4;
            }

            h1, h2 {
                color: #333;
            }

            a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            a:hover {
                text-decoration: underline;
            }

            form {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 400px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-top: 10px;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                background: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                margin-top: 15px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background: #218838;
            }
        </style>
    </head>
    <body>
        <h2>
            <a href="datphongs?action=list">List All Đặt Phòng</a>
        </h2>

        <h1>Create Đặt Phòng</h1>
        <p>NOTE: Enter all room information.</p>
        <form action="datphongs?action=create" method="post">  
            <%-- Kiểm tra danh sách Tài Khoản --%>
            <c:if test="${empty danhSachTaiKhoan}">
                <p style="color: red;">Lỗi: danhSachTaiKhoan không có dữ liệu.</p>
            </c:if>

            <!-- Chọn Tài Khoản -->
            <label class="pad_top">Tài Khoản:</label>
            <select name="tenTaiKhoan" required>
                <c:choose>
                    <c:when test="${not empty danhSachTaiKhoan}">
                        <c:forEach var="tp" items="${danhSachTaiKhoan}">
                            <option value="${tp.id}">${tp.tenTaiKhoan}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Không có dữ liệu</option>
                    </c:otherwise>
                </c:choose>
            </select><br>

            <label class="pad_top">Tài Khoản:</label>
            <input type="text" name="taiKhoan" required><br>

            <%-- Kiểm tra danh sách Thành phố --%>
            <c:if test="${empty danhSachPhong}">
                <p style="color: red;">Lỗi: danhSachPhong không có dữ liệu.</p>
            </c:if>

            <!-- Chọn Khách Sạn -->
            <label class="pad_top">Phòng:</label>
            <select name="idPhong" required>
                <c:choose>
                    <c:when test="${not empty danhSachPhong}">
                        <c:forEach var="tp" items="${danhSachPhong}">
                            <option value="${tp.ten}">${tp.ten}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Không có dữ liệu</option>
                    </c:otherwise>
                </c:choose>
            </select><br>

            <label class="pad_top">Ngày Đặt:</label>
            <input type="date" name="ngayDat" required><br>

            <label class="pad_top">Ngày Đến:</label>
            <input type="date" name="ngayDen" required><br>

            <label class="pad_top">Ngày Trả:</label>
            <input type="date" name="ngayTra" required><br>

            <label class="pad_top">Dịch Vụ:</label>
            <input type="text" name="dichVu"><br>

            <label class="pad_top">Ghi Chú:</label>
            <textarea name="ghiChu" rows="3"></textarea><br>

            <label class="pad_top">Thành Tiền:</label>
            <input type="number" name="thanhTien" required><br>

            <label class="pad_top">Đã Hủy:</label>
            <select name="daHuy">
                <option value="false">Chưa Hủy</option>
                <option value="true">Đã Hủy</option>
            </select><br>

            <label>&nbsp;</label>
            <input type="submit" value="Submit" class="margin_left">
        </form>
    </body>
</html>
