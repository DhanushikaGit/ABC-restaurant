package com.JavaWebApplication.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.JavaWebApplication.Model.userdb;

public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public login() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the email and password parameters from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Email and password must not be empty");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            return;
        }

        // Create a new userdb object to validate the user credentials
        userdb db = new userdb();
        boolean isValidUser = db.validateUser(email, password);

        if (isValidUser) {
            // Create a session and set the email attribute
            HttpSession session = request.getSession();
            session.setAttribute("email", email);

            // Redirect to the welcome page
            response.sendRedirect(request.getContextPath() + "/customer/jsp/index.jsp");
        } else {
            // Set an error message and forward to the login page
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("/customer/jsp/login.jsp").forward(request, response);
        }
    }
}
