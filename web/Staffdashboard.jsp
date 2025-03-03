<%@ page import="java.sql.*, java.util.*, DAO.InventoryDAO, Model.Inventory" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Staff Warehouse Dashboard</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">
        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/staffdashboard.css"> <!-- Liên kết tệp CSS mới -->
    </head>
    <body>
        <div class="container">
            <h2>Staff Warehouse Dashboard</h2>
            <div class="actions">
                <a href="add_inventory.jsp" class="btn btn-primary">Stock Receiving</a> <!-- Liên kết đến trang nhập hàng -->
                <a href="remove_inventory.jsp" class="btn btn-primary">Stock Delivering</a> <!-- Liên kết đến trang xuất hàng -->
            </div>
            <table class="inventory-table table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Product ID</th>
                        <th>Type</th>
                        <th>Quantity</th>
                        <th>Images</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        InventoryDAO dao = new InventoryDAO();
                        List<Inventory> inventoryList = dao.getAllInventory();
                        for (Inventory item : inventoryList) {
                    %>
                    <tr>
                        <td><%= item.getInventoryId()%></td>
                        <td><%= item.getProductId()%></td>
                        <td><%= item.getType()%></td>
                        <td><%= item.getQuantity()%></td>
                        <td><img src="<%= item.getimage_url()%>" alt="Product Image" style="width: 100px; height: auto;"></td>
                        <td>
                            <a href="edit_inventory.jsp?inventoryId=<%= item.getInventoryId()%>" class="btn btn-primary">Edit</a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
            <a href="index.jsp" class="btn btn-primary">Back to home page</a>
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