package com.JavaWebApplication.controller.staff;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("message_id"));
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Delete replies associated with the message first
            String deleteRepliesSql = "DELETE FROM replies WHERE message_id = ?";
            try (PreparedStatement deleteRepliesPstmt = conn.prepareStatement(deleteRepliesSql)) {
                deleteRepliesPstmt.setInt(1, messageId);
                deleteRepliesPstmt.executeUpdate();
            }
            
            // Now delete the message
            String deleteMessageSql = "DELETE FROM contact_messages WHERE id = ?";
            try (PreparedStatement deleteMessagePstmt = conn.prepareStatement(deleteMessageSql)) {
                deleteMessagePstmt.setInt(1, messageId);
                deleteMessagePstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/staff/jsp/ViewMessages.jsp");
    }
}
