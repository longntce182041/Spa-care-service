<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="Model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            width: 50%;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            max-width: 300px;
            height: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            margin: 10px 0;
        }

        .product-detail {
            margin-top: 20px;
        }

        .product-detail h2 {
            margin-bottom: 20px;
        }

        .product-detail p {
            font-size: 1.1em;
            margin-bottom: 10px;
        }

        h2 {
            color: #28a745;
        }

        img {
            max-width: 100%;
            border-radius: 10px;
            margin: 20px 0;
        }

        p {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }

        strong {
            color: #28a745;
        }

        .back-button {
            display: inline-block;
            text-decoration: none;
            color: white;
            background-color: #28a745;
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: bold;
            transition: 0.3s;
            margin-top: 20px;
        }

        .back-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="container product-detail">
        <h2>Product Detail</h2>
        <div class="row">
            <div class="col-md-4">
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" class="product-image img-fluid">
            </div>
            <div class="col-md-8">
                <h3><%= product.getName() %></h3>
                <p><strong>Description:</strong> <%= product.getDescription() %></p>
                <p><strong>Price:</strong> <%= product.getPrice() %> VND</p>
                <p><strong>Stock Quantity:</strong> <%= product.getStockQuantity() %></p>
                <p><strong>Category:</strong> <%= product.getCategoryId() %></p>
            </div>
        </div>
        <a href="ViewProductServlet" class="back-button">Quay lại danh sách</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
