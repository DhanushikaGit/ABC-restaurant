<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Submission Error</title>
    <link href="<c:url value='/customer/css/bootstrap.min.css'/>" rel="stylesheet">
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">

  <link href="/restaurant/customer/css/index.css" rel="stylesheet">
    
     <!-- Customized Bootstrap Stylesheet -->
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">
    <style>
       
    </style>
</head>
<body>
   <%@ include file="header.jsp" %>
    <div class="container text-center">
        <h1 class="mt-5">Oops!</h1>
        <p>There was an error submitting your feedback. Please try again later.</p>
        <a href="feedback.jsp" class="btn btn-primary">Back to Feedback</a>
    </div>
    
     <%@ include file="footer.jsp" %>
</body>
</html>
