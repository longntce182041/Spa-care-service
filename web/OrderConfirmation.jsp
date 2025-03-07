<!-- filepath: /Users/tranphantrungkien/Ky5/SWP391/pet1/web/OrderConfirmation.jsp -->
<%@ page import="DAO.ProductDAO" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.Order" %> <!-- Thêm import cho lớp Order -->
<%@ page import="java.util.*, Model.OrderDetail, DAO.OrderDAO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/OrderConfirmation.css">

<%
    Integer orderId = (Integer) request.getAttribute("orderId");
    if (orderId == null) {
        response.sendRedirect("Shop.jsp");
        return;
    }
    OrderDAO orderDAO = new OrderDAO();
    List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
    ProductDAO productDAO = new ProductDAO();
    Order order = orderDAO.getOrderById(orderId);

    if (order == null) {
        response.sendRedirect("Shop.jsp");
        return;
    }
%>

<div class="container">
    <h1 class="text-center my-4">Order Confirmation</h1>
    <p>Thank you for your order! Your order has been placed successfully.</p>

   

    <h4 class="d-flex justify-content-between align-items-center mb-3">
        <span class="text-muted">Order Details</span>
    </h4>
    <ul class="list-group mb-3">
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Order ID</h6>
                <small class="text-muted"><%= order.getOrderId() %></small>
            </div>
        </li>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Order Date</h6>
                <small class="text-muted"><%= order.getOrderDate() %></small>
            </div>
        </li>
        <%
            double total = 0;
            for (OrderDetail detail : orderDetails) {
                Product product = productDAO.getProductById(detail.getProductId());
                double itemTotal = detail.getPrice() * detail.getQuantity();
                total += itemTotal;
        %>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0"><%= product.getName() %></h6>
                <small class="text-muted">Quantity: <%= detail.getQuantity() %></small>
            </div>
            <span class="text-muted">$<%= itemTotal %></span>
        </li>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <img src="<%= product.getimage_url() %>" alt="<%= product.getName() %>" style="width: 100px; height: auto;">
        </li>
        <%
            }
        %>
        <li class="list-group-item d-flex justify-content-between">
            <span>Total (USD)</span>
            <strong>$<%= total %></strong>
        </li>
    </ul>
    
    <h4 class="d-flex justify-content-between align-items-center mb-3">
        <span class="text-muted">Customer Details</span>
    </h4>
    <ul class="list-group mb-3">
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Name</h6>
                <small class="text-muted"><%= order.getName() %></small>
            </div>
        </li>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Address</h6>
                <small class="text-muted"><%= order.getAddress() %></small>
            </div>
        </li>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Phone</h6>
                <small class="text-muted"><%= order.getPhone() %></small>
            </div>
        </li>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Email</h6>
                <small class="text-muted"><%= order.getEmail() %></small>
            </div>
        </li>
        <li class="list-group-item d-flex justify-content-between lh-condensed">
            <div>
                <h6 class="my-0">Payment Method</h6>
                <small class="text-muted"><%= order.getPaymentMethod() %></small>
            </div>
        </li>
    </ul>

    <a href="Shop.jsp" class="btn btn-primary">Continue Shopping</a>
</div>

<jsp:include page="footer.jsp" />