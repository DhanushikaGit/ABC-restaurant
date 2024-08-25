<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Cancelled</title>
    <style>

.confirmation {
    border: 2px solid #0F172B; /* Dark border */
    padding: 20px;
    border-radius: 8px;
    background-color: #FEA116; /* Primary background color */
    color: #0F172B; /* Dark text color */
    text-align: center;
}

.confirmation h2 {
    color: #0F172B; /* Dark text color */
    font-size: 24px;
    margin-bottom: 10px;
}

.confirmation p {
    margin: 5px 0;
    font-size: 18px;
}

.button {
    display: inline-block;
    padding: 12px 24px;
    margin-top: 20px;
    font-size: 16px;
    color: #F1F8FF; /* Light text color */
    background-color: #0F172B; /* Dark background color */
    border: none;
    border-radius: 5px;
    text-decoration: none;
    text-align: center;
    transition: background-color 0.3s ease;
}

.button:hover {
    background-color: #FEA116; /* Primary background on hover */
    color: #0F172B; /* Dark text color on hover */
}
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
        
    </style>
</head>
<body>

       <%@ include file="header.jsp" %>
       <div class="container-xxl py-5 bg-dark hero-header mb-5">
                <div class="container text-center my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Contact Us</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center text-uppercase">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Pages</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Contact</li>
                        </ol>
                    </nav>
                </div>
            </div>
    <div class="confirmation">
        <h2>Order Cancelled</h2>
        <p>Your order has been successfully canceled. We are sorry for any inconvenience.</p>
        <a href="index.jsp" class="button">Return to Home</a>
    </div>
     <%@ include file="footer.jsp" %>
</body>
</html>
