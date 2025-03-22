<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.TaiKhoan" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ cá nhân</title>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                color: #333;
            }

            .container {
                display: flex;
                margin: 40px auto;
                width: 90%;
                max-width: 1200px;
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                flex-grow: 1;
                animation: fadeIn 0.8s ease-in-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Sidebar */
            .sidebar {
                width: 260px;
                border-right: 2px solid #eee;
                padding-right: 20px;
            }

            .sidebar h3 {
                font-size: 20px;
                margin-bottom: 15px;
                color: #007bff;
                font-weight: bold;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li {
                margin: 12px 0;
                transition: transform 0.3s;
            }

            .sidebar ul li:hover {
                transform: translateX(5px);
            }

            .sidebar ul li a {
                text-decoration: none;
                color: #555;
                font-size: 16px;
                font-weight: 500;
                transition: color 0.3s;
            }

            .sidebar ul li a:hover {
                color: #007bff;
            }

            /* Nội dung hồ sơ */
            .profile-content {
                flex-grow: 1;
                padding-left: 30px;
            }

            .profile-content h2 {
                text-align: center;
                font-size: 26px;
                color: #333;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 15px;
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            .form-group label {
                font-size: 18px;
                font-weight: 600;
                width: 150px;
                color: #444;
            }

            .form-group input {
                flex-grow: 1;
                border: none;
                background: #f0f0f0;
                padding: 10px;
                border-radius: 6px;
                font-size: 16px;
                transition: background 0.3s;
            }

            .form-group input:hover {
                background: #e9ecef;
            }

            /* Nút hiển thị mật khẩu */
            .password-container {
                display: flex;
                align-items: center;
            }

            .password-container button {
                border: none;
                background: #007bff;
                color: white;
                padding: 5px 10px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                transition: background 0.3s;
            }

            .password-container button:hover {
                background: #0056b3;
            }

            /* Footer */
            footer {
                background-color: #343a40;
                color: white;
                text-align: center;
                padding: 15px;
                margin-top: auto;
                font-size: 16px;
            }
        </style>
        <script>
            function togglePasswordVisibility() {
                var passwordField = document.getElementById("passwordField");
                var toggleButton = document.getElementById("togglePassword");
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    toggleButton.textContent = "Ẩn";
                } else {
                    passwordField.type = "password";
                    toggleButton.textContent = "Hiện";
                }
            }
        </script>
    </head>
    <body>
        <%@ include file="/includes/header.jsp" %>
        <%
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                return;
            }
        %>
        <div class="container">
            <div class="sidebar">
                <h3>Chỉnh sửa thông tin</h3>
                <ul>
                    <li><a href="<%= request.getContextPath() %>/pages/updateprofile.jsp">Cập nhật hồ sơ</a></li>
                    <li><a href="<%= request.getContextPath() %>/pages/changepassword.jsp">Đổi mật khẩu</a></li>
                    <li><a href="<%= request.getContextPath() %>/huydatphong">Lịch sử đặt phòng</a></li>
                </ul>
            </div>
            <div class="profile-content">
                <h2>Thông tin cá nhân</h2>
                <div class="form-group">
                    <label>Tên tài khoản:</label>
                    <input type="text" value="<%= user.getTenTaiKhoan() %>" readonly>
                </div>
                <div class="form-group password-container">
                    <label>Mật khẩu:</label>
                    <input type="password" id="passwordField" value="<%= user.getMatKhau() %>" readonly>
                    <button type="button" id="togglePassword" onclick="togglePasswordVisibility()">Hiện</button>
                </div>
                <div class="form-group">
                    <label>Tên đầy đủ:</label>
                    <input type="text" value="<%= user.getHoTen() %>" readonly>
                </div>
                <div class="form-group">
                    <label>Giới tính:</label>
                    <input type="text" value="<%= user.isGioiTinh() ? "Nam" : "Nữ" %>" readonly>
                </div>
                <div class="form-group">
                    <label>Số điện thoại:</label>
                    <input type="text" value="<%= user.getSoDienThoai() %>" readonly>
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="text" value="<%= user.getEmail() %>" readonly>
                </div>
            </div>
        </div>
        <footer class="bg-dark text-white text-center py-4 mt-5">
            <p>&copy; 2025 Nice Dream Hotel. All rights reserved.</p>
        </footer>
    </body>
</html>
