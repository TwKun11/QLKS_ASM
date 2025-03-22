<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #121212; /* Nền tối */
            color: #ffffff; /* Màu chữ trắng */
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        header {
            width: 100%;
            background-color: #1e1e1e; /* Màu nền header tối hơn */
            padding: 15px 0;
            text-align: center;
            border-bottom: 1px solid #333; /* Đường viền dưới header */
        }

        header h1 {
            font-size: 1.5rem;
            color: #ffffff;
            margin: 0;
        }

        main {
            width: 100%;
            max-width: 600px;
            margin-top: 20px;
            text-align: center;
        }

        .result-card {
            background: linear-gradient(145deg, #222222, #1e1e1e); /* Gradient nền tối */
            border-radius: 15px;
            box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.3), 
                        -10px -10px 20px rgba(255, 255, 255, 0.1);
            padding: 30px;
            margin: 20px auto;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .result-card:hover {
            transform: scale(1.05);
            box-shadow: 15px 15px 30px rgba(0, 0, 0, 0.4), 
                        -15px -15px 30px rgba(255, 255, 255, 0.2);
        }

        .result-title {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #4CAF50; /* Màu xanh lá cây cho tiêu đề */
        }

        .result-message {
            font-size: 1.2rem;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .success {
            background-color: #388e3c; /* Màu xanh đậm */
            color: #ffffff;
            border: 1px solid #2e7d32;
        }

        .error {
            background-color: #d32f2f; /* Màu đỏ đậm */
            color: #ffffff;
            border: 1px solid #c62828;
        }

        .additional-info {
            font-size: 1rem;
            margin-top: 20px;
            color: #cccccc; /* Màu chữ nhạt hơn */
        }

        .back-button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1rem;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .back-button:hover {
            background-color: #45a049;
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <header>
        <%@ include file="/includes/header.jsp" %>
    </header>
    <main class="container">
        <div class="result-card">
            <h1 class="result-title">Kết quả thanh toán</h1>
            <% if (request.getAttribute("message") != null) { %>
                <p class="result-message success"><%= request.getAttribute("message") %></p>
            <% } else if (request.getAttribute("error") != null) { %>
                <p class="result-message error"><%= request.getAttribute("error") %></p>
            <% } %>
            <div class="additional-info">
                <p>Vui lòng đến đúng giờ đã đặt phòng để tránh mất chỗ.</p>
                <p>Trong trường hợp cần hỗ trợ hoặc thắc mắc, vui lòng liên hệ với chúng tôi qua số điện thoại: 0987654321.</p>
                <p>Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!</p>
            </div>
            <a href="home" class="back-button">Quay lại trang chủ</a>
        </div>
    </main>
</body>
</html>