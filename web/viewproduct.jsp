<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>

<html>
<head>
    <title>List Products</title>
    <link rel="stylesheet" href="css/Style_manageProduct.css">
</head>
<body>

    <div class="container">
        <h2>List Products</h2>

        <% List<Product> products = (List<Product>) request.getAttribute("products"); %>

        <table>
            <tr>
                <th>Images</th>
                <th>Products Name</th>
                <th>Price</th>
                <th>Inventory</th>
                <th>Detail</th>
            </tr>
            <% for (Product product : products) { %>
            <tr>
                <td><img src="<%= product.getImageUrl() %>"></td>
                <td><%= product.getName() %></td>
                <td><%= product.getPrice() %> VND</td>
                <td><%= product.getStockQuantity() %></td>
                <td>
                    <button class="detail-button" 
                        data-name="<%= product.getName() %>" 
                        data-description="<%= product.getDescription() %>" 
                        data-price="<%= product.getPrice() %> VND"
                        data-stock="<%= product.getStockQuantity() %>"
                        data-image="<%= product.getImageUrl() %>">
                        View detail
                    </button>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- Modal popup -->
    <div id="productModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modalTitle"></h2>
            <img id="modalImage">
            <p><strong>Describe:</strong> <span id="modalDescription"></span></p>
            <p><strong>Price:</strong> <span id="modalPrice"></span></p>
            <p><strong>Inventory:</strong> <span id="modalStock"></span></p>
        </div>
    </div>
    
    <script src="js/ProductsDetail.js" ></script>
</body>
</html>
