<%@ page import="java.sql.*, java.util.*, DAO.ProductDAO, Model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->

<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDAO productDAO = new ProductDAO();
    Product product = productDAO.getProductById(productId);
%>

<div class="container">
    <h1 class="text-center my-4"><%= product.getName() %></h1>
    <div class="row">
        <div class="col-md-6">
            <img src="<%= product.getimage_url() %>" class="img-fluid" alt="<%= product.getName() %>">
        </div>
        <div class="col-md-6">
            <h2>$<%= product.getPrice() %></h2>
            <p><%= product.getDescription() %></p>
            <p>Stock: <%= product.getStockQuantity() %></p>
            <form action="AddToCartServlet" method="post">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStockQuantity() %>">
                </div>
                <button type="submit" class="btn btn-primary">Add to Cart</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />