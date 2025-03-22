<%-- 
    Document   : accessDenied
    Created on : Mar 1, 2025, 11:37:49 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Access Denied - Nice Dream Hotel</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                margin: 0;
                font-family: 'Poppins', sans-serif;
                background-color: #f9f9f9;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                text-align: center;
            }
            .container {
                background-color: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                width: 100%;
            }
            h1 {
                color: #4A90E2; /* Màu xanh dương nhạt */
                font-size: 32px;
                font-weight: 600;
                margin-bottom: 20px;
            }
            p {
                color: #666;
                font-size: 16px;
                margin-bottom: 30px;
            }
            a {
                display: inline-block;
                background-color: #F5A623; /* Màu vàng nhạt */
                color: white;
                padding: 12px 25px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            a:hover {
                background-color: #e59400; /* Tông vàng đậm hơn khi hover */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Bạn không có quyền truy cập vào trang này!</h1>
            <p>Vui lòng đăng nhập bằng tài khoản có quyền phù hợp để tiếp tục.</p>
            <a href="login.jsp">Quay lại trang đăng nhập</a>
        </div>
    </body>
</html>