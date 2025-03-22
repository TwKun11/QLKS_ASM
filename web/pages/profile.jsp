<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.TaiKhoan" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ cá nhân - Nice Dream Hotel</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                color: #333;
            }

            /* Đảm bảo header không bị che */
            header {
                position: sticky;
                top: 0;
                z-index: 1000; /* Đưa header lên trên cùng */
                width: 100%;
            }

            .container {
                display: flex;
                width: 90%;
                max-width: 1200px;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                flex-grow: 1;
                animation: fadeIn 0.8s ease-in-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Sidebar */
            .sidebar {
                width: 260px;
                padding-right: 20px;
                border-right: 1px solid #eee;
            }

            .sidebar h3 {
                font-size: 20px;
                font-weight: 600;
                color: #4A90E2; /* Xanh dương nhạt */
                margin-bottom: 20px;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li {
                margin: 15px 0;
                transition: transform 0.3s ease;
            }

            .sidebar ul li:hover {
                transform: translateX(5px);
            }

            .sidebar ul li a {
                text-decoration: none;
                color: #555;
                font-size: 15px;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .sidebar ul li a:hover {
                color: #F5A623; /* Vàng nhạt */
            }

            /* Profile Content */
            .profile-content {
                flex-grow: 1;
                padding-left: 30px;
            }

            .profile-content h2 {
                text-align: center;
                font-size: 28px;
                font-weight: 600;
                color: #4A90E2; /* Xanh dương nhạt */
                margin-bottom: 25px;
            }

            .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
                padding: 10px 0;
                border-bottom: 1px solid #eee;
            }

            .form-group label {
                font-size: 16px;
                font-weight: 600;
                width: 150px;
                color: #333;
            }

            .form-group input {
                flex-grow: 1;
                border: 1px solid #ddd;
                background: #f9f9f9;
                padding: 10px;
                border-radius: 5px;
                font-size: 15px;
                color: #555;
                transition: border-color 0.3s ease;
            }

            .form-group input:hover {
                border-color: #4A90E2; /* Xanh dương nhạt */
            }

            /* Password Container */
            .password-container {
                position: relative;
                display: flex;
                align-items: center;
                width: calc(100% - 150px);
            }

            .password-container input {
                width: 100%;
                padding-right: 60px; /* Để chỗ cho nút */
            }

            .password-container button {
                position: absolute;
                right: 5px;
                border: none;
                background: #F5A623; /* Vàng nhạt */
                color: white;
                padding: 6px 12px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
                transition: background 0.3s ease;
            }

            .password-container button:hover {
                background: #e59400; /* Tông vàng đậm hơn */
            }

            /* Responsive */
            @media (max-width: 768px) {
                .container {
                    flex-direction: column;
                    width: 95%;
                    padding: 20px;
                }
                .sidebar {
                    width: 100%;
                    border-right: none;
                    border-bottom: 1px solid #eee;
                    padding-bottom: 20px;
                    margin-bottom: 20px;
                }
                .profile-content {
                    padding-left: 0;
                }
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .form-group label {
                    width: 100%;
                    margin-bottom: 5px;
                }
                .form-group input {
                    width: 100%;
                }
                .password-container {
                    width: 100%;
                }
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
                <div class="form-group">
                    <label>Mật khẩu:</label>
                    <div class="password-container">
                        <input type="password" id="passwordField" value="<%= user.getMatKhau() %>" readonly>
                        <button type="button" id="togglePassword" onclick="togglePasswordVisibility()">Hiện</button>
                    </div>
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
        <%@ include file="/includes/footer.jsp" %>
    </body>
</html>