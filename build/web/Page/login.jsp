<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie, java.util.Base64" %>

<%
    // Kiểm tra Cookie để lấy thông tin đăng nhập nếu có
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
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="login-box text-center">
                    <h2 class="mb-4">Đăng nhập</h2>
                    <% String error = request.getParameter("error");
                       if (error != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> Sai tên đăng nhập hoặc mật khẩu!
                        </div>
                    <% } %>
                    <form action="LoginServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" name="username" class="form-control" required value="<%= savedUsername %>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" required value="<%= savedPassword %>">
                        </div>
                        <div class="mb-3 form-check text-start">
                            <input type="checkbox" name="remember" class="form-check-input" id="rememberMe" <% if (!savedUsername.isEmpty()) { %> checked <% } %>>
                            <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                    </form>
                    <p class="mt-3">Chưa có tài khoản? <a href="register.jsp">Đăng ký</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
