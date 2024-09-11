<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css" />
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <title>ABC Restaurant - Manage Orders</title>
    <style>
        #sidebar-wrapper {
            background-color: #ffffff; /* Set sidebar background color to white */
        }
        #page-content-wrapper {
            background-color: #ffffff; /* Set page content background color to white */
        }
        .list-group-item.active {
            background-color: #f8f9fa; /* Slightly different background for active item */
        }
        .sidebar-heading {
            background-color: #ffffff; /* Set sidebar heading background color to white */
        }
        .orders-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .order-actions button {
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 5px;
        }
        .order-actions button:hover {
            background-color: #e68900;
        }
        .order-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .order-item img {
            max-width: 60px;
            border-radius: 8px;
            margin-right: 10px;
        }
        .order-item div {
            font-size: 14px;
        }
        .search-container {
            margin-bottom: 20px;
        }
        .search-container input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 250px;
        }
        .search-container button {
            padding: 10px 15px;
            border: none;
            background-color: #FEA116;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
        }
        .search-container button:hover {
            background-color: #e68900;
        }
    </style>
</head>

<body>
    <div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <div class="bg-white" id="sidebar-wrapper">
            <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
                <i class="fa fa-utensils me-3"></i>ABC Restaurant
            </div>
            
            <div class="list-group list-group-flush my-3">
                
                <a href="/restaurant/staff/jsp/manageOrders.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
                    <i class="fas fa-receipt me-2"></i>Manage Orders
                </a>
                <a href="/restaurant/staff/jsp/viewreservation.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
                    <i class="fas fa-calendar-alt me-2"></i>Manage Reservations
                </a>
                <a href="/restaurant/staff/jsp/manageFeedback.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
                    <i class="fas fa-comment-alt me-2"></i>Manage Feedback
                </a>
                <a href="/restaurant/staff/jsp/ViewMessages.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
                    <i class="fas fa-comment-dots me-2"></i>Chat
                </a>
                <a href="/restaurant/staff/jsp/dashboard.jsp" class="list-group-item list-group-item-action bg-transparent text-danger fw-bold">
                    <i class="fas fa-user me-2"></i>Profile
                </a>
                <a href="/restaurant/admin/jsp/adminLogin.jsp" class="list-group-item list-group-item-action bg-transparent text-danger fw-bold">
                    <i class="fas fa-power-off me-2"></i>Logout
                </a>
            </div>
        </div>
        <!-- /#sidebar-wrapper -->
  <!-- Page Content -->
        <div id="page-content-wrapper">
            <nav class="navbar navbar-expand-lg navbar-light bg-transparent py-4 px-4">
                <div class="d-flex align-items-center">
                    <i class="fas fa-align-left primary-text fs-4 me-3" id="menu-toggle"></i>
              
                </div>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle second-text fw-bold" href="#" id="navbarDropdown"
                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user me-2"></i><%= session.getAttribute("staffName") %>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/restaurant/staff/jsp/dashboard.jsp">Profile</a></li>
                                <li><a class="dropdown-item" href="/restaurant/staff/jsp/login.jsp">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
            
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js"></script>
    <script>
        var el = document.getElementById("wrapper");
        var toggleButton = document.getElementById("menu-toggle");

        toggleButton.onclick = function () {
            el.classList.toggle("toggled");
        };
    </script>
    
</body>
  
</html>