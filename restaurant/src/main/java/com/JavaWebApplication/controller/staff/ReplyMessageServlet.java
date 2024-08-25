package com.JavaWebApplication.controller.staff;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.JavaWebApplication.Model.mydb;


public class ReplyMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("message_id"));
        
        // Get the reply content from the form (not implemented here)
        String replyContent = request.getParameter("reply");

        // Implement your logic to reply to the message
        try (Connection conn = new mydb().getCon()) {
            if (conn != null) {
                String sql = "INSERT INTO replies (message_id, reply_content, replied_at) VALUES (?, ?, NOW())";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, messageId);
                    pstmt.setString(2, replyContent);
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing reply");
            return;
        }
        
        // Redirect or forward to a page to show the success or back to the message list
        response.sendRedirect("http://localhost:8090/restaurant/staff/jsp/ViewMessages.jsp");
    }
}
