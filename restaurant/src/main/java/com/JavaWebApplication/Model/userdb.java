package com.JavaWebApplication.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.WebApplication.Beans.RegisterBean;

public class userdb {

    // Method to insert a new user into the database
    public String insertUser(RegisterBean rb) {
        mydb db = new mydb();
        Connection con = null;
        PreparedStatement pstmt = null;
        String resultMessage = null;

        try {
            con = db.getCon();
            if (con != null) {
                String sql = "INSERT INTO register (name, email, password, confirmPassword) VALUES (?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, rb.getName());
                pstmt.setString(2, rb.getEmail());
                pstmt.setString(3, rb.getPassword());
                pstmt.setString(4, rb.getConfirmPassword());

                // Execute the statement
                int rowsAffected = pstmt.executeUpdate();
                resultMessage = (rowsAffected > 0) ? "SUCCESS" : "Insert Failed";
            } else {
                resultMessage = "Database connection failed!";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resultMessage = "Error occurred: " + e.getMessage();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return resultMessage;
    }

    // Method to validate a user's login credentials
    public boolean validateUser(String email, String password) {
        mydb db = new mydb();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isValidUser = false;

        try {
            con = db.getCon();
            if (con != null) {
                String sql = "SELECT * FROM register WHERE email = ? AND password = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                // Check if user exists in the result set
                if (rs.next()) {
                    isValidUser = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isValidUser;
    }
}
