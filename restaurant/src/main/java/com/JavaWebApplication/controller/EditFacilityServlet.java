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
public class EditFacilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

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

        // Update the facility in the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE facilities SET name = ?, description = ?, status = ?, image = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, description);
                pstmt.setString(3, status);
                pstmt.setString(4, imageFileName != null ? imageFileName : ""); // Handle case where no image is uploaded
                pstmt.setInt(5, id);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logger here
        }

        // Redirect to the facilities management page
        response.sendRedirect(request.getContextPath() + "/admin/jsp/ManageFacilities.jsp");
    }
}
