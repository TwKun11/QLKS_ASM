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
            background: linear-gradient(to right, #74ebd5, #acb6e5); /* Gradient xanh ngọc và tím nhạt */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .success-container {
            background: #ffffff;
            width: 700px; /* Giảm chiều rộng để gọn hơn */
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); /* Bóng nhẹ nhàng hơn */
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-icon {
            font-size: 70px;
            color: #2ecc71; /* Xanh lá tươi sáng hơn */
            margin-bottom: 20px;
            animation: bounceIn 0.6s ease-out;
        }

        .success-container h1 {
            color: #2ecc71; /* Đồng bộ màu xanh lá với icon */
            font-size: 34px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .success-container p {
            font-size: 18px;
            color: #6c757d; /* Xám đậm nhẹ nhàng */
            margin-bottom: 10px;
        }

        .btn-home {
            margin-top: 25px;
            padding: 12px 30px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 50px; /* Bo tròn hơn */
            border: none;
            background: linear-gradient(to right, #74ebd5, #acb6e5); /* Đồng bộ với nền */
            color: #ffffff;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background: linear-gradient(to right, #acb6e5, #74ebd5); /* Đảo ngược gradient */
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15); /* Bóng nổi hơn khi hover */
        }

        /* Hiệu ứng bounce cho icon */
        @keyframes bounceIn {
            0% { transform: scale(0.3); opacity: 0; }
            50% { transform: scale(1.05); opacity: 1; }
            100% { transform: scale(1); }
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