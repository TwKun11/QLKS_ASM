<%--  
    Document   : updateLoaiKhachSan  
    Created on : Feb 25, 2025, 8:40:23 PM  
    Author     : Admin  
--%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<jsp:useBean id="phong" class="model.Phong" scope="request" />  
<jsp:setProperty name="phong" property="*" />  

<!DOCTYPE html>  
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <link rel="stylesheet" href="jsp/css/a_style_update.css"/>  
        <title>Update Loại Khách Sạn</title>  
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
        <h2>Cập Nhật Thông Tin Phòng</h2>

        <form action="phongs?action=update" method="post">
            <input type="hidden" name="id" value="${phong.id}">

            <label for="ten">Tên Phòng:</label>
            <input type="text" id="ten" name="ten" value="${phong.ten}" required>

            <label for="dienTich">Diện Tích (m²):</label>
            <input type="number" id="dienTich" name="dienTich" value="${phong.dienTich}" required>

            <label for="giaThue">Giá Thuê (VNĐ):</label>
            <input type="number" id="giaThue" name="giaThue" value="${phong.giaThue}" required>

            <label for="tienNghi">Tiện Nghi:</label>
            <textarea id="tienNghi" name="tienNghi" required>${phong.tienNghi}</textarea>

            <label for="moTa">Mô Tả:</label>
            <textarea id="moTa" name="moTa" required>${phong.moTa}</textarea>
            <label for="loaiGiuong">Loại Giường:</label>
            <select id="loaiGiuong" name="loaiGiuong" required>
                <option value="0" ${phong.loaiGiuong == 0 ? 'selected' : ''}>Giường đơn</option>
                <option value="1" ${phong.loaiGiuong == 1 ? 'selected' : ''}>Giường đôi</option>
            </select>

            <label for="idKhachSan">Khách Sạn:</label>
            <select name="idKhachSan" required>
                <c:choose>
                    <c:when test="${not empty danhSachKhachSan}">
                        <c:forEach var="tp" items="${danhSachKhachSan}">
                            <option value="${tp.id}" ${tp.id == phong.idKhachSan ? 'selected' : ''}>${tp.ten}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Không có dữ liệu</option>
                    </c:otherwise>
                </c:choose>
            </select><br>


            <button type="submit">Cập Nhật</button>
        </form>

        <a href="phongs">Quay lại danh sách</a>
    </body>
</html>  
