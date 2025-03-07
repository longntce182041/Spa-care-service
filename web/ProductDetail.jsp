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
    <h1 class="text-center my-4"><%= product.getName()%></h1>
    <div class="row">
        <div class="col-md-6">
            <img src="<%= product.getimage_url()%>" class="img-fluid" alt="<%= product.getName()%>">
        </div>
        <div class="col-md-6">
            <h2>$<%= product.getPrice()%></h2>
            <p><%= product.getDescription()%></p>
            <p>Stock: <%= product.getStockQuantity()%></p>
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStockQuantity()%>">
            </div>
            <button type="button" class="btn btn-primary add-to-cart" data-product-id="<%= product.getProductId()%>">Add to Cart</button>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
    $(document).ready(function () {
        $('.add-to-cart').click(function () {
            var productId = $(this).data('product-id');
            var quantity = $('#quantity').val();
            var maxQuantity = $('#quantity').attr('max');

            if (parseInt(quantity) > parseInt(maxQuantity)) {
                alert('The quantity of products has exceeded the allowed limit.');
                return;
            }

            $.ajax({
                url: 'AddToCartServlet',
                type: 'POST',
                data: {productId: productId, quantity: quantity},
                success: function (response) {
                    // Cập nhật số lượng sản phẩm trong giỏ hàng trên thanh navbar
                    $('#cart-count').text(response.cartCount);
                },
                error: function (xhr, status, error) {
                    console.error('Failed to add product to cart.');
                }
            });
        });
    });
</script>