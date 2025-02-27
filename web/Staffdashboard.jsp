<%@ page import="java.sql.*, java.util.*, DAO.InventoryDAO, Model.Inventory" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
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
            <a href="add_inventory.jsp" class="btn btn-green">Stock Receiving</a> <!-- Liên kết đến trang nhập hàng -->
            <a href="remove_inventory.jsp" class="btn btn-green">Stock Delivering</a> <!-- Liên kết đến trang xuất hàng -->
        </div>
        <table class="inventory-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Sản phẩm</th>
                    <th>Loại</th>
                    <th>Số lượng</th>
                    <th>Hình ảnh</th>
                </tr>
            </thead>
            <tbody>
                <%
                    InventoryDAO dao = new InventoryDAO();
                    List<Inventory> inventoryList = dao.getAllInventory();
                    for (Inventory item : inventoryList) {
                %>
                    <tr>
                        <td><%= item.getInventoryId() %></td>
                        <td><%= item.getProductId() %></td>
                        <td><%= item.getType() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td><img src="<%= item.getimage_url() %>" alt="Product Image"></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
            <a href="index.jsp" class="btn btn-green">Back to home page</a>
    </div>
</body>
</html>