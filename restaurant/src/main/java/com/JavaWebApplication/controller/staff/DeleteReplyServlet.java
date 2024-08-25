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


public class DeleteReplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int replyId = Integer.parseInt(request.getParameter("reply_id"));
        int messageId = Integer.parseInt(request.getParameter("message_id"));

        // SQL query to delete the reply
        String deleteReplySql = "DELETE FROM replies WHERE id = ?";

        try (Connection conn = new mydb().getCon();
             PreparedStatement pstmt = conn.prepareStatement(deleteReplySql)) {

            if (conn == null) {
                throw new SQLException("Database connection is not available.");
            }

            // Set the reply ID parameter
            pstmt.setInt(1, replyId);
            
            // Execute the deletion
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Reply successfully deleted
                response.sendRedirect("/restaurant/staff/jsp/ViewMessages.jsp");
            } else {
                // Reply not found or not deleted
                response.getWriter().println("Error: Reply with ID " + replyId + " could not be deleted. It might not exist.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
