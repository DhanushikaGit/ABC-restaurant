package com.JavaWebApplication.controller;

import com.JavaWebApplication.Model.mydb;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.UUID;


public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        Connection con = new mydb().getCon();
        
        try {
            // Check if the email exists in the database
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM users WHERE email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Generate reset token
                String token = UUID.randomUUID().toString();
                
                // Store the token in the database
                PreparedStatement updateStmt = con.prepareStatement("UPDATE users SET reset_token = ? WHERE email = ?");
                updateStmt.setString(1, token);
                updateStmt.setString(2, email);
                updateStmt.executeUpdate();

                // Send the reset email
                sendEmail(email, token);

                // Redirect to the login page with a success message
                response.sendRedirect("login.jsp?success=Reset link sent to your email.");
            } else {
                // If the email is not found
                request.setAttribute("errorMessage", "Email not found.");
                request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Forward back to forgotpassword.jsp with an error message
            request.setAttribute("errorMessage", "Something went wrong. Please try again.");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Method to send the password reset email
    private void sendEmail(String recipientEmail, String token) throws MessagingException {
        // SMTP server information
        String host = "smtp.gmail.com";  // Using Gmail SMTP
        String port = "587";
        String user = "your-email@gmail.com";  // Your Gmail address
        String pass = "your-app-specific-password";  // Gmail App password (not your actual Gmail password)

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Authentication and session
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(user, pass);
            }
        });

        // Composing the email message
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
        message.setSubject("Password Reset Request");
        String resetLink = "http://localhost:8080/restaurant/customer/jsp/resetpassword.jsp?token=" + token;
        message.setText("Click the link below to reset your password:\n" + resetLink);

        // Sending the email
        Transport.send(message);
    }
}
