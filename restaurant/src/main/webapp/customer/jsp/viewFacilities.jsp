<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Facilities</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
        <link href="/restaurant/customer/css/index.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
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

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .menu-item {
            background-color: var(--light);
            border: 1px solid var(--dark);
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .menu-item:hover {
            transform: scale(1.05);
        }

        .menu-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .menu-item-details {
            padding: 15px;
            text-align: center;
        }

        .menu-item-name {
            font-size: 18px;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .menu-item-description {
            font-size: 14px;
            color: var(--dark);
            margin-bottom: 15px;
        }

        .menu-item-price {
            font-size: 16px;
            color: var(--primary);
            font-weight: bold;
            margin-bottom: 15px;
        }

        .order-button {
            background-color: var(--primary);
            color: var(--light);
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        .order-button:hover {
            background-color: var(--dark);
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
    <script>
        function filterFacilities() {
            const searchTerm = document.getElementById('search').value.toLowerCase();
            const category = document.getElementById('category').value.toLowerCase();

            const items = document.querySelectorAll('.menu-item');
            items.forEach(item => {
                const name = item.querySelector('.menu-item-name').textContent.toLowerCase();
                const description = item.querySelector('.menu-item-description').textContent.toLowerCase();
                const itemCategory = item.dataset.category.toLowerCase();

                if ((name.includes(searchTerm) || description.includes(searchTerm)) && 
                    (category === 'all' || itemCategory === category)) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        }
    </script>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
            <h1 class="display-3 text-white mb-3 animated slideInDown">Facility and Features</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Facilities</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="search-bar">
        <input type="text" id="search" class="search-input" placeholder="Search facilities...">
        <select id="category" class="category-select">
            <option value="all">All Categories</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
            <!-- Add more options as needed -->
        </select>
        <button class="search-button" onclick="filterFacilities()">Search</button>
    </div>

    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
        <h5 class="section-title ff-secondary text-center text-primary fw-normal">Our Main Facilities</h5>
        <h1 class="mb-5">Facilities</h1>
    </div>

    <div class="menu-grid">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT id, name, description, status, image FROM facilities";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    String imagePath = rs.getString("image");
                    String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                        ? request.getContextPath() + "/uploads/" + imagePath 
                        : "";
        %>
        <div class="menu-item" data-category="<%= status.toLowerCase() %>">
            <% if (!imageUrl.isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="Facility Image">
            <% } else { %>
                <img src="<%= request.getContextPath() + "/uploads/default.png" %>" alt="No Image">
            <% } %>
            <div class="menu-item-details">
                <div class="menu-item-name"><%= name %></div>
                <div class="menu-item-description"><%= description %></div>
                <div class="menu-item-price"><%= status %></div>
                <button class="order-button">Order Now</button>
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

    <%@ include file="footer.jsp" %>
</body>
</html>
