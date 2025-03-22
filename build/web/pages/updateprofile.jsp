<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.TaiKhoan" %>
<%@ include file="/includes/header.jsp" %>
<%
    
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa thông tin cá nhân</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            display: flex;
            width: 1200px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            flex-grow: 1;
        }
        .sidebar {
            width: 250px;
            border-right: 1px solid #ddd;
            padding-right: 20px;
        }
        .sidebar h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            margin: 10px 0;
        }
        .sidebar ul li a {
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }

        /* Form chỉnh sửa */
        .profile-content {
            width: 75%;
            padding: 20px;
        }

        h2 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f8f9fa;
        }

        input:read-only {
            background-color: #e9ecef;
        }

        button {
            width: 100%;
            padding: 10px;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s;
        }

        button[type="submit"] {
            background-color: #007bff;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        .cancel {
            background-color: #dc3545;
            margin-top: 10px;
        }

        .cancel:hover {
            background-color: #c82333;
        }

        /* Footer */
      

    </style>
    <body>
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
                <h2>Chỉnh sửa thông tin cá nhân</h2>
                <% if (request.getAttribute("message") != null) { %>
                <p style="color: red; text-align: center;"><%= request.getAttribute("message") %></p>
                <% } %>
                <form action="<%= request.getContextPath() %>/profile" method="post">
                    <div class="form-group">
                        <label for="tenTaiKhoan">Tên tài khoản:</label>
                        <input type="text" id="tenTaiKhoan" value="<%= user.getTenTaiKhoan() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="hoTen">Họ và tên:</label>
                        <input type="text" id="hoTen" name="hoTen" value="<%= user.getHoTen() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="gioiTinh">Giới tính:</label>
                        <select id="gioiTinh" name="gioiTinh">
                            <option value="true" <%= user.isGioiTinh() ? "selected" : "" %>>Nam</option>
                            <option value="false" <%= !user.isGioiTinh() ? "selected" : "" %>>Nữ</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="soDienThoai">Số điện thoại:</label>
                        <input type="text" id="soDienThoai" name="soDienThoai" value="<%= user.getSoDienThoai() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                    </div>

                    <input type="hidden" name="returnToProfile" value="true">

                    <button type="submit">Lưu thay đổi</button>

                    <a href="<%= request.getContextPath() %>/pages/profile.jsp">
                        <button type="button" class="cancel">Hủy</button>
                    </a>
                </form>
            </div>
        </div>

    <%@ include file="/includes/footer.jsp" %>
    </body>
</html>
