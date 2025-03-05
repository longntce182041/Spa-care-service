<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/staffdashboard.css">
</head>
<body>
    <!-- New Navbar with Icon and Search Box -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#"><i class="fa fa-dashboard"></i> Staff Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <form class="form-inline my-2 my-lg-0 ml-auto">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
    <div class="wrapper d-flex align-items-stretch">
        <nav id="sidebar" class="bg-dark">
            <div class="p-4 pt-5">
                <a class="navbar-brand" href="index.jsp"><span class="flaticon-pawprint-1 mr-2"></span>Petique Spa</a>
                <ul class="list-unstyled components mb-5">
                    <li class="active">
                        <a href="staffdashboard.jsp">Dashboard</a>
                    </li>
                    <li>
                        <a href="cashier_functions.jsp">Cashier Functions</a>
                    </li>
                    <li>
                        <a href="customer_service_functions.jsp">Customer Service Functions</a>
                    </li>
                    <li>
                        <a href="sales_functions.jsp">Sales Functions</a>
                    </li>
                    <li>
                        <a href="StaffWarehouse.jsp">Warehouse Functions</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Page Content  -->
        <div id="content" class="p-4 p-md-5">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <a class="navbar-brand" href="#">Staff Dashboard</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
                            <% if ("staff".equalsIgnoreCase(role)) { %>
                            <a class="nav-link" href="changePassword.jsp"><i class="fa fa-key"></i> Change Password</a>
                            <% } %>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp"><i class="fa fa-sign-out"></i> Logout</a>
                        </li>
                    </ul>
                </div>
            </nav>
            <h2 class="mb-4">Staff Dashboard</h2>
            <div class="content-box">
                <div class="row">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary mb-3">
                            <div class="card-header">Cashier</div>
                            <div class="card-body">
                                <h5 class="card-title">Cashier Functions</h5>
                                <p class="card-text">View and manage cashier functions.</p>
                                <a href="cashier_functions.jsp" class="btn btn-light">Go to Cashier</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-secondary mb-3">
                            <div class="card-header">Customer Service</div>
                            <div class="card-body">
                                <h5 class="card-title">Customer Service Functions</h5>
                                <p class="card-text">View and manage customer service functions.</p>
                                <a href="customer_service_functions.jsp" class="btn btn-light">Go to Customer Service</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success mb-3">
                            <div class="card-header">Sales</div>
                            <div class="card-body">
                                <h5 class="card-title">Sales Functions</h5>
                                <p class="card-text">View and manage sales functions.</p>
                                <a href="sales_functions.jsp" class="btn btn-light">Go to Sales</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-danger mb-3">
                            <div class="card-header">Warehouse</div>
                            <div class="card-body">
                                <h5 class="card-title">Warehouse Functions</h5>
                                <p class="card-text">View and manage warehouse functions.</p>
                                <a href="StaffWarehouse.jsp" class="btn btn-light">Go to Warehouse</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.timepicker.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="js/main.js"></script>
</body>
</html>