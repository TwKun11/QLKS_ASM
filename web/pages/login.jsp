<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie, java.util.Base64" %>

<%
    String savedUsername = "";
    String savedPassword = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                savedUsername = cookie.getValue();
            }
            if (cookie.getName().equals("password")) {
                savedPassword = new String(Base64.getDecoder().decode(cookie.getValue()));
            }
        }
    }
    String error = (String) request.getAttribute("error");
%>

<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>
        
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            a {
                text-decoration: none;
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
                display: flex;
                justify-content: space-between;
            }
            
            .login .box-remember {
                display: flex;
                align-items: center;
            }
            
            .login .remember input {
                margin-top: 0;
                margin-right: 4px;
                width: 16px;
                height: 16px;
            }
            
            .login .btn-login {
                border-style: none;
                background: linear-gradient(to right, #8CA6DB, #B993D6);
                border-radius: 40px;
                color: white;
                width: 122px;
                height: 50px;
                margin-top: 30px;
                margin-left: 56px;
            }

            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
            
            .login-social {
                width: 258px;
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
            }
            
            .login-social .row {
                display: flex;
                background: #fff;
                align-items: center;
                justify-content: center;
                width: 125px;
                height: 40px;
                border: 1px solid rgba(0, 0, 0, .26);
                border-radius: 4px;
                color: #333;
            }
            
            .login-social .row div {
                padding-right: 4px;
            }
            
            .login-social .row img {
                margin-right: 4px;
                width: 40px;
                height: 40px;
            }
            
            .login-social .facebook img {
                width: 30px;
                height: 30px;
            }
        </style>
    </head>
    <body>
        <div id="body">
            <div class="login">
                <div class="row1">
                    <h1>Welcome to login</h1>
                    <p>Where Comfort Meets Elegance – Your Perfect Stay Awaits!</p>
                    <img src="${pageContext.request.contextPath}/Content/Images/login.jpg" alt="Login Image"/>
                </div>
                <div class="row2">
                    <form action="${pageContext.request.contextPath}/LoginServlet" method="post" autocomplete="off">
                        <h2>Đăng nhập</h2>
                        <input type="text" name="username" placeholder="Tên đăng nhập" value="<%= savedUsername %>" autocomplete="new-username" required> <br/>
                        <input type="password" name="password" placeholder="Mật khẩu" value="<%= savedPassword %>" autocomplete="new-password" required> <br/>
                              
                        <div class="remember">
                            <div class="box-remember">
                                <input type="checkbox" name="remember">
                                <label>Remember me</label>
                            </div>    
                            <a href="register.jsp">Đăng ký</a> <br>
                        </div>
                        <a href="forgotPassword.jsp">Quên mật khẩu?</a>

                        <% if (error != null) { %>
                            <p class="error-message"><%= error %></p>
                        <% } %>
                        
                        <button class="btn-login" type="submit">Đăng nhập</button>
                    </form>
                    <div class="login-social">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/roombooking/LoginServlet&response_type=code&client_id=525166296465-ja0fugrj1lo0s5k5eee86kq5jhg1rbq0.apps.googleusercontent.com&approval_prompt=force" 
                                class="row google">
                            <img src="${pageContext.request.contextPath}/Content/Images/google.png" alt="Google"/>
                            <div>Google</div>
                        </a>
                        <a href="YOUR_FACEBOOK_LOGIN_URL" class="row facebook">
                            <img src="${pageContext.request.contextPath}/Content/Images/facebook.png" alt="Facebook"/>
                            <div>Facebook</div>
                        </a>
                    </div>             
                </div>   
            </div>
        </div>

        <script>
            // Chỉ xóa giá trị input nếu không có cookie
            window.onload = function () {
                <% if (savedUsername.isEmpty() && savedPassword.isEmpty()) { %>
                    document.getElementsByName("username")[0].value = "";
                    document.getElementsByName("password")[0].value = "";
                <% } %>
            }
        </script>

    </body>
</html>