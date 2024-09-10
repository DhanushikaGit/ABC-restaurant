package com.JavaWebApplication.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.JavaWebApplication.Model.userdb;
import com.WebApplication.Beans.RegisterBean;

public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Register() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if password and confirm password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // Creating the RegisterBean object
        RegisterBean rb = new RegisterBean(username, email, password, confirmPassword);

        // Insert user into the database
        userdb ud = new userdb();
        String result = ud.insertUser(rb);

        if (result.equals("SUCCESS")) {
            // Redirect with a success message as a query parameter
            response.sendRedirect(request.getContextPath() + "/customer/jsp/login.jsp?success=Registration successful!");
        } else {
            // Set an error message and forward to the registration page
            request.setAttribute("errorMessage", "Registration failed: " + result);
            request.getRequestDispatcher("/customer/jsp/register.jsp").forward(request, response);
        }
    }

}
