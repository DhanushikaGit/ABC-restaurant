package com.JavaWebApplication.controller.staff;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String reservationDate = request.getParameter("reservation_date");
        String reservationTime = request.getParameter("reservation_time");
        String people = request.getParameter("people");
        String session = request.getParameter("session");
        String location = request.getParameter("location");
        String message = request.getParameter("message");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE reservations SET name = ?, email = ?, contact = ?, reservation_date = ?, reservation_time = ?, people = ?, session = ?, location = ?, message = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, contact);
                pstmt.setString(4, reservationDate);
                pstmt.setString(5, reservationTime);
                pstmt.setString(6, people);
                pstmt.setString(7, session);
                pstmt.setString(8, location);
                pstmt.setString(9, message);
                pstmt.setInt(10, reservationId);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("/restaurant/staff/jsp/viewreservation.jsp");
    }
}
