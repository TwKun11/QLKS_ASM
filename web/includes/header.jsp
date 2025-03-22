<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.TaiKhoan, dao.DAOTaiKhoan" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

<%
    String currentPage = request.getRequestURI();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");

    if (user == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    String usernameFromCookie = cookie.getValue();
                    try {
                        DAOTaiKhoan daoTaiKhoan = new DAOTaiKhoan();
                        user = daoTaiKhoan.getByTenTaiKhoan(usernameFromCookie);
                        if (user != null) {
                            session.setAttribute("user", user);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nice Dream Hotel</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                margin: 0;
                font-family: 'Poppins', sans-serif;
                background-color: #f9f9f9;
            }
            .header {
                background-color: #36383b; /* Màu xanh dương nhạt */
                color: white;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 15px 50px;
                height: 70px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .nav {
                display: flex;
                align-items: center;
                gap: 30px;
            }
            .nav a {
                color: white;
                text-decoration: none;
                font-size: 16px;
                font-weight: 600;
                transition: color 0.3s ease;
            }
            .nav a:hover, .nav a.active {
                color: #F5A623; /* Màu vàng nhạt khi hover hoặc active */
            }
            .user {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .user a {
                background-color: #F5A623; /* Màu vàng nhạt */
                color: white;
                padding: 8px 20px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }
            .user a:hover {
                background-color: #e59400; /* Tông vàng đậm hơn khi hover */
            }
            .username {
                font-weight: 600;
                font-size: 16px;
                color: white;
            }
            .dashboard-btn {
                background-color: #F5A623; /* Màu vàng nhạt */
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 25px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none;
            }
            .dashboard-btn:hover {
                background-color: #e59400; /* Tông vàng đậm hơn khi hover */
            }
            /* Canh giữa nội dung nếu cần */
            .container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="container">
                <div class="nav">
                    <a href="${pageContext.request.contextPath}/home" class="<%= currentPage.contains("/home") ? "active" : "" %>">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/khachsan" class="<%= currentPage.contains("/khachsan") ? "active" : "" %>">Khách sạn</a>
                    <a href="${pageContext.request.contextPath}/pages/profile.jsp" class="<%= currentPage.contains("/pages/profile.jsp") ? "active" : "" %>">Cá nhân</a>
                    <a href="${pageContext.request.contextPath}/huydatphong" class="<%= currentPage.contains("huydatphong") ? "active" : "" %>">Lịch sử đặt phòng</a>
                    
                    <%-- Hiển thị Dashboard nếu user có idRole = 1 (admin) --%>
                    <% if (user != null && user.getIdRole() == 1) { %>
                        <a href="${pageContext.request.contextPath}/datphongs" class="dashboard-btn">🛠 Dashboard</a>
                    <% } %>
                </div>

                <div class="user">
                    <% if (user != null) { %>
                    <span class="username">Xin chào, <%= user.getTenTaiKhoan() %>!</span>
                    <a href="<%= request.getContextPath() %>/logout">Đăng Xuất</a>
                    <% } else { %>
                    <a href="<%= request.getContextPath() %>/pages/login.jsp">Đăng Nhập</a>
                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>