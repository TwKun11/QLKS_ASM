<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(to right, #8CA6DB, #B993D6);
        }
      
        .forgot-password {
            display: flex;
            width: 1190px;
            height: 600px;
            background: white;
            margin: 72px auto 0;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
        }
        
        .forgot-password .row1 {
            width: 60%;
            height: 600px;
            background: linear-gradient(to right, #8CA6DB, #B993D6);
        }
        
        .forgot-password .row1 h1 {
            margin-top: 50px;
            text-align: center;
            color: #fff;
            font-size: 40px;
        }
        
        .forgot-password .row1 img {
            margin-top: 30px;
            margin-left: 60px;
            width: 600px;
            height: 400px;
        }
        
        .forgot-password .row2 {
            margin: auto auto;
        }
        
        .forgot-password .row2 h2 {
            color: #B993D6;
            margin-left: 66px;
            margin-bottom: 6px;
        }
        
        .forgot-password .row2 input {
            margin-top: 20px;
            width: 250px;
            height: 40px;
            border-radius: 20px;
            border: 1px solid rgba(0, 0, 0, .56);
            text-indent: 12px;
        }
        
        .btn-submit {
            border-style: none;
            background: linear-gradient(to right, #8CA6DB, #B993D6);
            border-radius: 40px;
            color: white;
            width: 150px;
            height: 50px;
            margin-top: 30px;
            margin-left: 56px;
            cursor: pointer;
        }
        
        .error-message, .success-message {
            text-align: center;
            margin-top: 10px;
        }
        
        .error-message {
            color: red;
        }
        
        .success-message {
            color: green;
        }
    </style>
</head>
<body>
    <div class="forgot-password">
        <div class="row1">
            <h1>Quên mật khẩu</h1>
            <img src="${pageContext.request.contextPath}/Content/Images/login.jpg" alt="Forgot Password Image"/>
        </div>
        <div class="row2">
            <form action="${pageContext.request.contextPath}/forgotPassword" method="post">
                <h2>Nhập thông tin</h2>
                <input type="text" name="username" placeholder="Tên đăng nhập" required> <br/>
                <input type="email" name="email" placeholder="Email đã đăng ký" required> <br/>
                
                <% if (error != null) { %>
                    <p class="error-message"><%= error %></p>
                <% } %>
                
                <% if (message != null) { %>
                    <p class="success-message"><%= message %></p>
                <% } %>
                
                <button class="btn-submit" type="submit">Gửi OTP</button>
            </form>
        </div>
    </div>
</body>
</html>
