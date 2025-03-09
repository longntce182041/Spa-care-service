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
                <ul class="list-unstyled components mb-5" id="sidebarMenu">
                    <li class="active">
                        <a href="#" onclick="loadContent('dashboard.jsp', this)">Dashboard</a>
                    </li>
                    <li>
                        <a href="#" onclick="loadContent('cashier_functions.jsp', this)">Cashier Functions</a>
                    </li>
                    <li>
                        <a href="#" onclick="loadContent('customer_service_functions.jsp', this)">Customer Service Functions</a>
                    </li>
                    <li>
                        <a href="#" onclick="loadContent('OrderManagement.jsp', this)">Sales Functions</a>
                    </li>
                    <li>
                        <a href="#" onclick="loadContent('StaffWarehouse.jsp', this)">Warehouse Functions</a>
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
            
            <div id="main-content" class="content-box">
                <!-- Nội dung sẽ được tải vào đây -->
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
        <script>
            function loadContent(page, element) {
                $.ajax({
                    url: page,
                    method: 'GET',
                    success: function(data) {
                        $('#main-content').html(data);
                        $('#sidebarMenu li').removeClass('active');
                        $(element).parent().addClass('active');
                    },
                    error: function() {
                        $('#main-content').html('<p>Error loading content.</p>');
                    }
                });
            }

            // Load default content
            $(document).ready(function() {
                loadContent('dashboard.jsp', $('#sidebarMenu li.active a')[0]);
            });
        </script>
</body>
</html>