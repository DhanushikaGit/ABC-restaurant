<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Feedback - ABC Restaurant</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
        <!-- Template Stylesheet -->
    <link href="/restaurant/customer/css/index.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
     :root {
    --primary: #FEA116;
    --light: #F1F8FF;
    --dark: #0F172B;
}

body {
    background-color: #f9f9f9;
    font-family: Arial, sans-serif;
}

.container {
    margin-top: 50px;
}

h1 {
    color: var(--dark);
    font-weight: bold;
    margin-bottom: 30px;
    text-align: center;
}

.testimonial-section {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    align-items: flex-start;
    margin-bottom: 30px;
}

.testimonial-box {
    background-color: var(--light);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 30%;
    text-align: center;
    margin-bottom: 20px;
    position: relative;
    overflow: hidden;
}

.testimonial-box.highlighted {
    background-color: var(--primary);
    color: #fff;
}

.client-name {
    font-weight: bold;
    font-size: 1.1rem;
}

.profession {
    color: var(--dark);
    font-size: 0.9rem;
}

.star-rating {
    color: #F1F8FF;
    font-size: 1.5rem;
    margin-top: 10px;
}

.star-rating .fas {
    color: #FEA116;
}

.quote-icon {
    color: var(--primary);
    font-size: 2rem;
    position: absolute;
    top: 10px;
    left: 10px;
}

.testimonial-box.highlighted .quote-icon {
    color: #fff;
}

/*** Navbar ***/
.navbar-dark .navbar-nav .nav-link {
    margin-left: 25px;
    padding: 35px 0;
    font-size: 15px;
    color: var(--light) !important;
    text-transform: uppercase;
    font-weight: 500;
    outline: none;
    transition: .5s;
}

.sticky-top.navbar-dark .navbar-nav .nav-link {
    padding: 20px 0;
}

.navbar-dark .navbar-nav .nav-link:hover,
.navbar-dark .navbar-nav .nav-link.active {
    color: var(--primary) !important;
}

.navbar-dark .navbar-brand img {
    max-height: 60px;
    transition: .5s;
}

.sticky-top.navbar-dark .navbar-brand img {
    max-height: 45px;
}

@media (max-width: 991.98px) {
    .sticky-top.navbar-dark {
        position: relative;
    }

    .navbar-dark .navbar-collapse {
        margin-top: 15px;
        border-top: 1px solid rgba(255, 255, 255, .1);
    }

    .navbar-dark .navbar-nav .nav-link,
    .sticky-top.navbar-dark .navbar-nav .nav-link {
        padding: 10px 0;
        margin-left: 0;
    }

    .navbar-dark .navbar-brand img {
        max-height: 45px;
    }
}

@media (min-width: 992px) {
    .navbar-dark {
        position: absolute;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 999;
        background: transparent !important;
    }

    .sticky-top.navbar-dark {
        position: fixed;
        background: var(--dark) !important;
    }
}



.container-fluid {
    padding: 0;
    margin: 0;
    width: 100%;
}

.hero-header {
    background-color: #343a40;
    padding: 80px 0;
    margin-bottom: 40px;
}

.hero-header h1 {
    font-size: 3rem;
    font-weight: bold;
    color: #ffffff;
    margin-bottom: 20px;
}

.breadcrumb {
    background-color: transparent;
    padding: 0;
    margin-bottom: 0;
}

.breadcrumb-item a {
    color: #ffffff;
    text-decoration: none;
    font-weight: bold;
}

.breadcrumb-item a:hover {
    color: #FEA116;
    text-decoration: underline;
}

.breadcrumb-item.active {
    color: #ffffff;
}

     
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>
<div class="container-fluid py-5 bg-dark hero-header mb-5">
    <div class="container text-center my-5 pt-5 pb-4">
        <h1 class="display-3 text-white mb-3">Feedback</h1>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb justify-content-center text-uppercase">
                <li class="breadcrumb-item"><a href="#" class="text-white">Home</a></li>
                <li class="breadcrumb-item"><a href="#" class="text-white">Pages</a></li>
                <li class="breadcrumb-item text-white active" aria-current="page">Feedback</li>
            </ol>
        </nav>
    </div>
</div>

    
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
        <h5 class="section-title ff-secondary text-center text-primary fw-normal">Feedback </h5>
        <h1 class="mb-5">Our Feedback</h1>
    </div>

    <div class="container">
        <div class="testimonial-section">
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                    String sql = "SELECT name, email, feedback, rating FROM feedback";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String feedback = rs.getString("feedback");
                        int rating = rs.getInt("rating");
            %>
            <div class="testimonial-box <%= (rating >= 4) ? "highlighted" : "" %>">
                <i class="fas fa-quote-left quote-icon"></i>
                <p><%= feedback %></p>
                <div class="client-name"><%= name %></div>
                <div class="profession"><%= email %></div>
                <div class="star-rating">
                    <% for (int i = 1; i <= 5; i++) { %>
                        <i class="<%= (i <= rating) ? "fas fa-star" : "far fa-star" %>"></i>
                    <% } %>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div>Error: " + e.getMessage() + "</div>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- Font Awesome for star icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
