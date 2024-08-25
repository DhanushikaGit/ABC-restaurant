<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> ABC Restaurant Food Menu</title>
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
    
    
    
      <meta charset="utf-8">
    
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">

  
    
     <!-- Customized Bootstrap Stylesheet -->
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/css/tempusdominus-bootstrap-4.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/js/tempusdominus-bootstrap-4.min.js"></script>
</head>
<body>



       <%@ include file="header.jsp" %>
    <div class="container-xxl py-5 bg-dark hero-header mb-5">
                <div class="container text-center my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Order Your Favorites</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center text-uppercase">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Pages</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Our Food Menu</li>
                        </ol>
                    </nav>
                </div>
            </div>
     <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Our Menu</h5>
                    <h1 class="mb-5">Order Your Favorite Dish</h1>
                </div>

    <form action="" method="get" class="search-bar">
        <input type="text" name="query" class="search-input" placeholder="Search by name or price..." value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
        <select name="category" class="category-select">
            <option value="">All Categories</option>
            <option value="Vegetables" <%= "Vegetables".equals(request.getParameter("category")) ? "selected" : "" %>>Vegetables</option>
            <option value="Non-Vegetables" <%= "Non-Vegetables".equals(request.getParameter("category")) ? "selected" : "" %>>Non-Vegetables</option>
            <option value="Beverages" <%= "Beverages".equals(request.getParameter("category")) ? "selected" : "" %>>Beverages</option>
            <option value="Unique Dishes" <%= "Unique Dishes".equals(request.getParameter("category")) ? "selected" : "" %>>Unique Dishes</option>
        </select>
        <input type="submit" value="Search" class="search-button">
    </form>
    

    <div class="menu-grid">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String query = request.getParameter("query");
            String category = request.getParameter("category");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
                
                String sql = "SELECT id, name, description, price, category, image FROM food_items WHERE 1=1";
                
                if (query != null && !query.trim().isEmpty()) {
                    sql += " AND (name LIKE ? OR price LIKE ?)";
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
        <div class="menu-item">
            <%
                String imagePath = rs.getString("image");
                String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                    ? request.getContextPath() + "/uploads/" + imagePath 
                    : "path/to/default/image.jpg"; // Replace with a default image path if needed
            %>
            <img src="<%= imageUrl %>" alt="Food Image">
            <div class="menu-item-details">
                <div class="menu-item-name"><%= rs.getString("name") %></div>
                <div class="menu-item-description"><%= rs.getString("description") %></div>
                <div class="menu-item-price">$<%= rs.getBigDecimal("price") %></div>
                <form action="http://localhost:8090/restaurant/customer/jsp/order.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="submit" value="Order" class="order-button">
                </form>
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
