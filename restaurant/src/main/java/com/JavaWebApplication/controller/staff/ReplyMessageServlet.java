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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("message_id"));
        String reply = request.getParameter("reply");

        mydb db = new mydb();
        Connection conn = db.getCon();
        String sql = "INSERT INTO replies (message_id, reply_content) VALUES (?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, messageId);
            pstmt.setString(2, reply);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect to a success page or the View Messages page
        response.sendRedirect("http://localhost:8090/restaurant/staff/jsp/ViewMessages.jsp?success=true");
    }
}
