<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Food Menu</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .menu-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
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
        }

        .menu-item-actions {
            display: flex;
            align-items: center;
        }

        .menu-item-actions select {
            margin-right: 10px;
            padding: 5px;
            border-radius: 4px;
        }

        .menu-item-actions button {
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .menu-item-actions button:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <div class="menu-container">
        <h1>Our Menu</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT id, name, description, price, category, image FROM food_items";
                pstmt = conn.prepareStatement(sql);
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
                <form action="http://localhost:8090/restaurant/AddToCartServlet" method="post">
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
</body>
</html>
