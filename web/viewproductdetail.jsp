<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="Controller.Product" %>
<html>
<head>
    <title>Products Detail</title>
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

    <div class="container">
        <h2>Products Detail</h2>

        <% Product product = (Product) request.getAttribute("product"); %>

        <img src="<%= product.getImageUrl() %>" width="200">
        <h3><%= product.getName() %></h3>
        <p><strong>Describe:</strong> <%= product.getDescription() %></p>
        <p><strong>Price:</strong> <%= product.getPrice() %> VND</p>
        <p><strong>Inventory:</strong> <%= product.getStockQuantity() %></p>

        <a href="ViewProductServlet" class="back-button">Quay lại danh sách</a>
    </div>

</body>
</html>
