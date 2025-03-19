<!-- filepath: /Users/tranphantrungkien/Ky5/SWP391/PetiqueSpa/web/ProductDetail.jsp -->
<%@ page import="java.sql.*, java.util.*, DAO.ProductDAO, Model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->

<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDAO productDAO = new ProductDAO();
    Product product = productDAO.getProductById(productId);
    List<Product> similarProducts = productDAO.getSimilarProducts(productId);
%>

<div class="container mt-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="Shop.jsp">Shop</a></li>
            <li class="breadcrumb-item active" aria-current="page"><%= product.getName() %></li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-6">
            <img src="<%= product.getimage_url() %>" class="img-fluid rounded" alt="<%= product.getName() %>">
        </div>
        <div class="col-md-6">
            <h2 class="my-3"><%= product.getName() %></h2>
            <h4 class="text-primary">$<%= product.getPrice() %></h4>
            <p><%= product.getDescription() %></p>
            <p><%= product.getDescription_detail() %></p>
            <p>Stock: <%= product.getStockQuantity() %></p>
            <% if (product.getStockQuantity() == 0) { %>
                <span class="badge badge-danger">Sold Out</span>
            <% } else { %>
                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStockQuantity() %>">
                </div>
                <button type="button" class="btn btn-primary add-to-cart" data-product-id="<%= product.getProductId() %>">
                    <i class="fas fa-shopping-cart"></i> Add to Cart
                </button>
            <% } %>
        </div>
    </div>

    <h2 class="text-center my-5">Similar Products</h2>
    <div class="row">
        <% int count = 0; %>
        <% for (Product similarProduct : similarProducts) { %>
            <% if (count < 4) { %>
                <div class="col-md-3">
                    <div class="card mb-4 shadow-sm product-card" data-product-id="<%= similarProduct.getProductId() %>">
                        <img src="<%= similarProduct.getimage_url() %>" class="card-img-top" alt="<%= similarProduct.getName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= similarProduct.getName() %></h5>
                            <p class="card-text"><%= similarProduct.getDescription() %></p>
                            <p class="card-text"><strong>Price: $<%= similarProduct.getPrice() %></strong></p>
                            <% if (similarProduct.getStockQuantity() == 0) { %>
                                <span class="badge badge-danger">Sold Out</span>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% count++; %>
            <% } %>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        // Kiểm tra giá trị nhập vào trường số lượng
        $('#quantity').on('input', function () {
            var value = $(this).val();
            if (value < 1 || !$.isNumeric(value)) {
                $(this).val(1);
            }
        });

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
        $('.product-card').click(function () {
            var productId = $(this).data('product-id');
            window.location.href = 'ProductDetail.jsp?productId=' + productId;
        });
    });
</script>