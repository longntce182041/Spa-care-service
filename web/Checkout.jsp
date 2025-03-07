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
%>

<div class="container">
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
                <button class="btn btn-primary btn-lg btn-block" type="submit">Place Order</button>
            </form>
        </div>
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your cart</span>
                <span class="badge badge-secondary badge-pill"><%= cart.size()%></span>
            </h4>
            <ul class="list-group mb-3">
                <%
                    double total = 0;
                    for (CartItem item : cart) {
                        double itemTotal = item.getProduct().getPrice() * item.getQuantity();
                        total += itemTotal;
                %>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0"><%= item.getProduct().getName()%></h6>
                        <small class="text-muted">Quantity: <%= item.getQuantity()%></small>
                    </div>
                    <span class="text-muted">$<%= itemTotal%></span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <img src="<%= item.getProduct().getimage_url()%>" alt="<%= item.getProduct().getName()%>" style="width: 100px; height: auto;">
                </li>
                <%
                    }
                %>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (USD)</span>
                    <strong>$<%= total%></strong>
                </li>
            </ul>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />