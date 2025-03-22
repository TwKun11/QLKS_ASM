<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thành công</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        body {
            background: linear-gradient(to right, #8CA6DB, #B993D6);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .success-container {
            background: white;
            width: 800px;
            height: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.3);
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        .success-icon {
            font-size: 60px;
            color: #4CAF50;
            margin-bottom: 15px;
        }

        .success-container h1 {
            color: #4CAF50;
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .success-container p {
            font-size: 18px;
            color: #555;
        }

        .btn-home {
            margin-top: 20px;
            padding: 12px 25px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 30px;
            border: none;
            background: linear-gradient(to right, #8CA6DB, #B993D6);
            color: white;
            text-decoration: none;
            transition: 0.3s ease-in-out;
        }

        .btn-home:hover {
            background: linear-gradient(to right, #B993D6, #8CA6DB);
            transform: scale(1.05);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="success-container">
        <i class="bi bi-check-circle-fill success-icon"></i>
        <h1>Đăng ký thành công!</h1>
        <p>Chúc mừng! Tài khoản của bạn đã được tạo thành công.</p>
        <p>Bạn có thể đăng nhập ngay bây giờ.</p>
        <a href="login.jsp" class="btn-home">Đăng nhập ngay</a>
    </div>
</body>
</html>
