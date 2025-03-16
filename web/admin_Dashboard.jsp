    <%-- 
        Document   : admin_Dashboard
        Created on : Feb 27, 2025, 8:50:36 PM
        Author     : Nguyen Thanh Long - CE182041 
    --%>

    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    <%
        String role = (String) session.getAttribute("role");
    %>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
            <link rel="stylesheet" href="css/animate.css">
            <link rel="stylesheet" href="css/owl.carousel.min.css">
            <link rel="stylesheet" href="css/owl.theme.default.min.css">
            <link rel="stylesheet" href="css/magnific-popup.css">
            <link rel="stylesheet" href="css/bootstrap-datepicker.css">
            <link rel="stylesheet" href="css/jquery.timepicker.css">
            <link rel="stylesheet" href="css/flaticon.css">
            <link rel="stylesheet" href="css/style.css">
            <link rel="stylesheet" href="css/Style_admin_dashboard.css">
        </head>
        <body>
            <!-- New Navbar with Icon and Search Box -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <a class="navbar-brand" href="#"><i class="fa fa-dashboard"></i> Dashboard</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </nav>
            <div class="wrapper d-flex align-items-stretch">
                <nav id="sidebar">
                    <div class="p-4 pt-5">
                        <a class="navbar-brand" href="index.jsp"><span class="flaticon-pawprint-1 mr-2"></span>Petique Spa</a>
                        <ul class="list-unstyled components mb-5">
                            <li class="active">
                                <a href="admin_Dashboard.jsp">Dashboard</a>
                            </li>
                            <li >
                                <a href="ManageProductsServlet">Manage Products</a>
                            </li>
                            <li>
                                <a href="ManageCategoryServlet">Manage Categories</a>
                            </li>
                            <li>
                                <a href="OrderManagement.jsp">Manage Orders</a>
                            </li>
                            <li>
                                <a href="ManageCustomerServlet">Manage Users</a>
                            </li>
                            <li>
                                <a href="StaffServlet">Manage Staff</a>
                            </li>
                            <li>
                                <a href="PromotionServlet">Manage Promotion</a>
                            </li>
                            <li>
                                <a href="ManageServiceServlet">Manage Service</a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Page Content  -->
                <div id="content" class="p-4 p-md-5">             
                    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                        <a class="navbar-brand" href="#">Admin Dashboard</a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item">
                                    <% if ("admin".equalsIgnoreCase(role)) { %>
                                    <a class="nav-link" href="changePassword.jsp"><i class="fa fa-key"></i> Change Password</a>
                                    <% } %>

                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp"><i class="fa fa-sign-out"></i> Logout</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                    <h2 class="mb-4">Admin Dashboard</h2>
                    <div class="content-box">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="card text-white bg-primary mb-3">
                                    <div class="card-header">Products</div>
                                    <div class="card-body">
                                        <h5 class="card-title">Manage Products</h5>
                                        <p class="card-text">View and manage all products.</p>
                                        <a href="ManageProductsServlet" class="btn btn-light">Go to Products</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-secondary mb-3">
                                    <div class="card-header">Categories</div>
                                    <div class="card-body">
                                        <h5 class="card-title">Manage Categories</h5>
                                        <p class="card-text">View and manage all categories.</p>
                                        <a href="ManageCategories.jsp" class="btn btn-light">Go to Categories</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-success mb-3">
                                    <div class="card-header">Orders</div>
                                    <div class="card-body">
                                        <h5 class="card-title">Manage Orders</h5>
                                        <p class="card-text">View and manage all orders.</p>
                                        <a href="ManageOrders.jsp" class="btn btn-light">Go to Orders</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-danger mb-3">
                                    <div class="card-header">Users</div>
                                    <div class="card-body">
                                        <h5 class="card-title">Manage Users</h5>
                                        <p class="card-text">View and manage all users.</p>
                                        <a href="ManageCustomerServlet" class="btn btn-light">Go to Users</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card text-white bg-danger mb-3">
                                    <div class="card-header">Staff</div>
                                    <div class="card-body">
                                        <h5 class="card-title">Manage Staff</h5>
                                        <p class="card-text">View and manage all staff.</p>
                                        <a href="manageStaff.jsp" class="btn btn-light">Go to Staff</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                    <div class="card text-white bg-danger mb-3">
                                        <div class="card-header">Promotion</div>
                                        <div class="card-body">
                                            <h5 class="card-title">Manage Promotion</h5>
                                            <p class="card-text">View and manage all staff.</p>
                                            <a href="promotion.jsp" class="btn btn-light">Go to Staff</a>
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>

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