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
        <title>Đổi Mật Khẩu</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    </head>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
        }

        .container {
            display: flex;
            margin: 20px auto;
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

        .profile-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 70%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .profile-content h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-group label {
            width: 30%;
            font-weight: bold;
        }

        .form-group input {
            width: 65%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Footer */

    </style>
    <body>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <h3>Chỉnh sửa thông tin</h3>
                <ul>
                    <li><a href="<%= request.getContextPath() %>/pages/updateprofile.jsp">Cập nhật hồ sơ</a></li>
                    <li><a href="<%= request.getContextPath() %>/pages/changepassword.jsp">Đổi mật khẩu</a></li>
                    <li><a href="<%= request.getContextPath() %>/huydatphong">Lịch sử đặt phòng</a></li>
                </ul>
            </div>

            <!-- Nội dung chính -->
            <div class="profile-content">
                <h2>Đổi Mật Khẩu</h2>
                <% if (request.getAttribute("message") != null) { %>
                <p style="color: red; text-align: center;"><%= request.getAttribute("message") %></p>
                <% } %>
                <form action="<%= request.getContextPath() %>/ChangePasswordServlet" method="post">
                    <div class="form-group">
                        <label for="oldPassword">Mật khẩu cũ:</label>
                        <input type="password" id="oldPassword" name="oldPassword" required>
                    </div>

                    <div class="form-group">
                        <label for="newPassword">Mật khẩu mới:</label>
                        <input type="password" id="newPassword" name="newPassword" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <button type="submit">Đổi mật khẩu</button>
                </form>
            </div>
        </div>

        <%@ include file="/includes/footer.jsp" %>
    </body>
</html>
