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
            <li class="breadcrumb-item active" aria-current="page"><%= product.getName()%></li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-6">
            <img src="<%= product.getimage_url()%>" class="img-fluid rounded" alt="<%= product.getName()%>">
        </div>
        <div class="col-md-6">
            <h2 class="my-3"><%= product.getName()%></h2>
            <h4 class="text-success">$<%= product.getPrice()%></h4> <!-- Chỉnh màu giá tiền thành xanh lục -->
            <p><%= product.getDescription()%></p>
            <p><%= product.getDescription_detail()%></p>
            <p>Stock: <%= product.getStockQuantity()%></p>
            <% if (product.getStockQuantity() == 0) { %>
            <span class="badge badge-danger">Sold Out</span>
            <% } else {%>
            <div class="form-group d-flex align-items-center">
                <label for="quantity" class="mr-2">Quantity:</label>
                <input 
                    type="number" 
                    class="form-control quantity-input" 
                    id="quantity" 
                    name="quantity" 
                    value="1" 
                    min="1" 
                    max="<%= product.getStockQuantity()%>" 
                    step="1"
                    >
                <button type="button" class="btn btn-success add-to-cart ml-3" data-product-id="<%= product.getProductId()%>">
                    <i class="fas fa-shopping-cart"></i> add to cart
                </button>
            </div>
            <% } %>
        </div>
    </div>

    <h2 class="text-center my-5">Similar Products</h2>
    <div class="row">
        <% int count = 0; %>
        <% for (Product similarProduct : similarProducts) { %>
        <% if (count < 4) {%>
        <div class="col-md-3 d-flex align-items-stretch">
            <div class="card mb-4 shadow-sm product-card" data-product-id="<%= similarProduct.getProductId()%>">
                <img src="<%= similarProduct.getimage_url()%>" class="card-img-top" alt="<%= similarProduct.getName()%>">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= similarProduct.getName()%></h5>
                    <p class="card-text"><%= similarProduct.getDescription()%></p>
                    <p class="card-text"><strong>Price: $<%= similarProduct.getPrice()%></strong></p> <!-- Chỉnh màu giá tiền thành xanh lục -->
                    <% if (similarProduct.getStockQuantity() == 0) { %>
                    <span class="badge badge-danger">Sold Out</span>
                    <% } %>
                </div>
            </div>
        </div>
        <% count++; %>
        <% } %>
        <% }%>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('.add-to-cart').click(function () {
            var productId = $(this).data('product-id');
            var quantity = $('#quantity').val();
            var maxQuantity = $('#quantity').attr('max');

            if (quantity < 1 || !$.isNumeric(quantity) || parseInt(quantity) > parseInt(maxQuantity)) {
                alert('Please enter a valid quantity between 1 and ' + maxQuantity + '.');
                return;
            }

            $.ajax({
                url: 'AddToCartServlet',
                type: 'POST',
                data: {productId: productId, quantity: quantity},
                success: function (response) {
                    // Cập nhật số lượng sản phẩm trong giỏ hàng trên thanh navbar
                    $('#cart-count').text(response.cartCount);

                    // Đặt lại giá trị của ô nhập số lượng về 0
                    $('#quantity').val(0);
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