/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ASUS
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.User;

public class UserDAO {
    private String url = "jdbc:sqlserver://localhost:1433;databaseName=leave_management;encrypt=true;trustServerCertificate=true;";
    private String dbUser = "quyennb"; // Thay bằng tên người dùng SQL Server
    private String dbPassword = "12345"; // Thay bằng mật khẩu SQL Server

    public User getUserByCredentials(String username, String password) throws ClassNotFoundException {
        User user = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            String query = "SELECT user_id, username, role FROM users WHERE username = ? AND password_hash = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password); // TODO: Implement password hashing
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String role = rs.getString("role");
                user = new User(userId, username, role);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}