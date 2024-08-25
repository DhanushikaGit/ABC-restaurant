package com.JavaWebApplication.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.JavaWebApplication.Model.mydb;

@MultipartConfig
public class ReserveTableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        mydb db = new mydb();
        Connection conn = db.getCon();

        if (conn != null) {
            String sql = "INSERT INTO reservations (name, email, contact, reservation_date, reservation_time, people, session, location, message) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, request.getParameter("name"));
                pstmt.setString(2, request.getParameter("email"));
                pstmt.setString(3, request.getParameter("contact"));
                pstmt.setString(4, request.getParameter("reservation_date"));
                pstmt.setString(5, request.getParameter("reservation_time"));
                pstmt.setString(6, request.getParameter("people"));
                pstmt.setString(7, request.getParameter("session"));
                pstmt.setString(8, request.getParameter("location"));
                pstmt.setString(9, request.getParameter("message"));

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            System.out.println("Connection not established.");
        }
        response.sendRedirect(request.getContextPath() + "/customer/jsp/Thankyou.jsp");
    }


}
