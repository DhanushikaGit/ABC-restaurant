<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style>
        /* Reuse your login page styles or create new ones */
    </style>
</head>
<body>
    <div class="container">
        <h2>Forgot Your Password?</h2>
        <p>Enter your email address to receive a password reset link.</p>
        <form method="post" action="<%= request.getContextPath() %>/customer/jsp/forgotpassword.jsp">
            <div class="form-group">
                <label for="email">Email<font color="red">*</font></label>
                <input type="email" id="email" class="form-control" placeholder="Enter your email" name="email" required>
            </div>
            <input type="submit" value="Send Reset Link" class="btn btn-primary">
        </form>
    </div>
</body>
</html>
