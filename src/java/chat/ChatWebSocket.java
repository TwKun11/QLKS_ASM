package chat;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

@ServerEndpoint("/chat")
public class ChatWebSocket {
    private static Map<String, Session> userSessions = new HashMap<>();
    private static Session adminSession = null;
    private static Queue<String> messageQueue = new LinkedList<>();

    @OnOpen
    public void onOpen(Session session) throws IOException {
        System.out.println("Kết nối mới: " + session.getId());
        userSessions.put(session.getId(), session);
        session.getBasicRemote().sendText("ID của bạn: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("Tin nhắn từ " + session.getId() + ": " + message);
        if (message.equals("role:admin")) {
            System.out.println("Đặt admin session: " + session.getId());
            adminSession = session;
            userSessions.remove(session.getId());
            session.getBasicRemote().sendText("Bạn là Admin!");
            while (!messageQueue.isEmpty()) {
                String queuedMessage = messageQueue.poll();
                adminSession.getBasicRemote().sendText(queuedMessage);
            }
        } else if (message.startsWith("to:")) {
            if (session.equals(adminSession)) {
                String[] parts = message.split(":", 3);
                String userId = parts[1];
                String reply = parts[2];
                Session userSession = userSessions.get(userId);
                if (userSession != null && userSession.isOpen()) {
                    System.out.println("Admin gửi tới user " + userId + ": " + reply);
                    userSession.getBasicRemote().sendText("Admin: " + reply);
                } else {
                    System.out.println("Không tìm thấy user session " + userId + " hoặc đã đóng");
                }
            } else {
                System.out.println("Không phải admin cố gửi tin nhắn 'to:'");
            }
        } else {
            if (userSessions.containsValue(session)) {
                String userMessage = "User " + session.getId() + ": " + message;
                session.getBasicRemote().sendText("Bạn: " + message);
                if (adminSession != null && adminSession.isOpen()) {
                    System.out.println("Gửi tới admin: " + userMessage);
                    adminSession.getBasicRemote().sendText(userMessage);
                    adminSession.getBasicRemote().sendText("new_message");
                } else {
                    System.out.println("Admin chưa kết nối, thêm vào hàng đợi: " + userMessage);
                    messageQueue.add(userMessage);
                }
            } else {
                System.out.println("Người gửi không phải user: " + session.getId());
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("Kết nối đóng: " + session.getId());
        if (session.equals(adminSession)) {
            adminSession = null;
        } else {
            userSessions.remove(session.getId());
        }
    }
}