package com.JavaWebApplication.Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class mydb {

    private Connection con = null;

    public Connection getCon() {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver Registered!");

            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            if (con != null) {
                System.out.println("Database connected successfully!");
            } else {
                System.out.println("Failed to make connection!");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("MySQL JDBC Driver not found!");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Database connection failed! Error: " + e.getMessage());
        }

        return con;
    }
}
