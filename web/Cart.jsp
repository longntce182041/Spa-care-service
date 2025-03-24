<%@ page import="java.util.*, Model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    // Tính tổng tiền của toàn bộ giỏ hàng
    double totalCartValue = 0;
    for (CartItem item : cart) {
        totalCartValue += item.getProduct().getPrice() * item.getQuantity();
    }
%>

<div class="container mt-5">
    <h1 class="text-center my-4">Shopping Cart</h1>
    <div id="cart-alert" class="alert alert-danger text-center" style="display: none;">Your cart is empty!</div>
    <form id="cart-form" action="Checkout.jsp" method="post">
        <table class="table table-hover" id="cart-table">
            <thead class="thead-light">
                <tr>
                    <th>Select</th>
                    <th>Product</th>
                    <th>Image</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (CartItem item : cart) {
                        double itemTotal = item.getProduct().getPrice() * item.getQuantity();
                %>
                <tr class="product-row" data-product-id="<%= item.getProduct().getProductId() %>" data-product-price="<%= item.getProduct().getPrice() %>" data-product-quantity="<%= item.getQuantity() %>">
                    <td class="text-center">
                        <input type="checkbox" name="selectedProducts" value="<%= item.getProduct().getProductId() %>" class="product-checkbox">
                    </td>
                    <td><%= item.getProduct().getName() %></td>
                    <td>
                        <img src="<%= item.getProduct().getimage_url() %>" alt="<%= item.getProduct().getName() %>" class="img-thumbnail" style="width: 100px; height: auto;">
                    </td>
                    <td>$<%= item.getProduct().getPrice() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td class="product-total">$<%= itemTotal %></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-remove" data-product-id="<%= item.getProduct().getProductId() %>">
                            <i class="fas fa-trash-alt"></i> Remove
                        </button>
                    </td>
                </tr>
                <%
                    }
                %>
                <tr id="total-row">
                    <td colspan="5" class="text-right"><strong>Total:</strong></td>
                    <td colspan="2"><strong id="cart-total">$<%= String.format("%.2f", totalCartValue) %></strong></td>
                </tr>
            </tbody>
        </table>
        <div class="text-right">
            <button id="checkout-button" class="btn btn-success"><i class="fas fa-credit-card"></i> Proceed to Checkout</button>
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        // Cập nhật tổng tiền
        function updateTotal() {
            let total = 0;
            $('.product-row').each(function() {
                const price = parseFloat($(this).data('product-price'));
                const quantity = parseInt($(this).data('product-quantity'));
                total += price * quantity;
            });

            // Hiển thị tổng tiền
            $('#cart-total').text(`$${total.toFixed(2)}`);
        }

        // Cập nhật số lượng sản phẩm trên biểu tượng giỏ hàng
        function updateCartCount() {
            const cartCount = $('.product-row').length;
            $('#cart-count').text(cartCount); // Giả sử #cart-count là phần tử hiển thị số lượng sản phẩm
        }

        // Xóa một sản phẩm
        $('.btn-remove').click(function() {
            const productId = $(this).data('product-id');
            const row = $(this).closest('.product-row');

            // Gửi yêu cầu xóa sản phẩm đến server (AJAX giả lập)
            $.ajax({
                url: 'RemoveFromCartServlet',
                type: 'POST',
                data: { productId: productId },
                success: function(response) {
                    // Xóa sản phẩm khỏi giao diện
                    row.remove();

                    // Cập nhật tổng tiền
                    updateTotal();

                    // Cập nhật số lượng sản phẩm trên biểu tượng giỏ hàng
                    updateCartCount();
                },
                error: function() {
                    alert('Failed to remove product. Please try again.');
                }
            });
        });

        // Kiểm tra trước khi thanh toán
        $('#checkout-button').click(function(event) {
            event.preventDefault();

            // Kiểm tra nếu giỏ hàng trống
            if ($('.product-row').length === 0) {
                alert('Your cart is empty!');
                return;
            }

            // Nếu không có sản phẩm nào được chọn, mặc định chọn tất cả sản phẩm
            if ($('.product-checkbox:checked').length === 0) {
                $('.product-checkbox').prop('checked', true).trigger('change');
            }

            // Gửi form
            $('#cart-form').submit();
        });

        // Cập nhật tổng tiền và số lượng sản phẩm ban đầu
        updateTotal();
        updateCartCount();
    });
</script>