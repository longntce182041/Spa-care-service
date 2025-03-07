<%@ page import="java.sql.*, java.util.*, DAO.InventoryDAO, Model.Inventory" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    int inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
    InventoryDAO dao = new InventoryDAO();
    Inventory inventory = null;
    for (Inventory item : dao.getAllInventory()) {
        if (item.getInventoryId() == inventoryId) {
            inventory = item;
            break;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Edit Inventory</title>
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
        <link rel="stylesheet" href="css/staffwarehouse.css">
        
    </head>
    <body>
        <div class="container">
            <h2>Edit Inventory</h2>
            <form action="UpdateInventoryServlet" method="post">
                <input type="hidden" name="inventoryId" value="<%= inventory.getInventoryId()%>">
                <div class="form-group">
                    <label for="productId">Product ID:</label>
                    <input type="text" class="form-control" id="productId" name="productId" value="<%= inventory.getProductId()%>" readonly>
                </div>
                <div class="form-group">
                    <label for="staffId">Staff ID:</label>
                    <input type="text" class="form-control" id="staffId" name="staffId" value="<%= inventory.getStaffId()%>" readonly>
                </div>
                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="text" class="form-control" id="quantity" name="quantity" value="<%= inventory.getQuantity()%>" required>
                </div>
                <div class="form-group">
                    <label for="type">Type:</label>
                    <input type="text" class="form-control" id="type" name="type" value="<%= inventory.getType()%>" required>
                </div>
                <div class="form-group">
                    <label for="image_url">Image URL:</label>
                    <input type="text" class="form-control" id="image_url" name="image_url" value="<%= inventory.getimage_url()%>" required>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
                <a href="StaffWarehouse.jsp" class="btn btn-secondary">Cancel</a>
            </form>
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