<%-- 
    Document   : updateThanhPho
    Created on : Feb 25, 2025, 8:40:23 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="datPhong" class="model.DatPhong" scope="request" />
<jsp:setProperty name="datPhong" property="*" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="jsp/css/a_style_update.css"/>
        <title>Update Đặt Phòng</title>
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
            <a href="datphongs?action=list">Danh Sách Đặt Phòng</a>
        </h2>

        <h1>Cập Nhật Đặt Phòng</h1>
        <p>NOTE: Vui lòng chỉnh sửa thông tin đặt phòng.</p>

        <form action="datphongs?action=update" method="post">
            <input type="hidden" name="id" value="${datPhong.id}" >

            <label class="pad_top">Tài Khoản:</label>
            <input type="text" name="taiKhoan_display" value="${datPhong.taiKhoan}" disabled>
            <input type="hidden" name="taiKhoan" value="${datPhong.taiKhoan}">


            <label>ID Phòng:</label>
            <input type="text" name="idPhong" value="${datPhong.idPhong}" required>

            <label>Ngày Đặt:</label>
            <input type="date" name="ngayDat" value="${datPhong.ngayDat}" required>

            <label>Ngày Đến:</label>
            <input type="date" name="ngayDen" value="${datPhong.ngayDen}" required>

            <label>Ngày Trả:</label>
            <input type="date" name="ngayTra" value="${datPhong.ngayTra}" required>

            <label>Dịch Vụ:</label>
            <input type="text" name="dichVu" value="${datPhong.dichVu}">

            <label>Ghi Chú:</label>
            <textarea name="ghiChu">${datPhong.ghiChu}</textarea>

            <label>Thành Tiền:</label>
            <input type="number" name="thanhTien" value="${datPhong.thanhTien}" required>

            <label>&nbsp;</label>
            <input type="submit" value="Cập Nhật" class="margin_left">
        </form>
    </body>
</html>
