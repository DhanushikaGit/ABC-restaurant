package com.JavaWebApplication.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    public DeleteCustomerServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int uid = Integer.parseInt(request.getParameter("uid"));
        HttpSession session = request.getSession();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM register WHERE uid = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, uid);
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        session.setAttribute("message", "Record deleted successfully.");
                    } else {
                        session.setAttribute("message", "No record found with the given UID.");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error occurred while deleting record: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/jsp/manage-customers.jsp");
    }
}
