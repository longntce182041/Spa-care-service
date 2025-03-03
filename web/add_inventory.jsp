<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stock Receiving</title>
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
        <h2>Stock Receiving</h2>
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error-message"><%= error %></div>
        <%
            }
        %>
        <form action="AddInventoryServlet" method="post" class="form-container">
            <label for="productId">Product ID:</label>
            <input type="text" id="productId" name="productId" required><br>
            <label for="staffId">Staff ID:</label>
            <input type="text" id="staffId" name="staffId" required><br>
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required><br>
            <label for="type">Type:</label>
            <input type="text" id="type" name="type" required><br>
            <label for="image_url">Images URL:</label>
            <input type="text" id="image_url" name="image_url" required><br>
            <button type="submit" class="btn btn-primary">Import</button>
            <a href="Staffdashboard.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>