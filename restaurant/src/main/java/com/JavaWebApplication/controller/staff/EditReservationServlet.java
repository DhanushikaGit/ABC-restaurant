package com.JavaWebApplication.controller.staff;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM reservations WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, reservationId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    request.setAttribute("reservation_id", rs.getInt("id"));
                    request.setAttribute("name", rs.getString("name"));
                    request.setAttribute("email", rs.getString("email"));
                    request.setAttribute("contact", rs.getString("contact"));
                    request.setAttribute("reservation_date", rs.getString("reservation_date"));
                    request.setAttribute("reservation_time", rs.getString("reservation_time"));
                    request.setAttribute("people", rs.getString("people"));
                    request.setAttribute("session", rs.getString("session"));
                    request.setAttribute("location", rs.getString("location"));
                    request.setAttribute("message", rs.getString("message"));
                }

                request.getRequestDispatcher("/staff/jsp/edit-reservation.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
