<%-- 
    Document   : header
    Created on : Feb 23, 2025, 9:28:49 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .logo img {
            height: 70px;
            transition: transform 0.3s ease-in-out;
        }
        .logo img:hover {
            transform: scale(1.1);
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
            transition: color 0.3s ease-in-out;
            position: relative;
        }
        .nav a::after {
            content: "";
            display: block;
            width: 0;
            height: 2px;
            background: #00aaff;
            transition: width 0.3s;
            position: absolute;
            bottom: -5px;
            left: 0;
        }
        .nav a:hover {
            color: #00aaff;
        }
        .nav a:hover::after {
            width: 100%;
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
            transition: background 0.3s ease-in-out;
        }
        .user a:hover {
            background-color: #0077cc;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img src="Content/Images/Logo.png" alt="Nice Dream Hotel">
        </div>
        <div class="nav">
            <a href="index.jsp"><b>Trang chủ</b></a>
            <a href="hotels.jsp">Khách sạn</a>
            <a href="profile.jsp">Cá nhân</a>
            <a href="news.jsp">Tin tức</a>
            <a href="contact.jsp">Liên hệ</a>
        </div>
        <div class="user">
            <a href="login.jsp">Đăng Nhập</a>
            <a href="logout.jsp">Đăng Xuất</a>
        </div>
    </div>
</body>
</html>