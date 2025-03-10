<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String errorOTP = (String) request.getAttribute("errorOTP");
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP</title>
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
        input {
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
        <h2>Xác thực OTP</h2>
        <form action="${pageContext.request.contextPath}/verifyOTP" method="post">
            <input type="text" name="otp" placeholder="Nhập mã OTP" required>
            <button class="btn" type="submit">Xác nhận</button>
        </form>
        <% if (errorOTP != null) { %>
            <p class="error-message"><%= errorOTP %></p>
        <% } %>
        <a class="link-login" href="login.jsp">Quay lại đăng nhập</a>
    </div>
</body>
</html>
