<!-- filepath: /Users/tranphantrungkien/Ky5/SWP391/PetiqueSpa/web/OrderManagement.jsp -->
<%@ page import="java.util.*, DAO.OrderDAO, Model.Order" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
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
</head>
<body>
    <div class="container">
        <h1 class="text-center my-4">Order Management</h1>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="orderTableBody">
                        <%
                            OrderDAO orderDAO = new OrderDAO();
                            List<Order> orderList = orderDAO.getAllOrders();
                            for (Order order : orderList) {
                        %>
                        <tr id="orderRow<%= order.getOrderId() %>">
                            <td><%= order.getOrderId()%></td>
                            <td><%= order.getOrderDate()%></td>
                            <td>$<%= order.getTotalPrice()%></td>
                            
                            <td><%= order.getName() %></td>
                            <td><%= order.getPhone() %></td>
                            <td><%= order.getEmail() %></td>
                            <td id="orderStatus<%= order.getOrderId() %>"><%= order.getStatus()%></td>
                            <td>
                                <button class="btn btn-success mt-2" onclick="updateOrderStatus(<%= order.getOrderId() %>, 'Confirmed')">Confirm</button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
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
        function updateOrderStatus(orderId, status) {
            $.ajax({
                url: 'UpdateOrderStatusServlet',
                method: 'POST',
                data: {
                    orderId: orderId,
                    status: status
                },
                success: function(response) {
                    $('#orderStatus' + orderId).text(status);
                },
                error: function() {
                    alert('Error updating order status.');
                }
            });
        }
    </script>
</body>
</html>