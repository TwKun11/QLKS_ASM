<%-- 
    Document   : createThanhPho
    Created on : Feb 25, 2025, 8:40:08 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="thanhPho" class="model.ThanhPho" scope="request" />
<jsp:setProperty name="thanhPho" property="*" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="jsp/css/a_style_create.css"/>
        <title>Create ThanhPho</title>
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
            <a href="thanhphos?action=list">List All ThanhPho</a>
        </h2>

        <h1>Create ThanhPho</h1>
        <p>NOTE: Enter all city information.</p>
        <form action="thanhphos?action=create" method="post">      
            <label class="pad_top">Tên:</label>
            <input type="text" name="ten" required><br>
            <label class="pad_top">Mô tả:</label>
            <input type="text" name="moTa" required><br>
            <label class="pad_top">URL Hình Ảnh:</label>
            <input type="text" name="urlHinhAnh" required><br>
            <label>&nbsp;</label>
            <input type="submit" value="Submit" class="margin_left">
        </form>
    </body>
</html>
