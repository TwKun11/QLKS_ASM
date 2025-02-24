package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SQLConnection {

    private static final String DRIVER_NAME = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyKhachSan;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa"; // Thay bằng username của bạn
    private static final String PASSWORD = "123456"; // Thay bằng password của bạn

    public static Connection getConnection() throws SQLException {
        Connection con = null;
        try {
            // Tải driver SQL Server
            Class.forName(DRIVER_NAME);
            
            // Kết nối đến SQL Server
            con = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            
        } catch (ClassNotFoundException | SQLException e) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, e);
        }
        return con;
    }
    public static void main(String[] args) {
        try (Connection connection = getConnection()) {
            if (connection != null) {
                System.out.println("Database connection is active.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);

        }
    }
}