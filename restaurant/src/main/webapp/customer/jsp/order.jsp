<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Food</title>
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

       

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
        
:root {
    --primary: #FEA116;
    --light: #F1F8FF;
    --dark: #0F172B;
}

form {
    background-color: var(--light);
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 80%;
    max-width: 800px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
}

label {
    font-weight: bold;
    color: var(--dark);
    margin-bottom: 5px;
}

input[type="text"],
input[type="email"],
input[type="datetime-local"],
input[type="number"],
textarea,
select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid var(--dark);
    border-radius: 4px;
    background-color: #fff;
    font-size: 16px;
    color: var(--dark);
}

input[type="radio"] {
    margin-right: 10px;
}

input[type="submit"] {
    background-color: var(--primary);
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    font-size: 18px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 100%;
    max-width: 200px;
}

input[type="submit"]:hover {
    background-color: var(--dark);
}

.hidden {
    display: none;
}

/* Adjusting the form layout for mobile devices */
@media (max-width: 768px) {
    form {
        width: 100%;
        padding: 15px;
    }

    input[type="submit"] {
        width: 100%;
    }
}


    </style>
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/css/tempusdominus-bootstrap-4.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/js/tempusdominus-bootstrap-4.min.js"></script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
             <h1 class="display-3 text-white mb-3 animated slideInDown">Order Your Favourite</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Order Food</li>
                </ol>
            </nav>
        </div>
    </div>

 <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Order Food</h5>
                    <h1 class="mb-5">Order</h1>
                </div>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = "";
        String description = "";
        String price = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            String sql = "SELECT name, description, price FROM food_items WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                description = rs.getString("description");
                price = rs.getString("price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <form action="http://localhost:8090/restaurant/OrderFoodServlet" method="post">
        <input type="hidden" name="foodId" value="<%= id %>">
        <input type="hidden" name="foodName" value="<%= name %>">
        <input type="hidden" name="foodPrice" value="<%= price %>">
        
        <label>Order Type:</label><br>
        <input type="radio" id="dineIn" name="orderType" value="dineIn" checked>
        <label for="dineIn">Dine In</label><br>
        <input type="radio" id="takeout" name="orderType" value="takeout">
        <label for="takeout">Take Out</label><br>
        <input type="radio" id="online" name="orderType" value="online">
        <label for="online">Online</label><br><br>

        <div id="dineInDetails" class="hidden">
            <label for="dineInTime">Preferred Dining Time:</label>
            <input type="datetime-local" id="dineInTime" name="dineInTime"><br><br>
        </div>

        <div id="onlineDetails" class="hidden">
            <label for="deliveryAddress">Delivery Address:</label><br>
            <textarea id="deliveryAddress" name="deliveryAddress" rows="4" cols="50"></textarea><br><br>
        </div>

        <div>
            <label for="mealSize">Meal Size:</label>
            <select id="mealSize" name="mealSize">
                <option value="small">Small</option>
                <option value="medium">Medium</option>
                <option value="large">Large</option>
            </select><br><br>
            
            <label for="mealType">Meal Type:</label>
            <select id="mealType" name="mealType">
                <option value="breakfast">Breakfast</option>
                <option value="lunch">Lunch</option>
                <option value="dinner">Dinner</option>
            </select><br><br>
        </div>
        <div>
    <label for="mealQuantity">Meal Quantity:</label>
    <input type="number" id="mealQuantity" name="mealQuantity" value="1" min="1" required><br><br>
</div>
        

        <div id="customerDetails">
            <label for="customerName">Name:</label>
            <input type="text" id="customerName" name="customerName" required><br><br>
            
            <label for="customerEmail">Email:</label>
            <input type="email" id="customerEmail" name="customerEmail" required><br><br>
            
            <label for="customerContact">Contact Number:</label>
            <input type="text" id="customerContact" name="customerContact" required><br><br>
        </div>

        <input type="submit" value="Place Order" action="http://localhost:8090/restaurant/customer/jsp/orderConfirmation.jsp">
    </form>

    <script>
        // JavaScript to toggle visibility of dining time and online address inputs
        document.addEventListener('DOMContentLoaded', function() {
            var dineInDetails = document.getElementById('dineInDetails');
            var onlineDetails = document.getElementById('onlineDetails');
            
            document.querySelectorAll('input[name="orderType"]').forEach(function(elem) {
                elem.addEventListener('change', function() {
                    if (this.value === 'dineIn') {
                        dineInDetails.classList.remove('hidden');
                        onlineDetails.classList.add('hidden');
                    } else if (this.value === 'online') {
                        dineInDetails.classList.add('hidden');
                        onlineDetails.classList.remove('hidden');
                    } else {
                        dineInDetails.classList.add('hidden');
                        onlineDetails.classList.add('hidden');
                    }
                });
            });

            // Set initial visibility
            if (document.querySelector('input[name="orderType"]:checked').value === 'dineIn') {
                dineInDetails.classList.remove('hidden');
                onlineDetails.classList.add('hidden');
            } else if (document.querySelector('input[name="orderType"]:checked').value === 'online') {
                dineInDetails.classList.add('hidden');
                onlineDetails.classList.remove('hidden');
            } else {
                dineInDetails.classList.add('hidden');
                onlineDetails.classList.add('hidden');
            }
        });
    </script>
      <%@ include file="footer.jsp" %>
</body>
</html>
