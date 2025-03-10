<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String errorRegister = (String) request.getAttribute("errorRegister");
    String successRegister = (String) request.getAttribute("successRegister");
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <style>
        body {
            background: linear-gradient(to right, #8CA6DB, #B993D6);
        }
        .container {
            width: 400px;
            margin: 80px auto;
            background: white;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            text-align: center;
        }
        h2 {
            color: #B993D6;
        }
        input, select {
            width: 90%;
            height: 40px;
            margin-top: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            padding-left: 10px;
        }
        .btn {
            width: 95%;
            height: 45px;
            background: linear-gradient(to right, #8CA6DB, #B993D6);
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 20px;
            cursor: pointer;
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
        .success-message {
            color: green;
            margin-top: 10px;
        }
        .link-login {
            display: block;
            margin-top: 10px;
            text-decoration: none;
            color: #B993D6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng ký tài khoản</h2>
        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
            <input type="text" name="username" placeholder="Tên đăng nhập" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
            <input type="text" name="fullName" placeholder="Họ và tên" required>
            <input type="text" name="phone" placeholder="Số điện thoại" required>
            <input type="email" name="email" placeholder="Email" required>
            <select name="gender">
                <option value="true">Nam</option>
                <option value="false">Nữ</option>
            </select>
            <button class="btn" type="submit">Đăng ký</button>
        </form>

        <% if (errorRegister != null) { %>
            <p class="error-message"><%= errorRegister %></p>
        <% } %>

        <% if (successRegister != null) { %>
            <p class="success-message"><%= successRegister %></p>
        <% } %>

        <a class="link-login" href="pages/login.jsp">Quay lại đăng nhập</a>
    </div>
</body>
</html>  