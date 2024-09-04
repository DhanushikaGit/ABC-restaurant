<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Email Sent</title>
</head>
<body>
    <h1>Email Sent Successfully!</h1>
    <p>Your reply has been sent to: <strong><%= request.getAttribute("recipientEmail") != null ? request.getAttribute("recipientEmail") : "N/A" %></strong></p>
    <p>Subject: <strong><%= request.getAttribute("subject") != null ? request.getAttribute("subject") : "N/A" %></strong></p>
    <p>Message Body:</p>
    <pre><%= request.getAttribute("body") != null ? request.getAttribute("body") : "N/A" %></pre>

    <p>
        <%
            String recipientEmail = (String) request.getAttribute("recipientEmail");
            String subject = (String) request.getAttribute("subject");
            String body = (String) request.getAttribute("body");
            
            if (recipientEmail != null && subject != null && body != null) {
                try {
                    String encodedSubject = URLEncoder.encode(subject, "UTF-8");
                    String encodedBody = URLEncoder.encode(body, "UTF-8");
        %>
        <a href="mailto:<%= recipientEmail %>?subject=<%= encodedSubject %>&body=<%= encodedBody %>">
            Click here to open your email client
        </a>
        <%
                } catch (Exception e) {
                    out.println("Error encoding the URL: " + e.getMessage());
                }
            } else {
                out.println("Required information is missing. Unable to create the email link.");
            }
        %>
    </p>
</body>
</html>
