<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> ABC Restaurant Gallery</title>
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

        h2 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 20px;
        }

        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-input, .category-select, .search-button {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid var(--dark);
            border-radius: 5px;
        }

        .search-button {
            background-color: var(--primary);
            color: var(--light);
            cursor: pointer;
        }

        .search-button:hover {
            background-color: var(--dark);
            color: var(--light);
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .gallery-item {
            background-color: var(--light);
            border: 1px solid var(--dark);
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .gallery-item:hover {
            transform: scale(1.05);
        }

        .gallery-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .gallery-item-details {
            padding: 15px;
            text-align: center;
        }

        .gallery-item-title {
            font-size: 18px;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .gallery-item-description {
            font-size: 14px;
            color: var(--dark);
            margin-bottom: 15px;
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
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/css/tempusdominus-bootstrap-4.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/js/tempusdominus-bootstrap-4.min.js"></script>
    <script>
        function filterGallery() {
            var searchInput = document.getElementById('search-input').value.toLowerCase();
            var categorySelect = document.getElementById('category-select').value;
            var galleryItems = document.getElementsByClassName('gallery-item');

            for (var i = 0; i < galleryItems.length; i++) {
                var title = galleryItems[i].getElementsByClassName('gallery-item-title')[0].innerText.toLowerCase();
                var description = galleryItems[i].getElementsByClassName('gallery-item-description')[0].innerText.toLowerCase();
                var category = galleryItems[i].getAttribute('data-category');

                if ((title.includes(searchInput) || description.includes(searchInput)) && 
                    (categorySelect === '' || category === categorySelect)) {
                    galleryItems[i].style.display = '';
                } else {
                    galleryItems[i].style.display = 'none';
                }
            }
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
            <h1 class="display-3 text-white mb-3 animated slideInDown">Gallery</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Gallery</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
        <h5 class="section-title ff-secondary text-center text-primary fw-normal">Our Gallery</h5>
        <h1 class="mb-5">Browse Our Collection</h1>
    </div>

    <form action="" method="get" class="search-bar">
        <input type="text" id="search-input" name="query" class="search-input" placeholder="Search by title or description..." value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
        <select id="category-select" name="category" class="category-select">
            <option value="">All Categories</option>
            <option value="Nature" <%= "Nature".equals(request.getParameter("category")) ? "selected" : "" %>>Nature</option>
            <option value="Events" <%= "Events".equals(request.getParameter("category")) ? "selected" : "" %>>Events</option>
            <option value="People" <%= "People".equals(request.getParameter("category")) ? "selected" : "" %>>People</option>
            <option value="Miscellaneous" <%= "Miscellaneous".equals(request.getParameter("category")) ? "selected" : "" %>>Miscellaneous</option>
        </select>
        <input type="button" value="Filter" class="search-button" onclick="filterGallery()">
    </form>

    <div class="gallery-grid">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String query = request.getParameter("query");
            String category = request.getParameter("category");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT id, title, description, image, category FROM gallery WHERE 1=1";

                if (query != null && !query.trim().isEmpty()) {
                    sql += " AND (title LIKE ? OR description LIKE ?)";
                }
                if (category != null && !category.isEmpty()) {
                    sql += " AND category = ?";
                }

                pstmt = conn.prepareStatement(sql);

                int paramIndex = 1;
                if (query != null && !query.trim().isEmpty()) {
                    pstmt.setString(paramIndex++, "%" + query + "%");
                    pstmt.setString(paramIndex++, "%" + query + "%");
                }
                if (category != null && !category.isEmpty()) {
                    pstmt.setString(paramIndex++, category);
                }

                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
        <div class="gallery-item" data-category="<%= rs.getString("category") %>">
            <%
                String imagePath = rs.getString("image");
                String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                    ? request.getContextPath() + "/gallery_uploads/" + imagePath 
                    : "path/to/default/image.jpg"; // Replace with a default image path if needed
            %>
            <img src="<%= imageUrl %>" alt="Gallery Image">
            <div class="gallery-item-details">
                <div class="gallery-item-title"><%= rs.getString("title") %></div>
                <div class="gallery-item-description"><%= rs.getString("description") %></div>
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

    <%@ include file="footer.jsp" %>
</body>
</html>
