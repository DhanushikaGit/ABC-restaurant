<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Restoran - Bootstrap Restaurant Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="/restaurant/img/favicon.ico" rel="icon">

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
    <link href="/restaurant/customer/owlcarousel/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    
    <!-- Customized Bootstrap Stylesheet -->
    <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/customer/css/index.css" rel="stylesheet">

    <!-- Tempus Dominus Styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/css/tempusdominus-bootstrap-4.min.css" />

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/js/tempusdominus-bootstrap-4.min.js"></script>
</head>

<body>

<style>
.container-xxl {
    width: 100%;
    max-width: 100%;
    padding: 0;
    margin: 0;
}

/* Adjust the hero section */
.hero-header {
    position: relative;
    width: 100%;
    height: auto;
    background-size: cover;
    background-position: center;
    padding: 100px 0; /* Adjust this value to create space for scrolling */
}

/* Adjust the image size within the hero section */
.hero-header img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

/* Adjust text alignment and size within the hero section */
.hero-header .hero-text {
    position: relative;
    text-align: center;
    color: #fff;
    font-size: 2.5rem;
    margin-top: 20px; /* Add margin to create space between text and image */
}

/* Button styling within the hero section */
.hero-header .btn-primary {
    padding: 10px 30px;
    background-color: var(--primary);
    border: none;
    color: #fff;
    font-size: 1.2rem;
    transition: background-color 0.3s ease;
}

.hero-header .btn-primary:hover {
    background-color: darken(var(--primary), 10%);
}

/* Ensure responsiveness on smaller screens */
@media (max-width: 768px) {
    .hero-header .hero-text {
        font-size: 1.8rem;
    }
    
    .hero-header .btn-primary {
        font-size: 1rem;
        padding: 8px 20px;
    }
}

</style>

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Company</h4>
                    <a class="btn btn-link" href="about.jsp">About Us</a>
                    <a class="btn btn-link" href="contact.jsp">Contact Us</a>
                    <a class="btn btn-link" href="booking.jsp">Reservation</a>
                    <a class="btn btn-link" href="privacy.jsp">Privacy Policy</a>
                    <a class="btn btn-link" href="terms.jsp">Terms & Condition</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Contact</h4>
                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                    <div class="d-flex pt-2">
                        <a class="btn btn-outline-light btn-social" href="#"><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-outline-light btn-social" href="#"><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-outline-light btn-social" href="#"><i class="fab fa-youtube"></i></a>
                        <a class="btn btn-outline-light btn-social" href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Opening</h4>
                    <h5 class="text-light fw-normal">Monday - Saturday</h5>
                    <p>09AM - 09PM</p>
                    <h5 class="text-light fw-normal">Sunday</h5>
                    <p>10AM - 08PM</p>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Newsletter</h4>
                    <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                    <div class="position-relative mx-auto" style="max-width: 400px;">
                        <input class="form-control border-primary w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                        <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="copyright">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved. 
                        Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a><br><br>
                        Distributed By <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <div class="footer-menu">
                            <a href="#">Home</a>
                            <a href="#">Cookies</a>
                            <a href="#">Help</a>
                            <a href="#">FQAs</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/customer/lib/wow/wow.min.js"></script>
    <script src="/customer/lib/easing/easing.min.js"></script>
    <script src="/customer/lib/waypoints/waypoints.min.js"></script>
    <script src="/customer/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/customer/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/customer/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/customer/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="/restaurant/customer/js/main.js"></script>
</body>

</html>

