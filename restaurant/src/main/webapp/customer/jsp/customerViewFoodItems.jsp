<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/restaurant/customer/css/index.css" rel="stylesheet">
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <meta charset="UTF-8">
    <title>Food Menu</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>

/* Navbar */
.navbar-dark .navbar-nav .nav-link {
    margin-left: 25px;
    padding: 35px 0;
    font-size: 15px;
    color: var(--light) !important;
    text-transform: uppercase;
    font-weight: 500;
    transition: color 0.5s;
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
    transition: max-height 0.5s;
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

/* Menu Container */
.menu-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

/* Menu Item */
.menu-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
    transition: background-color 0.3s;
}

.menu-item:hover {
    background-color: #f9f9f9;
}

.menu-item:last-child {
    border-bottom: none;
}

.menu-item img {
    max-width: 100px;
    border-radius: 8px;
}

.menu-item-details {
    flex-grow: 1;
    margin-left: 20px;
}

.menu-item-details h3 {
    margin: 0;
    font-size: 1.2rem;
    color: #333;
}

.menu-item-details p {
    margin: 5px 0;
    color: #777;
}

.menu-item-price {
    font-size: 1.1rem;
    color: #333;
    white-space: nowrap;
}

.menu-item-actions {
    display: flex;
    align-items: center;
}

.menu-item-actions select {
    margin-right: 10px;
    padding: 5px;
    border-radius: 4px;
    border: 1px solid #ddd;
}

.menu-item-actions button {
    background-color: var(--primary);
    color: #fff;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s;
}

.menu-item-actions button:hover {
    background-color: var(--dark);
    color: #fff;
}

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

/* Search Bar */
.search-bar {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
    flex-wrap: wrap;
}

.search-input, .category-select, .search-button {
    padding: 10px;
    margin-right: 10px;
    border: 1px solid var(--dark);
    border-radius: 5px;
    min-width: 150px;
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

@media (max-width: 767.98px) {
    .menu-item {
        flex-direction: column;
        align-items: flex-start;
    }

    .menu-item img {
        margin-bottom: 10px;
    }

    .menu-item-details {
        margin-left: 0;
        margin-bottom: 10px;
    }

    .menu-item-actions {
        width: 100%;
        justify-content: space-between;
    }
}
  
      
    </style>
    
</head>
<body>



       <%@ include file="header.jsp" %>
   <div class="container-xxl py-5 bg-dark hero-header mb-5">
    <div class="container text-center my-5 pt-5 pb-4">
        <h1 class="display-3 text-white mb-3 animated slideInDown">Order Your Favorites</h1>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb justify-content-center text-uppercase">
                <li class="breadcrumb-item"><a href="#" class="text-white">Home</a></li>
                <li class="breadcrumb-item"><a href="#" class="text-white">Pages</a></li>
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
    <a href="<%= request.getRequestURI() %>" class="search-button">Clear</a>
</form>
   
    
    <div class="menu-container">
        <h1>Our Menu</h1>
       <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

        // Get search parameters
        String query = request.getParameter("query");
        String category = request.getParameter("category");

        // Build SQL query with search filters
        String sql = "SELECT id, name, description, price, category, image FROM food_items WHERE 1=1";
        
        if (query != null && !query.trim().isEmpty()) {
            sql += " AND (name LIKE ? OR description LIKE ?)";
        }
        if (category != null && !category.trim().isEmpty()) {
            sql += " AND category = ?";
        }
        
        pstmt = conn.prepareStatement(sql);

        int index = 1;
        if (query != null && !query.trim().isEmpty()) {
            pstmt.setString(index++, "%" + query + "%");
            pstmt.setString(index++, "%" + query + "%");
        }
        if (category != null && !category.trim().isEmpty()) {
            pstmt.setString(index++, category);
        }

        rs = pstmt.executeQuery();

        while (rs.next()) {
%>
        <div class="menu-item">
            <img src="<%= request.getContextPath() + "/uploads/" + rs.getString("image") %>" alt="Food Image">
            <div class="menu-item-details">
                <h3><%= rs.getString("name") %></h3>
                <p><%= rs.getString("description") %></p>
                <p>Category: <%= rs.getString("category") %></p>
            </div>
            <div class="menu-item-price">
                $<%= rs.getBigDecimal("price") %>
            </div>
            <div class="menu-item-actions">
                <form action="<%= request.getContextPath() + "/AddToCartServlet" %>" method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <select name="quantity">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    <button type="submit"><i class="las la-shopping-cart"></i> Add to Cart</button>
                </form>
            </div>
        </div>
        <%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
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
