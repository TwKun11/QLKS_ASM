<%--  
    Document   : updateTaiKhoan  
    Created on : Feb 25, 2025, 8:40:23 PM  
    Author     : Admin  
--%>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<jsp:useBean id="taiKhoan" class="model.TaiKhoan" scope="request" />  
<jsp:setProperty name="taiKhoan" property="*" />  

<!DOCTYPE html>  
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <link rel="stylesheet" href="jsp/css/a_style_update.css"/>  
        <title>Cập Nhật Tài Khoản</title>  
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                padding: 20px;
                background-color: #f4f4f4;
            }

            h1, h2 {
                color: #333;
            }

            a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            a:hover {
                text-decoration: underline;
            }

            form {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 400px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-top: 10px;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                background: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                margin-top: 15px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background: #218838;
            }
        </style>
    </head>  
    <body>  
        <h2>  
            <a href="taikhoans?action=list">Danh Sách Tài Khoản</a>  
        </h2>  

        <h1>Cập Nhật Tài Khoản</h1>  
        <p>NOTE: Vui lòng chỉnh sửa thông tin tài khoản.</p>  

        <form action="taikhoans?action=update" method="post">   
            <label class="pad_top">Tên Tài Khoản:</label>  
            <input type="text" name="tenTaiKhoan_display" value="${taiKhoan.tenTaiKhoan}" disabled><br>
            <input type="hidden" name="tenTaiKhoan" value="${taiKhoan.tenTaiKhoan}">

            <label class="pad_top">Mật Khẩu:</label>  
            <input type="password" id="matKhau" name="matKhau" value="${taiKhoan.matKhau}" required>  
            <br>
            <input type="checkbox" id="showPassword" onclick="togglePassword()"> Hiển thị mật khẩu  
            <br>

            <script>
                function togglePassword() {
                    var passwordInput = document.getElementById("matKhau");
                    var showPasswordCheckbox = document.getElementById("showPassword");
                    passwordInput.type = showPasswordCheckbox.checked ? "text" : "password";
                }
            </script>



            <label class="pad_top">Họ Tên:</label>  
            <input type="text" name="hoTen" value="${taiKhoan.hoTen}" required><br>  

            <label class="pad_top">Giới Tính:</label>  
            <select name="gioiTinh">
                <option value="true" ${taiKhoan.gioiTinh ? 'selected' : ''}>Nam</option>
                <option value="false" ${!taiKhoan.gioiTinh ? 'selected' : ''}>Nữ</option>
            </select><br>  

            <label class="pad_top">Số Điện Thoại:</label>  
            <input type="text" name="soDienThoai" value="${taiKhoan.soDienThoai}" required><br>  

            <label class="pad_top">Email:</label>  
            <input type="email" name="email" value="${taiKhoan.email}" required><br>  

            <label class="pad_top">Vai Trò:</label>  
            <select name="idRole">
                <option value="1" ${taiKhoan.idRole eq '1' ? 'selected' : ''}>Admin</option>
                <option value="2" ${taiKhoan.idRole eq '2' ? 'selected' : ''}>User</option>
            </select><br>  

            <label>&nbsp;</label>  
            <input type="submit" value="Cập Nhật" class="margin_left">  
        </form>  
    </body>  
</html>  
