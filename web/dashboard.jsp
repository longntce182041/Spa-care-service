<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/dashboard.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Welcome to the Staff Dashboard</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-body text-center">
                            <i class="fa fa-money fa-3x mb-3"></i>
                            <h5 class="card-title">Cashier Functions</h5>
                            
                            <a href="#" onclick="loadContent('cashier_functions.jsp')" class="btn btn-light">Go to Cashier</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-secondary mb-3">
                        <div class="card-body text-center">
                            <i class="fa fa-users fa-3x mb-3"></i>
                            <h5 class="card-title">Customer Service</h5>
                            
                            <a href="#" onclick="loadContent('customer_service_functions.jsp')" class="btn btn-light">Go to Customer Service</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body text-center">
                            <i class="fa fa-line-chart fa-3x mb-3"></i>
                            <h5 class="card-title">Sales Functions</h5>
                            
                            <a href="#" onclick="loadContent('OrderManagement.jsp')" class="btn btn-light">Go to Sales</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-danger mb-3">
                        <div class="card-body text-center">
                            <i class="fa fa-warehouse fa-3x mb-3"></i>
                            <h5 class="card-title">Warehouse Functions</h5>
                            
                            <a href="#" onclick="loadContent('StaffWarehouse.jsp')" class="btn btn-light">Go to Warehouse</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                function loadContent(page) {
                                    $.ajax({
                                        url: page,
                                        method: 'GET',
                                        success: function (data) {
                                            $('#main-content').html(data);
                                        },
                                        error: function () {
                                            $('#main-content').html('<p>Error loading content.</p>');
                                        }
                                    });
                                }
        </script>
    </body>
</html>