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
public class EditStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        String password = request.getParameter("password");

        String imageFileName = null;
        Part filePart = request.getPart("image");

        if (filePart != null && filePart.getSize() > 0) {
            // Get the upload directory path
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);

            // Create directory if it does not exist
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Get the file name and write it to the server
            imageFileName = filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + imageFileName);
        }

        // Update the staff member in the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE staff SET name = ?, email = ?, position = ?, image = ?, password = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, position);
                pstmt.setString(4, imageFileName != null ? imageFileName : "");
                pstmt.setString(5, password);
                pstmt.setInt(6, id);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect to the Manage Staff page
        response.sendRedirect(request.getContextPath() + "/admin/jsp/staff.jsp");
    }
}
