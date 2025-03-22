<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
%>

<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt lại mật khẩu</title>
        
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                background: linear-gradient(to right, #8CA6DB, #B993D6);
            }
          
            .login {
                display: flex;
                width: 1190px;
                height: 600px;
                background: white;
                margin: 72px auto 0;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            }
            
            .login .row1 {
                width: 60%;
                height: 600px;
                background: linear-gradient(to right, #8CA6DB, #B993D6);
            }
            
            .login .row1 h1 {
                margin-top: 50px;
                text-align: center;
                color: #fff;
                font-size: 40px;
            }
            
            .login .row1 p {
                margin-top: 16px;
                text-align: center;
                color: #eee;
                font-size: 20px;
            }
            
            .login .row1 img {
                margin-top: 30px;
                margin-left: 60px;
                width: 600px;
                height: 400px;
            }
            
            .login .row2 {
                margin: auto auto;
            }
            
            .login .row2 h2 {
                color: #B993D6;
                margin-left: 66px;
                margin-bottom: 6px;
            }
            
            .login .row2 input {
                margin-top: 20px;
                width: 250px;
                height: 40px;
                border-radius: 20px;
                border: 1px solid rgba(0, 0, 0, .56);
                text-indent: 12px;
            }
            
            .login .row2 .remember {
                color: #333;
                margin-top: 10px;
                text-align: center;
            }
            
            .btn-login {
                border-style: none;
                background: linear-gradient(to right, #8CA6DB, #B993D6);
                border-radius: 40px;
                color: white;
                width: 150px;
                height: 50px;
                margin-top: 30px;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }

            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
            
        </style>
    </head>
    <body>
        <div id="body">
            <div class="login">
                <div class="row1">
                    <h1>Reset Your Password</h1>
                    <p>Enter your new password to continue.</p>
                    <img src="${pageContext.request.contextPath}/Content/Images/login.jpg" alt="Reset Password Image"/>
                </div>
                <div class="row2">
                    <form action="${pageContext.request.contextPath}/resetPassword" method="post" autocomplete="off">
                        <h2>Đặt lại mật khẩu</h2>
                        <input type="password" name="newPassword" placeholder="Mật khẩu mới" required> <br/>
                        <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required> <br/>

                        <% if (error != null) { %>
                            <p class="error-message"><%= error %></p>
                        <% } %>

                        <button class="btn-login" type="submit">Xác nhận</button>
                    </form>
                    
                    <div class="remember">
                        <a href="login.jsp">Quay lại đăng nhập</a>
                    </div>
                </div>   
            </div>
        </div>
    </body>
</html>
