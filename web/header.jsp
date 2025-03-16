<!DOCTYPE html>
<%
    String username = (session != null) ? (String) session.getAttribute("user") : null;
%>
<html lang="en">
    <head>
        <title>Petique Spa</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">
        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/navbar.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>
        <div class="wrap">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 d-flex align-items-center">
                        <p class="mb-0 phone pl-md-2">
                            <a href="#" class="mr-2"><span class="fa fa-phone mr-1"></span> +00 1234 567</a> 
                            <a href="#"><span class="fa fa-paper-plane mr-1"></span> youremail@email.com</a>
                        </p>
                    </div>
                    <div class="col-md-6 d-flex justify-content-md-end">
                        <div class="social-media">
                            <p class="mb-0 d-flex">
                                <a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-facebook"><i class="sr-only">Facebook</i></span></a>
                                <a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-twitter"><i class="sr-only">Twitter</i></span></a>
                                <a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-instagram"><i class="sr-only">Instagram</i></span></a>
                                <a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-dribbble"><i class="sr-only">Dribbble</i></span></a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="index.jsp"><span class="flaticon-pawprint-1 mr-2"></span>Petique Spa</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="fas fa-bars"></span> Menu
                </button>
                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <% if (username != null){%>
                        <li class="nav-item"><a href="homepage.jsp" class="nav-link">Home</a>
                            <% } else {%>
                        <li class="nav-item"><a href="index.jsp" class="nav-link">Home</a></li>
                            <%} %>
                        <li class="nav-item active"><a href="Shop.jsp" class="nav-link">Shop</a></li>
                        <li class="nav-item"><a href="appointment.jsp" class="nav-link">Appointment</a></li>
                            <% if (username != null) { %>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-user nav-item">  </i>
                            </a>

                            <div class="dropdown-menu" aria-labelledby="profileDropdown">
                                <a class="dropdown-item-text"> <%= username %> </a>
                                <a class="dropdown-item" href="profile.jsp">Profile</a>
                                <a class="dropdown-item" href="index.jsp">Logout</a>
                            </div>
                        </li>
                        <% } else { %>
                        <li class="nav-item"><a href="login.jsp" class="nav-link">Login</a></li>
                            <% } %>
                        <li class="nav-item position-relative cart-icon">
                            <a href="Cart.jsp" class="nav-link">
                                <i class="fas fa-shopping-cart"></i>
                                <span class="cart-count" id="cart-count">
                                    <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0%>
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>