<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Submit Feedback - ABC Restaurant</title>
    <link href="<c:url value='/customer/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/customer/css/style.css'/>" rel="stylesheet">
</head>

<body>
    <%@ include file="header.jsp" %>

    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h5 class="section-title ff-secondary text-center text-primary fw-normal">Feedback</h5>
                <h1 class="mb-4">We Value Your Feedback</h1>
            </div>

            <form action="submitFeedback" method="post" class="row">
                <div class="col-md-6 mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="col-12 mb-3">
                    <label for="feedback" class="form-label">Feedback</label>
                    <textarea class="form-control" id="feedback" name="feedback" rows="5" required></textarea>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Submit Feedback</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>

</html>
