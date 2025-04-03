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
import java.util.Set;
import java.util.Arrays;
import java.util.stream.Collectors;
import jakarta.mail.MessagingException;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Khai báo và khởi tạo OrderDAO
    private OrderDAO orderDAO = new OrderDAO();

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

        // Lấy danh sách sản phẩm được chọn từ request
        String[] selectedProductIds = request.getParameterValues("selectedProducts");
        if (selectedProductIds == null || selectedProductIds.length == 0) {
            System.out.println("No products selected for checkout");
            response.sendRedirect("Cart.jsp");
            return;
        }

        // Chuyển danh sách selectedProductIds thành Set để dễ kiểm tra
        Set<Integer> selectedProductIdSet = Arrays.stream(selectedProductIds)
                                                  .map(Integer::parseInt)
                                                  .collect(Collectors.toSet());

        // Lọc danh sách OrderDetail để chỉ giữ lại các sản phẩm được chọn
        List<OrderDetail> selectedOrderDetails = orderDetails.stream()
            .filter(detail -> selectedProductIdSet.contains(detail.getProductId()))
            .collect(Collectors.toList());

        // Kiểm tra danh sách sản phẩm đã chọn
        if (selectedOrderDetails.isEmpty()) {
            System.out.println("No valid products selected for checkout");
            response.sendRedirect("Cart.jsp");
            return;
        }

        // Lưu thông tin đơn hàng và các mục đơn hàng đã chọn vào cơ sở dữ liệu
        int orderId = orderDAO.saveOrder(order, selectedOrderDetails);

        // Kiểm tra orderId
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

        // Gửi email hóa đơn chỉ với các sản phẩm đã chọn
        try {
            sendOrderConfirmationEmail(order, selectedOrderDetails);
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

        // Bắt đầu nội dung email
        emailContent.append("<html><body style='font-family: Arial, sans-serif;'>");
        emailContent.append("<h1 style='color: #4CAF50;'>Thank you for your order!</h1>");
        emailContent.append("<p>Your order has been placed successfully. Below are the details of your order:</p>");

        // Thông tin đơn hàng
        emailContent.append("<h2 style='color: #333;'>Order Details</h2>");
        emailContent.append("<p><strong>Order ID:</strong> ").append(order.getOrderId()).append("</p>");
        emailContent.append("<p><strong>Order Date:</strong> ").append(order.getOrderDate()).append("</p>");

        // Bảng chi tiết sản phẩm
        emailContent.append("<table style='width: 100%; border-collapse: collapse; margin-top: 20px;'>");
        emailContent.append("<thead>");
        emailContent.append("<tr style='background-color: #f2f2f2;'>");
        emailContent.append("<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>Product</th>");
        emailContent.append("<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>Quantity</th>");
        emailContent.append("<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>Price</th>");
        emailContent.append("<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>Total</th>");
        emailContent.append("</tr>");
        emailContent.append("</thead>");
        emailContent.append("<tbody>");

        double total = 0;
        for (OrderDetail detail : orderDetails) {
            Product product = productDAO.getProductById(detail.getProductId());
            double itemTotal = detail.getPrice() * detail.getQuantity();
            total += itemTotal;

            emailContent.append("<tr>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>")
                        .append("<img src='").append(product.getimage_url()).append("' alt='").append(product.getName())
                        .append("' style='width: 50px; height: auto; margin-right: 10px;'>")
                        .append(product.getName()).append("</td>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>").append(detail.getQuantity()).append("</td>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>")
                        .append(String.format("%,.0f VNĐ", detail.getPrice())).append("</td>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>")
                        .append(String.format("%,.0f VNĐ", itemTotal)).append("</td>");
            emailContent.append("</tr>");
        }

        emailContent.append("</tbody>");
        emailContent.append("</table>");

        // Tổng tiền
        emailContent.append("<p style='margin-top: 20px;'><strong>Total:</strong> ")
                    .append(String.format("%,.0f VNĐ", total)).append("</p>");

        // Thông tin khách hàng
        emailContent.append("<h2 style='color: #333;'>Customer Details</h2>");
        emailContent.append("<p><strong>Name:</strong> ").append(order.getName()).append("</p>");
        emailContent.append("<p><strong>Address:</strong> ").append(order.getAddress()).append("</p>");
        emailContent.append("<p><strong>Phone:</strong> ").append(order.getPhone()).append("</p>");
        emailContent.append("<p><strong>Email:</strong> ").append(order.getEmail()).append("</p>");
        emailContent.append("<p><strong>Payment Method:</strong> ").append(order.getPaymentMethod()).append("</p>");

        // Kết thúc email
        emailContent.append("<p style='margin-top: 20px;'>If you have any questions, feel free to contact us at petquespact@gmail.com.</p>");
        emailContent.append("<p style='color: #888;'>Thank you for shopping with us!</p>");
        emailContent.append("</body></html>");

        // Gửi email
        EmailUtil.sendOrderConfirmationEmail(order.getEmail(), "Order Confirmation", emailContent.toString());
    }
}
