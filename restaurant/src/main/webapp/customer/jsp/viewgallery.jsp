<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Gallery - ABC Restaurant</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Favicon -->
    <link href="<c:url value='/img/favicon.ico'/>" rel="icon">

    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="<c:url value='/lib/animate/animate.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/lib/owlcarousel/assets/owl.carousel.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css'/>" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value='/customer/css/bootstrap.min.css'/>" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<c:url value='/customer/css/index.css'/>" rel="stylesheet">
</head>
<style>
.gallery-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 16px;
    margin: 20px 0;
}

.gallery-item {
    position: relative;
    overflow: hidden;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.gallery-item img {
    width: 100%;
    height: auto;
    display: block;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.gallery-item:hover img {
    transform: scale(1.1);
}

.gallery-item-details {
    position: absolute;
    bottom: 0;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    width: 100%;
    padding: 10px;
    text-align: center;
    transform: translateY(100%);
    transition: transform 0.3s ease;
}

.gallery-item:hover .gallery-item-details {
    transform: translateY(0);
}

.gallery-item-title {
    font-size: 1.2em;
    font-weight: bold;
}

.gallery-item-description {
    font-size: 0.9em;
}

.like-button i, .share-button i {
    margin-right: 8px; /* Space between icon and text */
    vertical-align: middle; /* Align icon vertically with text */
}

.like-button, .share-button {
    display: inline-flex;
    align-items: center;
    margin-top: 10px;
    padding: 8px 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.like-button:hover, .share-button:hover {
    background-color: #0056b3;
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
                border-top: 1px solid rgba(255, 255, 255, .1)
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

</style>
<body>
<%@ include file="header.jsp" %>

    <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
            <h1 class="display-3 text-white mb-3 animated slideInDown">Our Gallery</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="<c:url value='/index.jsp'/>">Home</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Gallery</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
        <h5 class="section-title ff-secondary text-center text-primary fw-normal">Gallery</h5>
        <h1 class="mb-5">Our Delicious Food & Restaurant</h1>
    </div>

    <!-- Search Form -->
    <div class="container text-center mb-5">
        <form action="viewgallery.jsp" method="get" class="d-flex justify-content-center">
            <input type="text" name="search" class="form-control w-50" placeholder="Search by title or description" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <select name="category" class="form-control w-25 ml-3">
                <option value="">Select Category</option>
                <option value="Category1" <%= "Category1".equals(request.getParameter("category")) ? "selected" : "" %>>Event</option>
                <option value="Category2" <%= "Category2".equals(request.getParameter("category")) ? "selected" : "" %>>People</option>
  
                <!-- Add more categories as needed -->
            </select>
            <button type="submit" class="btn btn-primary ml-3">Search</button>
        </form>
    </div>

    <!-- Gallery Start -->
    <div class="gallery-grid">
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String searchQuery = request.getParameter("search");
        String category = request.getParameter("category");

        searchQuery = (searchQuery != null) ? searchQuery : "";
        category = (category != null) ? category : "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            String sql = "SELECT id, title, description, image FROM gallery WHERE 1=1";
            if (!searchQuery.trim().isEmpty()) {
                sql += " AND (title LIKE ? OR description LIKE ?)";
            }
            if (!category.trim().isEmpty()) {
                sql += " AND category = ?";
            }

            pstmt = conn.prepareStatement(sql);

            int index = 1;
            if (!searchQuery.trim().isEmpty()) {
                pstmt.setString(index++, "%" + searchQuery + "%");
                pstmt.setString(index++, "%" + searchQuery + "%");
            }
            if (!category.trim().isEmpty()) {
                pstmt.setString(index, category);
            }

            rs = pstmt.executeQuery();

            if (!rs.isBeforeFirst()) { // Check if the result set is empty
                String message = "No results found";
                if (!searchQuery.isEmpty()) {
                    message += " for '" + searchQuery + "'";
                }
                if (!category.isEmpty()) {
                    message += " in category '" + category + "'";
                }
                out.println("<p>" + message + "</p>");
            }

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String imagePath = rs.getString("image");
                String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                    ? request.getContextPath() + "/uploads/" + imagePath 
                    : request.getContextPath() + "/uploads/default.png";
    %>
        <div class="gallery-item">
            <img src="<%= imageUrl %>" alt="Gallery Image">
            <div class="gallery-item-details">
                <div class="gallery-item-title"><%= title %></div>
                <div class="gallery-item-description"><%= description %></div>
                <button class="like-button"><i class="fas fa-thumbs-up"></i> Like</button>
                <button class="share-button"><i class="fas fa-share-alt"></i> Share</button>
            </div>
        </div>
    <%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    </div>
    <!-- Gallery End -->
    
<%@ include file="footer.jsp" %>

   
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/lib/wow/wow.min.js'/>"></script>
    <script src="<c:url value='/lib/easing/easing.min.js'/>"></script>
    <script src="<c:url value='/lib/waypoints/waypoints.min.js'/>"></script>
    <script src="<c:url value='/lib/counterup/counterup.min.js'/>"></script>
    <script src="<c:url value='/lib/owlcarousel/owl.carousel.min.js'/>"></script>
    <script src="<c:url value='/lib/tempusdominus/js/moment.min.js'/>"></script>
    <script src="<c:url value='/lib/tempusdominus/js/moment-timezone.min.js'/>"></script>
    <script src="<c:url value='/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js'/>"></script>

    <!-- Template Javascript -->
    <script src="<c:url value='/customer/js/main.js'/>"></script>
</body>

</html>
