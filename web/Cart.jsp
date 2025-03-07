<%@ page import="java.util.*, Model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->

<%
    // Không cần khai báo lại biến session
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }
%>

<div class="container">
    <h1 class="text-center my-4">Shopping Cart</h1>
    <div id="cart-alert" class="alert alert-danger text-center" style="display: none;">Your cart is empty!</div>
    <table class="table">
        <thead>
            <tr>
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
                double total = 0;
                for (CartItem item : cart) {
                    double itemTotal = item.getProduct().getPrice() * item.getQuantity();
                    total += itemTotal;
            %>
            <tr>
                <td><%= item.getProduct().getName() %></td>
                <td><img src="<%= item.getProduct().getimage_url() %>" alt="<%= item.getProduct().getName() %>" style="width: 100px; height: auto;"></td>
                <td>$<%= item.getProduct().getPrice() %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= itemTotal %></td>
                <td>
                    <form action="RemoveFromCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= item.getProduct().getProductId() %>">
                        <button type="submit" class="btn btn-danger">Remove</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
            <tr>
                <td colspan="4" class="text-right"><strong>Total:</strong></td>
                <td colspan="2"><strong>$<%= total %></strong></td>
            </tr>
        </tbody>
    </table>
    <button id="checkout-button" class="btn btn-success">Proceed to Checkout</button>
</div>

<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
    $(document).ready(function() {
        $('#checkout-button').click(function() {
            var cartSize = <%= cart.size() %>;
            if (cartSize === 0) {
                $('#cart-alert').show();
            } else {
                window.location.href = 'Checkout.jsp';
            }
        });
    });
</script>