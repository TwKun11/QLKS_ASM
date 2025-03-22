<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Danh Sách Đặt Phòng</title>
    <style>
        /* Định dạng tổng thể */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        /* CSS cho thanh navbar */
        .navbar {
            width: 250px;
            position: fixed;
            left: 0;
            top: 0;
            height: 100%;
            background-color: #333;
            color: white;
            padding-top: 20px;
        }

        .navbar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
        }

        .navbar a:hover {
            background-color: #575757;
        }

        /* CSS cho phần nội dung chính */
        .main-content {
            margin-left: 250px; /* Đẩy nội dung tránh thanh navbar */
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        /* CSS cho form tìm kiếm */
        .search-form {
            margin-bottom: 20px;
        }

        .search-form input {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-form button {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-form button:hover {
            background-color: #0056b3;
        }

        /* CSS cho bảng danh sách đặt phòng */
        .styled-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        .styled-table th, .styled-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        .styled-table th {
            background-color: #007bff;
            color: white;
        }

        .styled-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* CSS cho nút Update & Delete */
        .btn {
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }

        .btn-update {
            background-color: #007bff;
        }

        .btn-update:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        /* CSS cho phần phân trang */
        .pagination {
            margin-top: 20px;
        }

        .pagination a {
            text-decoration: none;
            padding: 8px 12px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            margin: 0 5px;
        }

        .pagination a:hover {
            background-color: #0056b3;
        }
        
        
    </style>
</head>
<body>
    <!-- Include thanh navbar -->
    <%@ include file="/admin/admin_home.jsp" %>

    <div class="main-content">
        <main>
            <%@ include file="/admin/parameter.jsp" %>
            <h2>Danh Sách Đặt Phòng</h2>

            <!-- Form tìm kiếm -->
            <form action="datphongs" method="get" class="search-form">
                <input type="text" name="name" placeholder="Nhập tên tài khoản..." required>
                <input type="hidden" name="action" value="search">
                <button type="submit">Tìm kiếm</button>
            </form>

            <!-- Phân trang -->
            <c:set var="pageSize" value="10"/>
            <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
            <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
            <c:set var="end" value="${start + pageSize}"/>
            <c:set var="totalDatPhongs" value="${datphongs.size()}"/>
            <c:set var="totalPages" value="${(totalDatPhongs + pageSize - 1) / pageSize}"/>

            <!-- Bảng danh sách đặt phòng -->
            <table class="styled-table">
                <tr>
                    <th>ID</th>
                    <th>Tài Khoản</th>
                    <th>ID Phòng</th>
                    <th>Ngày Đặt</th>
                    <th>Ngày Đến</th>
                    <th>Ngày Trả</th>
                    <th>Dịch Vụ</th>
                    <th>Ghi Chú</th>
                    <th>Thành Tiền</th>
                    <th>Đã Hủy</th>
                    <th>Chức năng</th>
                </tr>
                <c:forEach var="datPhong" items="${datphongs}" varStatus="status">
                    <c:if test="${status.index >= start && status.index < end}">
                        <tr>
                            <td>${datPhong.id}</td>
                            <td>${datPhong.taiKhoan}</td>
                            <td>${datPhong.idPhong}</td>
                            <td>${datPhong.ngayDat}</td>
                            <td>${datPhong.ngayDen}</td>
                            <td>${datPhong.ngayTra}</td>
                            <td>${datPhong.dichVu}</td>
                            <td>${datPhong.ghiChu}</td>
                            <td>${datPhong.thanhTien}</td>
                            <td>${datPhong.daHuy ? "Có" : "Không"}</td>
                            <td>
                                <a class="btn btn-update" href="datphongs?action=update&id=${datPhong.id}">Update</a>
                                <a class="btn btn-delete" href="datphongs?action=remove&id=${datPhong.id}" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa trường này?');">Delete</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>

            <!-- Phân trang -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="datphongs?action=list&page=${currentPage - 1}">Trước</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="datphongs?action=list&page=${i}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="datphongs?action=list&page=${currentPage + 1}">Sau</a>
                </c:if>
            </div>
        </main>
    </div>   
</body>
</html>
