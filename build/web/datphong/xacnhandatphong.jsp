<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đặt Phòng</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #121212;
            color: #ffffff;
            line-height: 1.6;
            overflow-x: hidden;
        }
        header {
            background-color: #1e1e1e;
            position: relative;
            z-index: 10;
        }
        .container {
            width: 50%;
            margin: 40px auto;
            padding: 30px;
            background-color: #222;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(255, 255, 255, 0.1);
            animation: fadeInUp 0.8s ease-out;
        }
        h1 {
            font-size: 32px;
            color: #0d6efd;
            text-align: center;
            margin-bottom: 30px;
            animation: slideInFromTop 0.8s ease-out;
        }
        h3 {
            font-size: 22px;
            color: #0d6efd;
            margin: 20px 0 10px;
        }
        .message {
            color: #28a745;
            text-align: center;
            font-size: 16px;
            margin: 20px 0;
            animation: fadeIn 0.5s ease-out;
        }
        .error {
            color: #d32f2f;
            text-align: center;
            font-size: 16px;
            margin: 20px 0;
            animation: fadeIn 0.5s ease-out;
        }
        p {
            font-size: 16px;
            color: #ccc;
            margin: 10px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        p strong {
            color: #ffffff;
            min-width: 150px;
        }
        p i {
            color: #0d6efd;
        }
        ul {
            list-style: none;
            padding: 0;
            margin: 10px 0;
        }
        ul li {
            font-size: 15px;
            color: #ccc;
            margin: 8px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        ul li i {
            color: #0d6efd;
        }
        form {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 10px;
        }
        button {
            background: linear-gradient(45deg, #0d6efd, #00b7eb);
            color: #fff;
            padding: 12px 35px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        button:hover {
            background: linear-gradient(45deg, #0056b3, #0096c7);
            transform: translateY(-2px);
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideInFromTop {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <header>
        <%@ include file="/includes/header.jsp" %>
    </header>

    <div class="container">
        <h1><i class="fas fa-check-circle"></i> Xác Nhận Đặt Phòng</h1>

        <c:if test="${not empty message}">
            <p class="message"><i class="fas fa-check"></i> ${message}</p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="error"><i class="fas fa-exclamation-circle"></i> ${error}</p>
        </c:if>

        <h3><i class="fas fa-user"></i> Thông Tin Khách Hàng</h3>
        <p><i class="fas fa-user-circle"></i> <strong>Tên đăng nhập:</strong> ${username.tenTaiKhoan}</p>
        <p><i class="fas fa-envelope"></i> <strong>Email:</strong> ${username.email}</p>
        <p><i class="fas fa-phone"></i> <strong>Số điện thoại:</strong> ${username.soDienThoai}</p>

        <h3><i class="fas fa-bed"></i> Thông Tin Phòng</h3>
        <p><i class="fas fa-key"></i> <strong>ID Phòng:</strong> ${tenPhong}</p>
        <p><i class="fas fa-calendar-alt"></i> <strong>Ngày nhận phòng:</strong> ${ngayDen}</p>
        <p><i class="fas fa-calendar-alt"></i> <strong>Ngày trả phòng:</strong> ${ngayTra}</p>        
        <p><i class="fas fa-calendar-alt"></i> <strong>Giá Thuê:</strong> ${giaThue} VND</p>

        <!-- Form cho Thanh toán khi nhận phòng -->
        <form action="xacnhandatphong" method="post">
            <input type="hidden" name="giaThue" value="${giaThue}">
            <input type="hidden" name="giaThue" value="${giaThue}">
            <input type="hidden" name="idPhong" value="${idPhong}">
            <input type="hidden" name="ngayDen" value="${ngayDen}">
            <input type="hidden" name="ngayTra" value="${ngayTra}">
            <button type="submit"><i class="fas fa-check"></i> Thanh Toán Khi Nhận Phòng</button>
        </form>

        <!-- Form cho Thanh toán qua VNPay -->
        <form action="payment" method="post">
            <input type="hidden" name="giaThue" value="${giaThue}">
            <input type="hidden" name="idPhong" value="${idPhong}">
            <input type="hidden" name="ngayDen" value="${ngayDen}">
            <input type="hidden" name="ngayTra" value="${ngayTra}">
            <input type="hidden" name="orderInfo" value="Thanh toan dat phong ID ${idPhong}">
            <button type="submit"><i class="fas fa-credit-card"></i> Thanh Toán Qua VNPay</button>
        </form>
    </div>
</body>
</html>