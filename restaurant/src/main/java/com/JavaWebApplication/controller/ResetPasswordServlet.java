package com.JavaWebApplication.controller;

import com.JavaWebApplication.Model.mydb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;


public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");
        Connection con = new mydb().getCon();
        
        try {
            // Validate the token
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM users WHERE reset_token = ?");
            stmt.setString(1, token);
            var rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Update the user's password
                PreparedStatement updateStmt = con.prepareStatement("UPDATE users SET password = ?, reset_token = NULL WHERE reset_token = ?");
                updateStmt.setString(1, newPassword); // Hash the password in real applications!
                updateStmt.setString(2, token);
                updateStmt.executeUpdate();
                
                // Redirect to login with success message
                response.sendRedirect("login.jsp?success=Password reset successfully.");
            } else {
                request.setAttribute("errorMessage", "Invalid or expired reset token.");
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("resetpassword.jsp?error=Something went wrong.");
        }
    }
}
