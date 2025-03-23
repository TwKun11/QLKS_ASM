<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.TaiKhoan, dao.DAOTaiKhoan" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

<%
    String currentPage = request.getRequestURI();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");

    if (user == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    String usernameFromCookie = cookie.getValue();
                    try {
                        DAOTaiKhoan daoTaiKhoan = new DAOTaiKhoan();
                        user = daoTaiKhoan.getByTenTaiKhoan(usernameFromCookie);
                        if (user != null) {
                            session.setAttribute("user", user);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nice Dream Hotel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
        }
        .header {
            background-color: #36383b;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 50px;
            height: 70px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .nav {
            display: flex;
            align-items: center;
            gap: 30px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .nav a:hover, .nav a.active {
            color: #F5A623;
        }
        .user {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .user a {
            background-color: #F5A623;
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .user a:hover {
            background-color: #e59400;
        }
        .username {
            font-weight: 600;
            font-size: 16px;
            color: white;
        }
        .dashboard-btn {
            background-color: #F5A623;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            position: relative;
        }
        .dashboard-btn:hover {
            background-color: #e59400;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }
        #chat-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            font-family: 'Poppins', sans-serif;
        }
        #chat-toggle {
            background-color: #F5A623;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(245, 166, 35, 0.4);
            transition: transform 0.2s ease, background-color 0.3s ease;
        }
        #chat-toggle:hover {
            background-color: #e59400;
            transform: translateY(-2px);
        }
        #chat-box {
            display: none;
            width: 320px;
            height: 450px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.15);
            position: absolute;
            bottom: 60px;
            right: 0;
            overflow: hidden;
        }
        #chat-header {
            background: #F5A623;
            color: white;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            border-radius: 15px 15px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        #chat-header i {
            cursor: pointer;
        }
        #chat-messages {
            height: 350px;
            overflow-y: auto;
            padding: 15px;
            background: #f9f9f9;
            font-size: 14px;
            line-height: 1.5;
        }
        #chat-messages p {
            background: #fff;
            padding: 8px 12px;
            margin: 5px 0;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            word-wrap: break-word;
        }
        #chat-input-area {
            display: flex;
            padding: 10px;
            background: #fff;
            border-top: 1px solid #eee;
        }
        #chat-input {
            width: 75%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        #chat-input:focus {
            border-color: #F5A623;
        }
        #chat-box button {
            width: 20%;
            margin-left: 5px;
            padding: 8px;
            background: #F5A623;
            color: white;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        #chat-box button:hover {
            background: #e59400;
        }
        /* Badge cho tin nhắn chưa đọc */
        #message-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff0000;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: none;
            text-align: center;
            font-size: 12px;
            line-height: 20px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="nav">
                <a href="${pageContext.request.contextPath}/home" class="<%= currentPage.contains("/home") ? "active" : "" %>">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/khachsan" class="<%= currentPage.contains("/khachsan") ? "active" : "" %>">Khách sạn</a>
                <a href="${pageContext.request.contextPath}/pages/profile.jsp" class="<%= currentPage.contains("/pages/profile.jsp") ? "active" : "" %>">Cá nhân</a>
                <a href="${pageContext.request.contextPath}/huydatphong" class="<%= currentPage.contains("huydatphong") ? "active" : "" %>">Lịch sử đặt phòng</a>
                
                <% if (user != null && user.getIdRole() == 1) { %>
                    <a href="${pageContext.request.contextPath}/datphongs" class="dashboard-btn">🛠 Dashboard</a>
                <% } %>
                <% if (user != null && user.getIdRole() == 1) { %>
                    <a href="${pageContext.request.contextPath}/pages/admin_chat.jsp" class="dashboard-btn">Tin Nhắn <span id="message-badge">0</span></a>
                <% } %>
            </div>

            <div class="user">
                <% if (user != null) { %>
                <span class="username">Xin chào, <%= user.getTenTaiKhoan() %>!</span>
                <a href="<%= request.getContextPath() %>/logout">Đăng Xuất</a>
                <% } else { %>
                <a href="<%= request.getContextPath() %>/pages/login.jsp">Đăng Nhập</a>
                <% } %>
            </div>
        </div>
    </div>

    <%-- Chat Widget cho User --%>
    <% if (user == null || user.getIdRole() != 1) { %>
    <div id="chat-widget">
        <button id="chat-toggle"><i class="fas fa-comments"></i> Chat với Admin</button>
        <div id="chat-box">
            <div id="chat-header">
                <span>Chat với Admin</span>
                <i class="fas fa-times" onclick="document.getElementById('chat-box').style.display='none'"></i>
            </div>
            <div id="chat-messages"></div>
            <div id="chat-input-area">
                <input type="text" id="chat-input" placeholder="Nhập tin nhắn..." />
                <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
    </div>

    <script>
        document.getElementById("chat-toggle").onclick = function() {
            var chatBox = document.getElementById("chat-box");
            chatBox.style.display = chatBox.style.display === "none" ? "block" : "none";
        };

        var ws = new WebSocket("ws://localhost:8080<%= request.getContextPath() %>/chat");
        
        ws.onmessage = function(event) {
            var messages = document.getElementById("chat-messages");
            messages.innerHTML += "<p>" + event.data + "</p>";
            messages.scrollTop = messages.scrollHeight;
        };
        
        function sendMessage() {
            var input = document.getElementById("chat-input");
            var msg = input.value;
            if (msg) {
                ws.send(msg);
                input.value = "";
            }
        }

        document.getElementById("chat-input").addEventListener("keypress", function(event) {
            if (event.key === "Enter") {
                sendMessage();
            }
        });

        // Hàm cập nhật badge cho admin (dùng trong iframe)
        function updateBadge(count) {
            var badge = document.getElementById("message-badge");
            if (badge) {
                badge.textContent = count;
                badge.style.display = count > 0 ? "inline-block" : "none";
            }
        }

        // WebSocket cho admin (chạy trong header)
        <% if (user != null && user.getIdRole() == 1) { %>
        var adminWs = new WebSocket("ws://localhost:8080<%= request.getContextPath() %>/chat");
        let unreadCount = 0;

        adminWs.onopen = function() {
            adminWs.send("role:admin");
        };

        adminWs.onmessage = function(event) {
            var data = event.data;
            if (data === "new_message") {
                unreadCount++;
                updateBadge(unreadCount);
            }
        };
        <% } %>
    </script>
    <% } %>
</body>
</html>