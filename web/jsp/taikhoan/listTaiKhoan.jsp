<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Danh Sách Tài Khoản</title>
        <link rel="stylesheet" href="jsp/css/a_style_list.css"/>
        <style>/* General styles */
            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f6f9;
            }

            /* Ensure the main content does not overlap with the sidebar */
            main {
                margin-left: 280px; /* Matches the width of the sidebar */
                padding: 20px;
                transition: all 0.3s ease-in-out;
            }

            /* Heading styles */
            h2 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }

            /* Button styles */
            a {
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

            table th, table td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }

            table th {
                background-color: #4CAF50;
                color: white;
                text-transform: uppercase;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #f1f1f1;
            }

            /* Action buttons inside table */
            td a {
                padding: 6px 12px;
                border-radius: 5px;
                background-color: #4CAF50;
                color: white;
                font-size: 14px;
                transition: background-color 0.3s;
            }

            td a:hover {
                background-color: #45a049;
            }

            /* Pagination styling */
            .pagination {
                text-align: center;
                margin-top: 20px;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 12px;
                margin: 0 5px;
                text-decoration: none;
                color: white;
                background-color: #4CAF50;
                border-radius: 5px;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            .pagination a:hover {
                background-color: #45a049;
            }

            /* Form styling */
            .search-form {
                margin: 20px auto;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
            }

            .search-form input[type="text"] {
                padding: 10px;
                width: 300px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .search-form button {
                padding: 10px 15px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .search-form button:hover {
                background-color: #45a049;
            }

            /* Responsive Design */
            @media screen and (max-width: 768px) {
                main {
                    margin-left: 0;
                    padding: 10px;
                }

                .search-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .search-form input[type="text"] {
                    width: 100%;
                }

                .search-form button {
                    width: 100%;
                }

                table {
                    font-size: 14px;
                }

                table th, table td {
                    padding: 8px;
                }
            }
            /* Phân trang */
            div {
                text-align: center;
                margin-top: 20px;
            }

            div a {
                text-decoration: none;
                padding: 5px 10px;
                border: 1px solid #007bff;
                color: #007bff;
                border-radius: 5px;
                margin: 0 5px;
            }

            div a:hover {
                background-color: #007bff;
                color: white;
            } </style>
    </head>
    <body>
        <%@ include file="/admin/admin_home.jsp" %>
        <div class="main-content">
            <!-- Main content wrapper -->
            <main>
                <h2>Danh Sách Tài Khoản</h2>
                <h2>
                    <a href="taikhoans?action=create">Thêm Mới Tài Khoản</a>
                </h2>
                <form action="taikhoans?action=search" method="get" class="search-form">
                    <input type="text" name="name" placeholder="Nhập tên tài khoản..." required>
                    <input type="hidden" name="action" value="search">
                    <button type="submit">Tìm kiếm</button>
                </form>

                <c:choose>
                    <c:when test="${empty taiKhoans}">
                        <p>Không có tài khoản nào.</p>
                    </c:when>
                    <c:otherwise>
                        <table border="1">
                            <tr>
                                <th>Tên Tài Khoản</th>
                                <th>Mật Khẩu</th>
                                <th>Họ Tên</th>
                                <th>Giới Tính</th>
                                <th>Số Điện Thoại</th>
                                <th>Email</th>
                                <th>Vai Trò</th>
                                <th>Chức năng</th>
                            </tr>
                            <c:forEach var="taiKhoan" items="${taiKhoans}">
                                <tr>
                                    <td>${taiKhoan.tenTaiKhoan}</td>
                                    <td>${taiKhoan.matKhau}</td>
                                    <td>${taiKhoan.hoTen}</td>
                                    <td>${taiKhoan.gioiTinh ? "Nam" : "Nữ"}</td>
                                    <td>${taiKhoan.soDienThoai}</td>
                                    <td>${taiKhoan.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${taiKhoan.idRole eq '1'}">Admin</c:when>
                                            <c:when test="${taiKhoan.idRole eq '2'}">User</c:when>
                                            <c:otherwise>Không xác định</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a style="color: white"  href="taikhoans?action=update&tenTaiKhoan=${taiKhoan.tenTaiKhoan}">Cập Nhật</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>

                <!-- Phân trang -->
                
                <div>
                    <c:if test="${currentPage > 1}">
                        <a href="taikhoans?page=${currentPage - 1}">Trước</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="taikhoans?page=${i}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="taikhoans?page=${currentPage + 1}">Sau</a>
                    </c:if>
                </div>
            </main>
        </div>  
    </body>
</html>
