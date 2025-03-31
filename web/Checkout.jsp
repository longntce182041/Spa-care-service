<%@ page import="java.util.*, Model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/Checkout.css"> <!-- Liên kết tệp CSS mới -->

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("Shop.jsp");
        return;
    }

    // Lấy danh sách sản phẩm được chọn
    String[] selectedProductIds = request.getParameterValues("selectedProducts");
    if (selectedProductIds == null || selectedProductIds.length == 0) {
        response.sendRedirect("Cart.jsp");
        return;
    }

    // Lọc các sản phẩm được chọn từ giỏ hàng
    List<CartItem> selectedCartItems = new ArrayList<>();
    for (CartItem item : cart) {
        for (String productId : selectedProductIds) {
            if (item.getProduct().getProductId() == Integer.parseInt(productId)) {
                selectedCartItems.add(item);
            }
        }
    }
%>

<div class="checkout-container">
    <h1 class="text-center my-4">Checkout</h1>
    <div class="row">
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Billing Address</h4>
            <form action="CheckoutServlet" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="name">Full Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="phone">Phone Number</label>
                        <input type="text" class="form-control" id="phone" name="phone" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="address">Address</label>
                    <input type="text" class="form-control" id="address" name="address" required>
                </div>
                <div class="mb-3">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <h4 class="mb-3">Payment</h4>
                <div class="d-block my-3">
                    <div class="custom-control custom-radio">
                        <input id="cod" name="paymentMethod" type="radio" class="custom-control-input" value="COD" required>
                        <label class="custom-control-label" for="cod">Cash on Delivery (COD)</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="qr" name="paymentMethod" type="radio" class="custom-control-input" value="QR" required>
                        <label class="custom-control-label" for="qr">QR Code/Banking</label>
                    </div>
                </div>
                <div id="qr-code-container" style="display: none;">
                    <h4 class="mb-3">Scan this QR code to pay with MOMO</h4>
                    <img id="qr-code" src="images/QRcode.jpg" alt="MOMO QR Code">
                </div>
                <!-- Gửi danh sách sản phẩm được chọn -->
                <%
                    for (CartItem item : selectedCartItems) {
                %>
                <input type="hidden" name="selectedProducts" value="<%= item.getProduct().getProductId() %>">
                <%
                    }
                %>
                <button class="btn btn-primary btn-lg btn-block" type="submit">Place Order</button>
            </form>
        </div>
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your cart</span>
                <span class="badge badge-secondary badge-pill"><%= selectedCartItems.size() %></span>
            </h4>
            <ul class="list-group mb-3">
                <%
                    double total = 0;
                    for (CartItem item : selectedCartItems) {
                        double itemTotal = item.getProduct().getPrice() * item.getQuantity();
                        total += itemTotal;
                %>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0"><%= item.getProduct().getName() %></h6>
                        <small class="text-muted">Quantity: <%= item.getQuantity() %></small>
                    </div>
                    <!-- Hiển thị giá tiền theo định dạng VNĐ -->
                    <span class="text-muted"><%= String.format("%,.0f VNĐ", itemTotal) %></span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <img src="<%= item.getProduct().getimage_url() %>" alt="<%= item.getProduct().getName() %>" style="width: 100px; height: auto;">
                </li>
                <%
                    }
                %>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (VNĐ)</span>
                    <!-- Hiển thị tổng tiền theo định dạng VNĐ -->
                    <strong><%= String.format("%,.0f VNĐ", total) %></strong>
                </li>
            </ul>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
    $(document).ready(function () {
        $('input[name="paymentMethod"]').change(function () {
            if ($(this).val() === 'QR') {
                $('#qr-code-container').show();
            } else {
                $('#qr-code-container').hide();
            }
        });

        // Validate form inputs
        $('form').on('submit', function (e) {
            const name = $('#name').val().trim();
            const phone = $('#phone').val().trim();
            const address = $('#address').val().trim();
            const email = $('#email').val().trim();

            // Regex for full name (cho phép chữ cái có dấu và dấu cách)
            const nameRegex = /^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s]+$/;

            // Regex for phone number (mã vùng Việt Nam: +84 hoặc 0, theo sau là 9-10 chữ số)
            const phoneRegex = /^(?:\+84|0)(?:[3|5|7|8|9])\d{8}$/;

            // Regex for email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Validate Full Name
            if (!nameRegex.test(name) || name.length < 3 || name.length > 50) {
                alert('Full Name is required, must be between 3 and 50 characters, and can only contain letters, spaces, and Vietnamese diacritics.');
                e.preventDefault();
                return;
            }

            // Validate Phone Number
            if (!phoneRegex.test(phone)) {
                alert('Phone Number must start with +84 or 0, followed by 9-10 digits, and match Vietnamese phone number formats.');
                e.preventDefault();
                return;
            }

            // Validate Address
            if (address === '' || address.length < 5 || address.length > 100) {
                alert('Address is required and must be between 5 and 100 characters.');
                e.preventDefault();
                return;
            }

            // Validate Email
            if (!emailRegex.test(email)) {
                alert('Invalid Email format.');
                e.preventDefault();
                return;
            }
        });
    });
</script>