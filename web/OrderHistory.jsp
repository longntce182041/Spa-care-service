<%@ page import="java.util.*, Model.Order" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/OrderHistory.css">

<div class="container">
    <h1 class="text-center my-4">Order History</h1>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders == null || orders.isEmpty()) {
    %>
        <p class="text-center">You have no orders yet.</p>
    <%
        } else {
    %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Total Price (VNĐ)</th>
                    <th>Status</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Order order : orders) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= String.format("%,.0f", order.getTotalPrice()) %></td>
                    <td><%= order.getStatus() %></td>
                    <td><a href="OrderDetailsServlet?orderId=<%= order.getOrderId() %>" class="btn btn-primary btn-sm">View</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>
</div>

<jsp:include page="footer.jsp" />