<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Chat</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            color: #333;
        }
        .chat-container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        h2 {
            background: #F5A623;
            color: white;
            padding: 15px;
            margin: 0;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        h2 i {
            margin-right: 10px;
        }
        #chat-messages {
            height: 400px;
            overflow-y: auto;
            padding: 20px;
            background: #fafafa;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        #chat-messages p {
            margin: 0;
            padding: 10px 15px;
            background: #e9ecef;
            border-radius: 15px;
            max-width: 70%;
            word-wrap: break-word;
            align-self: flex-start;
        }
        #chat-messages p.admin-message {
            background: #F5A623;
            color: white;
            align-self: flex-end;
        }
        .input-area {
            display: flex;
            align-items: center;
            padding: 15px;
            background: #fff;
            border-top: 1px solid #e0e0e0;
        }
        input[type="text"] {
            flex: 1;
            padding: 10px 15px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 25px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus {
            border-color: #F5A623;
        }
        #userId {
            width: 120px;
            margin-right: 15px;
        }
        #message {
            flex-grow: 2;
        }
        button {
            padding: 10px 20px;
            background: #F5A623;
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        button:hover {
            background: #e59400;
        }
        button i {
            margin-left: 5px;
        }
        #chat-messages::-webkit-scrollbar {
            width: 8px;
        }
        #chat-messages::-webkit-scrollbar-thumb {
            background: #F5A623;
            border-radius: 4px;
        }
        #chat-messages::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/header.jsp" %>
    <%
        if (user == null || user.getIdRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
    %>
    <div class="chat-container">
        <h2><i class="fas fa-comment-dots"></i> Admin Chat</h2>
        <div id="chat-messages"></div>
        <div class="input-area">
            <input type="text" id="userId" placeholder="User ID"/>
            <input type="text" id="message" placeholder="Nhập tin nhắn..."/>
            <button onclick="sendMessage()">Gửi <i class="fas fa-paper-plane"></i></button>
        </div>
    </div>

    <script>
        var ws = new WebSocket("ws://localhost:8080<%= request.getContextPath() %>/chat");
        
        ws.onopen = function() {
            ws.send("role:admin");
        };
        
        ws.onmessage = function(event) {
            var messageDiv = document.getElementById("chat-messages");
            var data = event.data;

            if (data === "new_message") {
                // Không làm gì ở đây, badge sẽ được cập nhật ở header.jsp
            } else {
                var newMessage = document.createElement("p");
                newMessage.textContent = data;
                messageDiv.appendChild(newMessage);
                messageDiv.scrollTop = messageDiv.scrollHeight;
                // Reset badge khi admin xem tin nhắn
                updateBadge(0);
            }
        };
        
        function sendMessage() {
            var userId = document.getElementById("userId").value;
            var msg = document.getElementById("message").value;
            if (userId && msg) {
                ws.send("to:" + userId + ":" + msg);
                var messageDiv = document.getElementById("chat-messages");
                var newMessage = document.createElement("p");
                newMessage.textContent = "Admin gửi tới " + userId + ": " + msg;
                newMessage.classList.add("admin-message");
                messageDiv.appendChild(newMessage);
                messageDiv.scrollTop = messageDiv.scrollHeight;
                document.getElementById("message").value = "";
            }
        }

        function updateBadge(count) {
            var badge = parent.document.getElementById("message-badge");
            if (badge) {
                badge.textContent = count;
                badge.style.display = count > 0 ? "inline-block" : "none";
            }
        }
    </script>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>