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
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }
            .header {
                background-color: #002b5c;
                color: white;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 20px 50px;
                height: 80px;
            }
            .nav {
                display: flex;
                gap: 25px;
            }
            .nav a {
                color: white;
                text-decoration: none;
                font-size: 18px;
                font-weight: bold;
                transition: color 0.3s;
            }
            .nav a:hover, .nav a.active {
                color: #00aaff;
            }
            .user {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .user a {
                background-color: #00aaff;
                color: white;
                padding: 8px 15px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
            }
            .user a:hover {
                background-color: #0077cc;
            }
            .username {
                font-weight: bold;
                font-size: 18px;
                margin-right: 15px;
            }
            .dashboard-btn {
                background-color: #ffdd57;
                color: black;
                border: none;
                padding: 10px 15px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s ease;
                text-decoration: none;
            }
            .dashboard-btn:hover {
                background-color: #ffcc00;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="nav">
                <a href="${pageContext.request.contextPath}/home" class="<%= currentPage.contains("/home") ? "active" : "" %>">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/khachsan" class="<%= currentPage.contains("/khachsan") ? "active" : "" %>">Khách sạn</a>
                <a href="${pageContext.request.contextPath}/pages/profile.jsp" class="<%= currentPage.contains("/pages/profile.jsp") ? "active" : "" %>">Cá nhân</a>
                <a href="${pageContext.request.contextPath}/huydatphong" class="<%= currentPage.contains("huydatphong") ? "active" : "" %>">Lịch sử đặt phòng</a>
                
                <%-- Hiển thị Dashboard nếu user có idRole = 1 (admin) --%>
                <% if (user != null && user.getIdRole() == 1) { %>
                    <a href="${pageContext.request.contextPath}/khachsans" class="dashboard-btn">🛠 DashBoard</a>
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
    </body>
</html>
