<%-- 
    Document   : ManageCustomer
    Created on : Mar 4, 2025, 4:58:54 PM
    Author     : Nguyen Thanh Long - CE182041 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Customers</title>
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
        <link rel="stylesheet" href="css/Style_manageProduct.css">
    </head>
    <body>
        <!-- New Navbar with Icon and Search Box -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#"><i class="fa fa-dashboard"></i> Dashboard</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
        </nav>
        <div class="wrapper d-flex align-items-stretch">
            <nav id="sidebar">
                <div class="p-4 pt-5">
                    <a class="navbar-brand" href="index.jsp"><span class="flaticon-pawprint-1 mr-2"></span>Petique Spa</a>
                    <ul class="list-unstyled components mb-5">
                        <li>
                            <a href="admin_Dashboard.jsp">Dashboard</a>
                        </li>
                        <li>
                            <a href="ManageProductsServlet">Manage Products</a>
                        </li>
                        <li>
                            <a href="ManageCategorỷevlet">Manage Categories</a>
                        </li>
                        <li>
                            <a href="ManageOrders.jsp">Manage Orders</a>
                        </li>
                        <li class="active">
                            <a href="ManageCustomerServlet">Manage Users</a>
                        </li>
                        <li>
                            <a href="manageStaff.jsp">Manage Staff</a>
                        </li>
                        <li>
                            <a href="PromotionServlet">Manage Promotion</a>
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
                                <a class="nav-link" href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp"><i class="fa fa-sign-out"></i> Logout</a>
                            </li>
                        </ul>
                    </div>
                </nav>
                <h2 class="mb-4"></h2>
                <div class="container">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>User ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Full Name</th>
                                    <th>Address</th>
                                    <th>Phone</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<User> customers = (List<User>) request.getAttribute("customers");
                                    if (customers != null) {
                                        for (User customer : customers) {
                                %>
                                <tr>
                                    <td><%= customer.getUserId() %></td>
                                    <td><%= customer.getUsername() %></td>
                                    <td><%= customer.getEmail() %></td>
                                    <td><%= customer.getFullname() %></td>
                                    <td><%= customer.getAddress() %></td>
                                    <td><%= customer.getPhone() %></td>
                                    <td><%= customer.getRole() %></td>
                                    <td>
                                        <form action="ManageCustomerServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="userId" value="<%= customer.getUserId() %>">
                                            <button type="submit" class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                        </form>
                                        <button class="btn btn-warning update-button" 
                                                data-id="<%= customer.getUserId() %>" 
                                                data-username="<%= customer.getUsername() %>" 
                                                data-email="<%= customer.getEmail() %>" 
                                                data-fullname="<%= customer.getFullname() %>" 
                                                data-address="<%= customer.getAddress() %>" 
                                                data-phone="<%= customer.getPhone() %>" 
                                                data-role="<%= customer.getRole() %>">
                                            Update
                                        </button>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="8">No customers found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Customer Modal -->
        <div class="modal fade" id="updateCustomerModal" tabindex="-1" role="dialog" aria-labelledby="updateCustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateCustomerModalLabel">Update Customer</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="ManageCustomerServlet" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="updateUserId" name="userId">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="updateUsername">Username:</label>
                                <input type="text" class="form-control" id="updateUsername" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="updateEmail">Email:</label>
                                <input type="email" class="form-control" id="updateEmail" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="updateFullname">Full Name:</label>
                                <input type="text" class="form-control" id="updateFullname" name="fullname" required>
                            </div>
                            <div class="form-group">
                                <label for="updateAddress">Address:</label>
                                <input type="text" class="form-control" id="updateAddress" name="address" required>
                            </div>
                            <div class="form-group">
                                <label for="updatePhone">Phone:</label>
                                <input type="text" class="form-control" id="updatePhone" name="phone" required>
                            </div>
                            <div class="form-group">
                                <label for="updateRole">Role:</label>
                                <select class="form-control" id="updateRole" name="role" required>
                                    <option value="customer">Customer</option>
                                    <option value="admin">Admin</option>
                                    <option value="staff">Staff</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Update Customer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".update-button").forEach(button => {
                    button.addEventListener("click", function () {
                        document.getElementById("updateUserId").value = this.getAttribute("data-id");
                        document.getElementById("updateUsername").value = this.getAttribute("data-username");
                        document.getElementById("updateEmail").value = this.getAttribute("data-email");
                        document.getElementById("updateFullname").value = this.getAttribute("data-fullname");
                        document.getElementById("updateAddress").value = this.getAttribute("data-address");
                        document.getElementById("updatePhone").value = this.getAttribute("data-phone");
                        document.getElementById("updateRole").value = this.getAttribute("data-role");
                        $('#updateCustomerModal').modal('show');
                    });
                });
            });
        </script>

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