<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>
        /* Similar styles as forgotpassword.jsp */
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Your Password</h2>
        <form method="post" action="<%= request.getContextPath() %>/ResetPasswordServlet">
            <input type="hidden" name="token" value="<%= request.getParameter("token") %>">
            <div class="form-group">
                <label for="password">New Password<font color="red">*</font></label>
                <input type="password" id="password" class="form-control" name="password" required>
            </div>
            <input type="submit" value="Reset Password" class="btn btn-primary">
        </form>
    </div>
</body>
</html>
