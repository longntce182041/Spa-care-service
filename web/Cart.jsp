<%@ page import="java.util.*, Model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->
<link rel="stylesheet" href="./css/toast.css">
<%@include file="popUpMessage.jsp" %>

<%
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);

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
                <tr class="product-row" 
                    data-product-id="<%= item.getProduct().getProductId() %>" 
                    data-product-price="<%= item.getProduct().getPrice() %>" 
                    data-product-quantity="<%= item.getQuantity() %>">
                    <td class="text-center">
                        <input type="checkbox" name="selectedProducts" value="<%= item.getProduct().getProductId() %>" class="product-checkbox">
                    </td>
                    <td><%= item.getProduct().getName() %></td>
                    <td>
                        <img src="<%= item.getProduct().getimage_url() %>" alt="<%= item.getProduct().getName() %>" class="img-thumbnail" style="width: 100px; height: auto;">
                    </td>
                    <td><%= currencyVN.format(item.getProduct().getPrice()) %></td>
                    <td><%= item.getQuantity() %></td>
                    <td class="product-total"><%= currencyVN.format(itemTotal) %></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-remove" data-product-id="<%= item.getProduct().getProductId() %>">
                            <i class="fas fa-trash-alt"></i> Remove
                        </button>
                    </td>
                </tr>
                <%
                    }
                %>
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

                // Kiểm tra giá trị hợp lệ
                if (!isNaN(price) && !isNaN(quantity)) {
                    total += price * quantity;
                }
            });

            // Hiển thị tổng tiền với định dạng VNĐ
            $('#cart-total').text(`${total.toLocaleString('vi-VN')} VNĐ`);
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

            // Gửi yêu cầu xóa sản phẩm đến server
            $.ajax({
                url: 'RemoveFromCartServlet',
                type: 'POST',
                data: { productId: productId },
                success: function(response) {
                    if (response.success) {
                        // Xóa sản phẩm khỏi giao diện
                        row.remove();

                        // Cập nhật tổng tiền
                        updateTotal();

                        // Cập nhật số lượng sản phẩm trên biểu tượng giỏ hàng
                        updateCartCount();

                        // Hiển thị thông báo thành công
                        showSuccessToast('Product removed from cart successfully!');
                    } else {
                        // Hiển thị thông báo lỗi
                        showErrorToast('Failed to remove product from cart.');
                    }
                },
                error: function() {
                    // Hiển thị thông báo lỗi nếu xảy ra lỗi kết nối
                    showErrorToast('Failed to connect to the server. Please try again.');
                }
            });
        });

        // Kiểm tra trước khi thanh toán
        $('#checkout-button').click(function(event) {
            event.preventDefault();

            // Kiểm tra nếu giỏ hàng trống
            if ($('.product-row').length === 0) {
                showErrorToast('Your cart is empty!');
                return;
            }

            // Nếu không có sản phẩm nào được chọn, mặc định chọn tất cả sản phẩm
            if ($('.product-checkbox:checked').length === 0) {
                $('.product-checkbox').prop('checked', true).trigger('change');
            }

            // Hiển thị thông báo thành công trước khi chuyển đến trang Checkout
            showSuccessToast('Proceeding to checkout...');
            setTimeout(function() {
                // Gửi form sau khi hiển thị thông báo
                $('#cart-form').submit();
            }, 1500); // Đợi 1.5 giây để hiển thị toast trước khi chuyển trang
        });

        // Cập nhật tổng tiền và số lượng sản phẩm ban đầu
        updateTotal();
        updateCartCount();
        updateTotal(); // Cập nhật tổng tiền khi trang tải xong

        // Cập nhật số lượng sản phẩm khi thay đổi
        $('.product-quantity').on('change', function() {
            const row = $(this).closest('.product-row');
            const newQuantity = parseInt($(this).val()) || 0;

            // Cập nhật thuộc tính data-product-quantity
            row.data('product-quantity', newQuantity);

            // Cập nhật tổng tiền
            updateTotal();
        });

        updateTotal(); // Cập nhật tổng tiền khi trang tải xong
    });
</script>