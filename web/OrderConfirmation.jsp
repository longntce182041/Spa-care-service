<%@page import="Model.Order"%>
<%@ page import="java.util.*, DAO.ProductDAO, Model.Product, Model.OrderDetail, DAO.OrderDAO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/OrderConfirmation.css">

<%
    // Lấy danh sách sản phẩm được chọn từ request
    String[] selectedProductIds = request.getParameterValues("selectedProducts");
    if (selectedProductIds == null || selectedProductIds.length == 0) {
        response.sendRedirect("Cart.jsp");
        return;
    }

    // Lấy thông tin đơn hàng
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

    // Lọc các sản phẩm được chọn
    List<OrderDetail> selectedOrderDetails = new ArrayList<>();
    for (OrderDetail detail : orderDetails) {
        for (String productId : selectedProductIds) {
            if (detail.getProductId() == Integer.parseInt(productId)) {
                selectedOrderDetails.add(detail);
            }
        }
    }
%>

<div class="container">
    <div class="confirmation-header">
        <h1>Order Confirmation</h1>
        <p>Thank you for your order! Your order has been placed successfully.</p>
    </div>

    <div class="order-details">
        <h4>Order Details</h4>
        <ul class="list-group">
            <li class="list-group-item">
                <strong>Order ID:</strong> <span><%= order.getOrderId() %></span>
            </li>
            <li class="list-group-item">
                <strong>Order Date:</strong> <span><%= order.getOrderDate() %></span>
            </li>
            <%
                double total = 0;
                for (OrderDetail detail : selectedOrderDetails) {
                    Product product = productDAO.getProductById(detail.getProductId());
                    double itemTotal = detail.getPrice() * detail.getQuantity();
                    total += itemTotal;
            %>
            <li class="list-group-item">
                <div class="product-info">
                    <img src="<%= product.getimage_url() %>" alt="<%= product.getName() %>" class="product-image">
                    <div>
                        <h6><%= product.getName() %></h6>
                        <small>Quantity: <%= detail.getQuantity() %></small>
                    </div>
                </div>
                <span class="price"><%= String.format("%,.0f VNĐ", itemTotal) %></span>
            </li>
            <%
                }
            %>
            <li class="list-group-item total">
                <strong>Total (VNĐ):</strong> <span><%= String.format("%,.0f VNĐ", total) %></span>
            </li>
        </ul>
    </div>

    <div class="customer-details">
        <h4>Customer Details</h4>
        <ul class="list-group">
            <li class="list-group-item">
                <strong>Name:</strong> <span><%= order.getName() %></span>
            </li>
            <li class="list-group-item">
                <strong>Address:</strong> <span><%= order.getAddress() %></span>
            </li>
            <li class="list-group-item">
                <strong>Phone:</strong> <span><%= order.getPhone() %></span>
            </li>
            <li class="list-group-item">
                <strong>Email:</strong> <span><%= order.getEmail() %></span>
            </li>
            <li class="list-group-item">
                <strong>Payment Method:</strong> <span><%= order.getPaymentMethod() %></span>
            </li>
        </ul>
    </div>

    <div class="continue-shopping">
        <a href="Shop.jsp" class="btn btn-primary">Continue Shopping</a>
    </div>
</div>

<jsp:include page="footer.jsp" />