<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>ABC Restaurant</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="/restaurant/img/favicon.ico" rel="icon">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/restaurant/customer/lib/animate/animate.min.css" rel="stylesheet">
    <link href="/restaurant/customer/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/restaurant/customer/owlcarousel/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/customer/css/index.css" rel="stylesheet">

    <!-- Tempus Dominus Styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/css/tempusdominus-bootstrap-4.min.css" />
</head>

<body>
    <!-- Navbar & Hero Start -->
    <div class="container-xxl position-relative p-0">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4 px-lg-5 py-3 py-lg-0 fixed-top">
            <a href="index.jsp" class="navbar-brand p-0">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-3"></i>ABC Restaurant</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <a href="/restaurant/customer/jsp/index.jsp" class="nav-item nav-link">Home</a>
                    <a href="/restaurant/customer/jsp/about.jsp" class="nav-item nav-link">About</a>
                    
                    <a href="/restaurant/customer/jsp/customerViewFoodItems.jsp" class="nav-item nav-link">Menu</a>
                    
                    <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">Our Special</a>
    <ul class="dropdown-menu">
        <li><a href="/restaurant/customer/jsp/ViewServices.jsp" class="dropdown-item">Services</a></li>
        <li><a href="/restaurant/customer/jsp/viewFacilities.jsp" class="dropdown-item">Facilities</a></li>
        <li><a href="/restaurant/customer/jsp/viewgallery.jsp" class="dropdown-item">Gallery</a></li>
    </ul>
           </div>         
                     
                    <div class="nav-item dropdown">
    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">Pages</a>
    <ul class="dropdown-menu">
        <li><a href="/restaurant/customer/jsp/reservation.jsp" class="dropdown-item">Booking</a></li>
        <li><a href="/restaurant/customer/jsp/team.jsp" class="dropdown-item">Our Team</a></li>
        <li><a href="/restaurant/customer/jsp/viewFeedback.jsp" class="dropdown-item">Feedback</a></li>
    </ul>
</div>
                    
                    <a href="/restaurant/customer/jsp/Contact.jsp" class="nav-item nav-link">Contact</a>
                    <a href="/restaurant/customer/jsp/feedback.jsp" class="nav-item nav-link">Feedback</a>
                </div>
                <a href="/restaurant/customer/jsp/reservation.jsp" class="btn btn-primary py-2 px-4">Book A Table</a>
                <a href="/restaurant/customer/jsp/Cart.jsp" class="nav-item nav-link">
                    <i class="fa fa-shopping-cart"></i>
                    <span id="cart-item-count" class="badge bg-danger">0</span> <!-- Placeholder for the count -->
                </a>
                <a href="/restaurant/customer/jsp/login.jsp" class="nav-item nav-link">Log Out</a>
            </div>
        </nav>
    </div>
    <!-- Navbar & Hero End -->

    <!-- Ensure body content is not hidden behind the fixed navbar -->
    <div style="padding-top: 80px;"> <!-- Adjust this value to match the height of your navbar -->
        <!-- Page content goes here -->
    </div>

    <!-- jQuery and Bootstrap JS (Required for dropdown and other components) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
</body>

</html>
