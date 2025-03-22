<%-- 
    Document   : admin_home
    Created on : Mar 15, 2025, 11:08:38 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* General styles */
            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f6f9;
                overflow-x: hidden; /* Ngăn cuộn ngang */
            }

            /* Sidebar container */
            .container {
                width: 280px; /* Chiều rộng lớn hơn cho cảm giác chuyên nghiệp */
                background: linear-gradient(135deg, #2C3E50, #34495E);
                color: white;
                height: 100vh;
                display: flex;
                flex-direction: column;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease-in-out;
                position: fixed; /* Cố định sidebar */
                left: 0;
                top: 0;
                z-index: 1000;
            }

            /* User Info Section */
            .user-info {
                text-align: center;
                padding: 20px 15px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
                margin-bottom: 20px;
            }

            .user-info img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid rgba(255, 255, 255, 0.3);
                margin-bottom: 10px;
            }

            .user-info b {
                font-size: 18px;
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

            .user-info p {
                font-size: 20px;
                margin: 0;
                opacity: 0.8;
            }

            /* Navigation Links */
            .nav {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 8px;
                padding: 0 20px;
            }

            .nav a {
                display: flex;
                align-items: center;
                gap: 12px;
                color: white;
                text-decoration: none;
                font-size: 15px;
                font-weight: 500;
                padding: 12px 16px;
                border-radius: 8px;
                transition: all 0.3s ease-in-out;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(5px);
                white-space: nowrap;
            }

            .nav a:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateX(5px);
                box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.3);
            }

            .nav a.active {
                background: rgba(255, 255, 255, 0.3);
                box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.3);
            }

            /* Icons Styling */
            .nav a i {
                font-size: 18px;
                opacity: 0.8;
            }

            /* Responsive Design */
            @media screen and (max-width: 768px) {
                .container {
                    width: 100%;
                    height: auto;
                    padding: 15px;
                    border-radius: 0;
                }

                .nav a {
                    font-size: 14px;
                    padding: 10px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- User Info -->
            <div class="user-info">
                <p><b>${sessionScope.account.tenTaiKhoan}</b></p>
                <p>Chào mừng bạn trở lại</p>
            </div>

            <!-- Navigation Links -->
            <div class="nav">
                <a href="${pageContext.request.contextPath}/datphongs" ><i class="fas fa-calendar-alt"></i> Đặt Phòng</a>
                <a href="${pageContext.request.contextPath}/khachsans"><i class="fas fa-building"></i> Khách Sạn</a>
                <a href="${pageContext.request.contextPath}/loaikhachsans"><i class="fas fa-tags"></i> Loại Khách Sạn</a>
                <a href="${pageContext.request.contextPath}/phongs"><i class="fas fa-bed"></i> Phòng</a>
                <a href="${pageContext.request.contextPath}/taikhoans"><i class="fas fa-users"></i> Tài Khoản</a>
                <a href="${pageContext.request.contextPath}/thanhphos"><i class="fas fa-city"></i> Thành Phố</a>
                <a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Back</a>
            </div>
        </div>
    </body>
</html>
