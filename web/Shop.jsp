<%@ page import="java.sql.*, java.util.*, DAO.ProductDAO, Model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->

<div class="container mt-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Shop</li>
        </ol>
    </nav>

    <h1 class="text-center my-4">Shop</h1>
    <div class="row">
        <div class="col-md-3">
            <h4>Categories</h4>
            <select id="category-select" class="form-select">
                <option value="">All Categories</option>
                <%
                    ProductDAO productDAO = new ProductDAO();
                    List<String> categories = productDAO.getAllCategories();
                    for (String category : categories) {
                %>
                <option value="<%= category%>"><%= category%></option>
                <%
                    }
                %>
            </select>
            <h4 class="mt-4">Search</h4>
            <input type="text" id="search-input" class="form-control" placeholder="Search for products...">
        </div>
        <div class="col-md-9">
            <div class="row" id="product-list">
                <%
                    List<Product> productList = productDAO.getAllProducts();
                    for (Product product : productList) {
                %>
                <div class="col-md-4 d-flex align-items-stretch">
                    <div class="card mb-4 shadow-sm product-card" data-product-id="<%= product.getProductId()%>">
                        <img src="<%= product.getimage_url()%>" class="card-img-top" alt="<%= product.getName()%>">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%= product.getName()%></h5>
                            <p class="card-text"><%= product.getDescription()%></p>
                            <p class="card-text"><strong>Price: <%= String.format("%,.0f VNĐ", product.getPrice()) %></strong></p>
                            <% if (product.getStockQuantity() == 0) { %>
                            <span class="badge badge-danger">Sold Out</span>
                            <% } else { %>
                            <a href="javascript:void(0);" class="btn btn-outline-success add-to-cart mt-auto" data-product-id="<%= product.getProductId()%>"><i class="fa fa-shopping-cart"></i> Add to Cart</a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        function bindEvents() {
            $('.add-to-cart').off('click').on('click', function (event) {
                event.stopPropagation(); // Ngăn chặn sự kiện click trên thẻ sản phẩm
                var productId = $(this).data('product-id');
                var quantity = 1; // Mặc định số lượng là 1 khi thêm vào giỏ hàng từ Shop.jsp
                $.ajax({
                    url: 'AddToCartServlet',
                    type: 'POST',
                    data: {productId: productId, quantity: quantity},
                    success: function (response) {
                        // Cập nhật số lượng sản phẩm trong giỏ hàng trên thanh navbar
                        $('#cart-count').text(response.cartCount);

                        // Hiển thị thông báo
                        alert('Product added to cart successfully!');
                    },
                    error: function (xhr, status, error) {
                        console.error('Failed to add product to cart.');
                    }
                });
            });

            $('.product-card').off('click').on('click', function () {
                var productId = $(this).data('product-id');
                window.location.href = 'ProductDetail.jsp?productId=' + productId;
            });
        }

        bindEvents();

        $('#category-select').change(function () {
            var category = $(this).val();
            $.ajax({
                url: 'FilterProductsServlet',
                type: 'GET',
                data: {category: category},
                success: function (response) {
                    $('#product-list').html(response);
                    bindEvents(); // Gán lại các sự kiện sau khi cập nhật danh sách sản phẩm
                },
                error: function (xhr, status, error) {
                    console.error('Failed to filter products.');
                }
            });
        });

        $('#search-input').on('input', function () {
            var query = $(this).val();
            $.ajax({
                url: 'SearchProductsServlet',
                type: 'GET',
                data: {query: query},
                success: function (response) {
                    $('#product-list').html(response);
                    bindEvents(); // Gán lại các sự kiện sau khi cập nhật danh sách sản phẩm
                },
                error: function (xhr, status, error) {
                    console.error('Failed to search products.');
                }
            });
        });

        console.log(`Price: ${price.toLocaleString('vi-VN')} VNĐ`);
    });
</script>