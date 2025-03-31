package Controller;

import DAO.OrderDAO;
import DAO.ProductDAO;
import Model.CartItem;
import Model.Order;
import Model.OrderDetail;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.mail.MessagingException;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            System.out.println("Cart is empty or null");
            response.sendRedirect("Shop.jsp");
            return;
        }

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String paymentMethod = request.getParameter("paymentMethod");

        // Tạo đối tượng Order
        Order order = new Order();
        order.setTotalPrice(cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum());
        order.setStatus("Pending");
        order.setPromotionId(null); // Giả sử không có promotion, bạn có thể thay đổi theo logic của bạn
        order.setUserId(1); // Giả sử user_id là 1, bạn có thể thay đổi theo logic của bạn
        order.setProductId(cart.get(0).getProduct().getProductId()); // Lấy product_id từ sản phẩm đầu tiên trong giỏ hàng
        order.setName(name);
        order.setPhone(phone);
        order.setEmail(email);
        order.setAddress(address);
        order.setPaymentMethod(paymentMethod);

        // In ra console để kiểm tra
        System.out.println("Order: " + order);

        // Tạo danh sách OrderDetail từ giỏ hàng
        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartItem cartItem : cart) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductId(cartItem.getProduct().getProductId());
            orderDetail.setQuantity(cartItem.getQuantity());
            orderDetail.setPrice(cartItem.getProduct().getPrice());
            orderDetails.add(orderDetail);
        }

        // In ra console để kiểm tra
        for (OrderDetail detail : orderDetails) {
            System.out.println("OrderDetail: " + detail);
        }

        // Lưu thông tin đơn hàng và các mục đơn hàng vào cơ sở dữ liệu
        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.saveOrder(order, orderDetails);

        // Kiểm tra orderId
        System.out.println("Order ID: " + orderId);

        // Nếu orderId là 0, có nghĩa là lưu thông tin đơn hàng không thành công
        if (orderId == 0) {
            System.out.println("Failed to save order");
            response.sendRedirect("Shop.jsp");
            return;
        }

        // Lấy lại thông tin đơn hàng từ cơ sở dữ liệu
        order = orderDAO.getOrderById(orderId);

        // Xóa giỏ hàng sau khi đặt hàng thành công
        session.removeAttribute("cart");
        session.removeAttribute("cartCount");

        // Gửi email hóa đơn
        try {
            sendOrderConfirmationEmail(order, orderDetails);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // Chuyển thông tin đơn hàng đến trang xác nhận đơn hàng
        request.setAttribute("orderId", orderId);

        // Chuyển hướng đến trang xác nhận đơn hàng
        request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
    }

    private void sendOrderConfirmationEmail(Order order, List<OrderDetail> orderDetails) throws MessagingException {
        ProductDAO productDAO = new ProductDAO();
        StringBuilder emailContent = new StringBuilder();
        emailContent.append("<html><body>");
        emailContent.append("<h1>Thank you for your order! Your order has been placed successfully.</h1>");
        emailContent.append("<h2>Order Details:</h2>");
        emailContent.append("<p>Order code: ").append(order.getOrderId()).append("</p>");
        emailContent.append("<p>Date: ").append(order.getOrderDate()).append("</p>");

        double total = 0;
        for (OrderDetail detail : orderDetails) {
            Product product = productDAO.getProductById(detail.getProductId());
            emailContent.append("<p>Product: ").append(product.getName()).append("</p>");
            emailContent.append("<p>Quantity: ").append(detail.getQuantity()).append("</p>");
            emailContent.append("<p>Price: ").append(String.format("%,.0f VNĐ", detail.getPrice())).append("</p>");
            emailContent.append("<img src=\"").append(product.getimage_url()).append("\" alt=\"").append(product.getName()).append("\" style=\"width: 100px; height: auto;\"><br>");
            total += detail.getPrice() * detail.getQuantity();
        }

        emailContent.append("<p>Total: ").append(String.format("%,.0f VNĐ", total)).append("</p>");
        emailContent.append("<h2>Customer Details:</h2>");
        emailContent.append("<p>Name: ").append(order.getName()).append("</p>");
        emailContent.append("<p>Address: ").append(order.getAddress()).append("</p>");
        emailContent.append("<p>Phone: ").append(order.getPhone()).append("</p>");
        emailContent.append("<p>Email: ").append(order.getEmail()).append("</p>");
        emailContent.append("<p>Payment Method: ").append(order.getPaymentMethod()).append("</p>");
        emailContent.append("</body></html>");

        EmailUtil.sendOrderConfirmationEmail(order.getEmail(), "Order Confirmation", emailContent.toString());
    }
}
