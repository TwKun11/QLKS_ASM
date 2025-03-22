<%-- 
    Document   : listThanhPho
    Created on : Feb 25, 2025, 8:39:53 PM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Danh Sách Loại Khách Sạn</title>
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
                <h2>Danh Sách Loại Khách Sạn</h2>
                <h2>
                    <a href="loaikhachsans?action=create">Thêm Mới Loại Khách Sạn</a>
                </h2>
                <form action="loaikhachsans?action=search" method="get" class="search-form">
                    <input type="text" name="name" placeholder="Nhập tên sản phẩm..." required>
                    <input type="hidden" name="action" value="search">
                    <button type="submit">Tìm kiếm</button>
                </form>


                <%-- Thiết lập số thành phố hiển thị trên mỗi trang --%>
                <c:set var="pageSize" value="10"/>
                <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
                <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
                <c:set var="end" value="${start + pageSize}"/>
                <c:set var="totalLoaiKhachSans" value="${loaikhachsans.size()}"/>
                <c:set var="totalPages" value="${Math.ceil(totalLoaiKhachSans / pageSize)}"/>

                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Tên Loại</th>
                        <th>Mô Tả</th>
                        <th>Hình Ảnh</th>
                        <th>Số Khách Sạn</th>
                        <th>Chức năng</th>
                    </tr>
                    <c:forEach var="loaiKhachSan" items="${loaikhachsans}" varStatus="status">
                        <c:if test="${status.index >= start && status.index < end}">
                            <tr>
                                <td>${loaiKhachSan.id}</td>
                                <td>${loaiKhachSan.ten}</td>
                                <td>${loaiKhachSan.moTa}</td>
                                <td><img src="${loaiKhachSan.urlHinhAnh}" alt="Hình ảnh" width="100"></td>
                                <td>${loaiKhachSan.soKhachSan}</td>
                                <td>
                                    <div style="display: flex; gap: 10px; align-items: center;">
                                        <a style="color: white; background-color: #007bff; padding: 8px 12px; text-decoration: none; border-radius: 5px;" 
                                           href="loaikhachsans?action=update&id=${loaiKhachSan.id}">Update</a>

                                        <a style="color: white; background-color: #dc3545; padding: 8px 12px; text-decoration: none; border-radius: 5px;" 
                                           href="loaikhachsans?action=delete&id=${loaiKhachSan.id}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa trường này?');">
                                            Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>


                <!-- Phân trang -->
                <div>
                    <c:if test="${currentPage > 1}">
                        <a href="loaikhachsans?page=${currentPage - 1}">Trước</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="loaikhachsans?page=${i}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="loaikhachsans?page=${currentPage + 1}">Sau</a>
                    </c:if>
                </div>
            </main>
        </div>  
    </body>
</html>
