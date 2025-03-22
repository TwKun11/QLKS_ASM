<%-- 
    Document   : updateKhachSan
    Created on : Mar 12, 2025
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="jsp/css/a_style_update.css"/>
        <title>Update Khách Sạn</title>
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
            <a href="khachsans?action=list">List All Khách Sạn</a>
        </h2>

        <h1>Update Khách Sạn</h1>
        <p>NOTE: Edit hotel information and submit.</p>

        <form action="khachsans?action=update" method="post">      
            <input type="hidden" name="id" value="${khachSan.id}">

            <label class="pad_top">Tên Khách Sạn:</label>
            <input type="text" name="ten" value="${khachSan.ten}" required><br>

            <label class="pad_top">Địa Chỉ:</label>
            <input type="text" name="diaChi" value="${khachSan.diaChi}" required><br>

            <label class="pad_top">Số Điện Thoại:</label>
            <input type="text" name="soDienThoai" value="${khachSan.soDienThoai}" required><br>

            <label class="pad_top">Cách Trung Tâm (km):</label>
            <input type="number" name="cachTrungTam" value="${khachSan.cachTrungTam}" required><br>

            <label class="pad_top">Mô Tả:</label>
            <textarea name="moTa" rows="3">${khachSan.moTa}</textarea><br>

            <label class="pad_top">Giáp Biển:</label>
            <select name="giapBien">
                <option value="true" ${khachSan.giapBien ? "selected" : ""}>Có</option>
                <option value="false" ${!khachSan.giapBien ? "selected" : ""}>Không</option>
            </select><br>

            <label class="pad_top">Đánh Giá (sao):</label>
            <select name="danhGia" required>
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}" ${khachSan.danhGia == i ? "selected" : ""}>${i} ⭐</option>
                </c:forEach>
            </select><br>
            
            <label class="pad_top">Bữa Ăn:</label>
            <select name="buaAn" required>
                <option value="">-- Chọn bữa ăn --</option>
                <option value="0" ${khachSan.buaAn == 0 ? "selected" : ""}>Không có</option>
                <option value="1" ${khachSan.buaAn == 1 ? "selected" : ""}>Bữa Sáng</option>
                <option value="2" ${khachSan.buaAn == 2 ? "selected" : ""}>Bữa Sáng Và Trưa</option>
                <option value="3" ${khachSan.buaAn == 3 ? "selected" : ""}>Bữa Sáng Và Tối</option>
                <option value="4" ${khachSan.buaAn == 4 ? "selected" : ""}>Cả Ba Bữa</option>
            </select><br>


            <%-- Kiểm tra danh sách Thành phố --%>
            <c:if test="${empty danhSachThanhPho}">
                <p style="color: red;">Lỗi: danhSachThanhPho không có dữ liệu.</p>
            </c:if>

            <%-- Kiểm tra danh sách Loại khách sạn --%>
            <c:if test="${empty danhSachLoaiKhachSan}">
                <p style="color: red;">Lỗi: danhSachLoaiKhachSan không có dữ liệu.</p>
            </c:if>

            <!-- Chọn Thành Phố -->
            <label class="pad_top">Thành Phố:</label>
            <select name="tenThanhPho" required>
                <c:choose>
                    <c:when test="${not empty danhSachThanhPho}">
                        <c:forEach var="tp" items="${danhSachThanhPho}">
                            <option value="${tp.ten}" ${khachSan.tenThanhPho eq tp.ten ? "selected" : ""}>${tp.ten}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Không có dữ liệu</option>
                    </c:otherwise>
                </c:choose>
            </select><br>

            <!-- Chọn Loại Khách Sạn -->
            <label class="pad_top">Loại Khách Sạn:</label>
            <select name="tenLoaiKhachSan" required>
                <c:choose>
                    <c:when test="${not empty danhSachLoaiKhachSan}">
                        <c:forEach var="lks" items="${danhSachLoaiKhachSan}">
                            <option value="${lks.ten}" ${khachSan.tenLoaiKhachSan eq lks.ten ? "selected" : ""}>${lks.ten}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="">Không có dữ liệu</option>
                    </c:otherwise>
                </c:choose>
            </select><br>

            <label class="pad_top">URL Hình Ảnh:</label>
            <input type="text" name="urlHinhAnhThanhPho" value="${khachSan.urlHinhAnhThanhPho}"><br>

            <label>&nbsp;</label>
            <input type="submit" value="Update" class="margin_left">
        </form>
    </body>
</html>
