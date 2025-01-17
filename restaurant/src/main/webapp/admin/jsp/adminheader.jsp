<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>ABC Restaurant</title>
</head>

<body>
    <div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <div class="bg-white" id="sidebar-wrapper">
            <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
                <i class="fa fa-utensils me-3"></i>ABC Restaurant
            </div>
            
         <div class="list-group list-group-flush my-3">
    <a href="#" class="list-group-item list-group-item-action bg-transparent second-text active">
        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
    </a>
    <a href="/restaurant/admin/jsp/AddFoodItem.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-project-diagram me-2"></i>Manage Food
    </a>
    <a href="/restaurant/admin/jsp/staff.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-users me-2"></i>Manage Staff
    </a>
    <a href="/restaurant/admin/jsp/manage-customers.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-user-friends me-2"></i>Manage Customer
    </a>
    <a href="/restaurant/admin/jsp/reservation.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-calendar-alt me-2"></i>Our Reservation
    </a>
    <a href="/restaurant/admin/jsp/ManageFacilities.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-building me-2"></i>Manage Facilities
    </a>
    <a href="/restaurant/admin/jsp/manageServices.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-concierge-bell me-2"></i>Manage Services
    </a>
    <a href="/restaurant/admin/jsp/managegallery.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-images me-2"></i>Manage Gallery
    </a>
    <a href="/restaurant/admin/jsp/managefeedback.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-comment-alt me-2"></i>Manage Feedback
    </a>
    <a href="/restaurant/admin/jsp/orderDetails.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-receipt me-2"></i>Our Orders
    </a>
    <a href="/restaurant/admin/jsp/replymessage.jsp" class="list-group-item list-group-item-action bg-transparent second-text fw-bold">
        <i class="fas fa-comment-dots me-2"></i>Chat
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
                    <h2 class="fs-2 m-0">Dashboard</h2>
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
                                <i class="fas fa-user me-2"></i>Dhanu
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><a class="dropdown-item" href="/restaurant/admin/jsp/adminLogin.jsp">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
            

            
                   
    <!-- /#wrapper -->

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
