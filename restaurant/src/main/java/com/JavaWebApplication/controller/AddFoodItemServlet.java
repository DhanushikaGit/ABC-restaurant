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
public class AddFoodItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        Part filePart = request.getPart("image");
        String fileName = filePart != null ? filePart.getSubmittedFileName() : null;

        String relativePath = "uploads/";
        String filePath = getServletContext().getRealPath(relativePath) + File.separator + fileName;

        if (filePart != null) {
            File uploadDir = new File(getServletContext().getRealPath(relativePath));
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(filePath);
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO food_items (name, description, price, category, image) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, description);
                pstmt.setString(3, price);
                pstmt.setString(4, category);
                pstmt.setString(5, fileName);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/jsp/AddFoodItem.jsp");
    }

}
