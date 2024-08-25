package com.JavaWebApplication.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class AddStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        String password = request.getParameter("password");
        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        
        String relativePath = "uploads/";
        String filePath = getServletContext().getRealPath(relativePath) + File.separator + fileName;

        File uploadDir = new File(getServletContext().getRealPath(relativePath));
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        filePart.write(filePath);

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO staff (name, email, position, image, password) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, position);
                pstmt.setString(4, fileName); // Store just the file name
                pstmt.setString(5, password);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/jsp/staff.jsp");
    }
}
