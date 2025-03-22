<%--  
    Document   : createLoaiKhachSan  
    Created on : Feb 25, 2025, 8:40:08 PM  
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
        <link rel="stylesheet" href="jsp/css/a_style_create.css"/>  
        <title>Create Phòng</title>  
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
            <a href="phongs?action=list">Danh Sách Phòng</a>  
        </h2>  

        <h1>Thêm Phòng</h1>  
        <p>NOTE: Nhập đầy đủ thông tin phòng.</p>  

        <form action="phongs?action=create" method="post">      
            <label class="pad_top">Tên Phòng:</label>  
            <input type="text" name="ten" required><br>  

            <label class="pad_top">Diện Tích (m²):</label>  
            <input type="number" name="dienTich" required><br>  

            <label class="pad_top">Giá Thuê (VNĐ):</label>  
            <input type="number" name="giaThue" required><br>  

            <label class="pad_top">Tiện Nghi:</label>  
            <input type="text" name="tienNghi" required><br>  

            <label class="pad_top">Mô Tả:</label>  
            <input type="text" name="moTa" required><br>  

            <label class="pad_top">Loại Giường:</label>  
            <select name="loaiGiuong" required>
                <option value="0">Giường đơn</option>
                <option value="1">Giường đôi</option>
            </select><br>
            <%-- Kiểm tra danh sách Thành phố --%>
            <c:if test="${empty danhSachKhachSan}">
                <p style="color: red;">Lỗi: danhSachKhachSan không có dữ liệu.</p>
            </c:if>

            <!-- Chọn Khách Sạn -->
            <label class="pad_top">Khách Sạn:</label>
            <select name="tenKhachSan" required>
                <c:choose>
                    <c:when test="${not empty danhSachKhachSan}">
                        <c:forEach var="tp" items="${danhSachKhachSan}">
                            <option value="${tp.ten}">${tp.ten}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Không có dữ liệu</option>
                    </c:otherwise>
                </c:choose>
            </select><br>

            <label>&nbsp;</label>  
            <input type="submit" value="Thêm Mới" class="margin_left">  
        </form>  
    </body>  
</html>  
