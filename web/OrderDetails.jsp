<%@ page import="java.util.*, Model.Order, Model.OrderDetail" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/shop.css"> <!-- Liên kết tệp CSS mới -->


<%
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);

    Order order = (Order) request.getAttribute("order");
    List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
%>

<div class="container my-5">
    <!-- Header -->
    <div class="text-center mb-4">
        <h1 class="display-5">Order Details</h1>
        <p class="text-muted">Below are the details of your order.</p>
    </div>

    <!-- Order Summary -->
    <div class="row">
        <div class="col-md-8">
            <h4 class="mb-3">Products</h4>
            <table class="table table-bordered">
                <thead class="table-light">
                    <tr>
                        <th>Image</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price (VNĐ)</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        double total = 0;
                        for (OrderDetail detail : orderDetails) {
                            double itemTotal = detail.getPrice() * detail.getQuantity();
                            total += itemTotal;
                    %>
                    <tr>
                        <td>
                            <img src="<%= detail.getProductImage() %>" alt="<%= detail.getProductName() %>" class="img-thumbnail" style="width: 80px; height: 80px; object-fit: cover;">
                        </td>
                        <td><%= detail.getProductName() %></td>
                        <td><%= detail.getQuantity() %></td>
                        <td><%= currencyVN.format(detail.getPrice()) %></td>
                        
                    </tr>
                    <%
                        }
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="3" class="text-end">Subtotal (VNĐ):</th>
                        <th>
                            <%
                                double subtotal = 0;
                                for (OrderDetail detail : orderDetails) {
                                    subtotal += detail.getPrice() * detail.getQuantity();
                                }
                                out.print(currencyVN.format(subtotal));
                            %>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="3" class="text-end">Shipping Fee (VNĐ):</th>
                        <th><%= currencyVN.format(30_000) %></th> <!-- Phí vận chuyển mặc định -->
                    </tr>
                    <tr>
                        <th colspan="3" class="text-end">Promotion Code:</th>
                        <th><%= order.getPromotionId() != null ? order.getPromotionId() : "None" %></th>
                    </tr>
                    <tr class="table-success">
                        <th colspan="3" class="text-end">Total (VNĐ):</th>
                        <th><%= currencyVN.format(order.getTotalPrice()) %></th>
                    </tr>
                </tfoot>
            </table>
        </div>

        <!-- Customer Details -->
        <div class="col-md-4">
            <h4 class="mb-3">Customer Details</h4>
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
    </div>

    <!-- Back to Order History -->
    <div class="text-center mt-4">
        <a href="OrderHistoryServlet" class="btn btn-primary btn-lg">Back to Order History</a>
    </div>
</div>

<jsp:include page="footer.jsp" />