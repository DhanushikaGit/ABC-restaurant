<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ABC Restaurant Customer Login Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%= request.getContextPath() %>/customer/images/A B C (1).png" rel="icon">
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #0F172B;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            width: 100%;
            max-width: 600px;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .card {
            border: none;
        }

        .card-header {
            color: black;
            text-align: center;
            font-size: 44px;
            font-weight: bold;
        }

        .card-body {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
            text-align: center;
            display: inline-block;
            margin-right: 10px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: white;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn-link {
            color: var(--dark);
            text-decoration: none;
            font-size: 14px;
        }

        .btn-link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }

        .register-link {
            margin-top: 20px;
            text-align: center;
            font-size: 16px;
        }

        .register-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .success-message {
            color: #28a745;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .footer {
            background-color: var(--dark);
            color: #fff;
            text-align: center;
            padding: 15px;
            position: fixed;
            width: 100%;
            bottom: 0;
            left: 0;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }

        .footer p {
            margin: 0;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('form').on('submit', function(event) {
                var email = $('#email').val();
                var password = $('#password').val();
                var errorMessage = "";

                if (email === "") {
                    errorMessage += "Email is required.\n";
                }
                if (password === "") {
                    errorMessage += "Password is required.\n";
                }

                if (errorMessage !== "") {
                    alert(errorMessage);
                    event.preventDefault(); // Prevent form submission
                }
            });
        });
    </script>
</head>
<body>

<main class="login-form">
    <div class="container">
        <div class="card">
            <div class="card-header">
                Login
            </div>

            <div class="card-body">
                <!-- Display success message inside the login container -->
                <% 
                    String successMessage = request.getParameter("success");
                    if (successMessage != null && !successMessage.isEmpty()) {
                %>
                <div class="success-message">
                    <%= successMessage %>
                </div>
                <% } %>

                <h6 class="error-message">
                    <% 
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {
                            out.print(errorMessage); // Display the error message
                        }
                    %>
                </h6>

                <form method="post" action="<%= request.getContextPath() %>/login"> <!-- Ensure action matches the servlet mapping -->
                    <div class="form-group row">
                        <label for="email" class="col-md-4 col-form-label text-md-right">Email<font color="red">*</font></label>
                        <div class="col-md-6">
                            <input type="email" id="email" class="form-control" placeholder="Enter Email" name="email" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="password" class="col-md-4 col-form-label text-md-right">Password<font color="red">*</font></label>
                        <div class="col-md-6">
                            <input type="password" id="password" class="form-control" placeholder="Enter Password" name="password" required>
                        </div>
                    </div>

                    <div class="col-md-6 offset-md-4">
                        <input type="submit" class="btn btn-primary" value="Login">
                       <a href="<%= request.getContextPath() %>/customer/jsp/forgotpassword.jsp" class="btn btn-link">Forgot Your Password?</a>
                       
                    </div>
                </form>

                <div class="register-link">
                    Don't have an account? <a href="/restaurant/customer/jsp/register.jsp">Register</a>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
<footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>
</html>
