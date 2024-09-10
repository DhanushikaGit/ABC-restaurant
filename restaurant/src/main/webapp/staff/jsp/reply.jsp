<%@ page import="java.sql.*, java.net.URLEncoder,com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: var(--light);
        color: var(--dark);
        margin: 0;
        padding: 0;
    }

    h2 {
        color: var(--primary);
        text-align: center;
        margin-top: 20px;
    }

    form {
        width: 80%;
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ddd;
        background-color: #fff;
        border-radius: 8px;
    }

    p {
        margin: 0;
        padding: 10px 0;
    }

    label {
        display: block;
        font-weight: bold;
        margin: 10px 0 5px;
    }

    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        resize: vertical;
    }

    input[type="submit"] {
        background-color: var(--primary);
        color: #fff;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
    }

    input[type="submit"]:hover {
        background-color: #e59100;
    }

    a {
        display: block;
        margin: 20px auto;
        text-align: center;
        color: var(--primary);
        text-decoration: none;
        font-size: 16px;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
    
</head>
<body>
<%@ include file="staffheader.jsp" %>

<h2>Reply to Message</h2>

<%
    int messageId = Integer.parseInt(request.getParameter("message_id"));
    mydb db = new mydb();
    Connection conn = db.getCon();
    String sql = "SELECT * FROM contact_messages WHERE id = ?";
    String name = "";
    String email = "";
    String subject = "";
    String message = "";
    
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, messageId);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
                subject = rs.getString("subject");
                message = rs.getString("message");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<form action="http://localhost:8090/restaurant/ReplyMessageServlet" method="post">
    <input type="hidden" name="message_id" value="<%= messageId %>">
    <p><strong>Name:</strong> <%= name %></p>
    <p><strong>Email:</strong> <%= email %></p>
    <p><strong>Subject:</strong> <%= subject %></p>
    <p><strong>Message:</strong></p>
    <p><%= message %></p>
    <label for="reply">Reply:</label>
    <textarea id="reply" name="reply" rows="6" required></textarea>
    <input type="submit" value="Send Reply" >
</form>

<%
    // Generate the mailto link
    String mailtoLink = "mailto:" + email + "?subject=" + URLEncoder.encode("Re: " + subject, "UTF-8") + "&body=" + URLEncoder.encode("Dear " + name + ",%0D%0A%0D%0A" + request.getParameter("reply") + "%0D%0A%0D%0ABest regards,%0D%0AYour Company", "UTF-8");
%>

<a href="<%= mailtoLink %>">Open Email Client</a>


</body>
  <%@ include file="staffooter.jsp" %>
</html>
