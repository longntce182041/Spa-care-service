<%@ page import="java.sql.*, java.util.*, DAO.ProductDAO, Model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->

<div class="container">
    <h1 class="text-center my-4">Shop</h1>
    <div class="row">
        <%
            ProductDAO productDAO = new ProductDAO();
            List<Product> productList = productDAO.getAllProducts();
            for (Product product : productList) {
        %>
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <img src="<%= product.getimage_url() %>" class="card-img-top" alt="<%= product.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-text"><strong>Price: $<%= product.getPrice() %></strong></p>
                    <p class="card-text">Stock: <%= product.getStockQuantity() %></p>
                    <a href="ProductDetail.jsp?productId=<%= product.getProductId() %>" class="btn btn-primary">View Details</a>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<jsp:include page="footer.jsp" />