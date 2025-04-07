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
import java.text.NumberFormat;
import java.util.Locale;
import DAO.PromotionDAO;
import Model.Promotion;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Khai báo và khởi tạo OrderDAO
    private OrderDAO orderDAO = new OrderDAO();

    private double calculateShippingFee(String address) {
        return 30_000; // Phí vận chuyển mặc định
    }

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

        String userId = (String) session.getAttribute("user_id");

        if (userId == null) {
            userId = "GUEST"; // Gán giá trị mặc định cho khách vãng lai
        } else {
            // Nếu người dùng đã đăng nhập, sử dụng thông tin từ session
            name = (String) session.getAttribute("user_fullname");
            address = (String) session.getAttribute("user_address");
            phone = (String) session.getAttribute("user_phone");
            email = (String) session.getAttribute("user_email");
        }

        // Tạo đối tượng Order
        Order order = new Order();
        order.setName(name);
        order.setAddress(address);
        order.setPhone(phone);
        order.setEmail(email);
        order.setUserId(userId); // Nếu không đăng nhập, userId sẽ là "guest"
        order.setPaymentMethod(request.getParameter("paymentMethod"));

        order.setTotalPrice(cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum());
        order.setStatus("Pending");
        order.setPromotionId(null); // Giả sử không có promotion
        order.setProductId(cart.get(0).getProduct().getProductId()); // Lấy product_id từ sản phẩm đầu tiên trong giỏ hàng

        // Tính phí vận chuyển mặc định
        double shippingFee = calculateShippingFee(address);
        order.setShippingFee(shippingFee);

        // Lấy mã giảm giá từ request
        String promoCode = request.getParameter("promoCode");
        System.out.println("Promo code: " + promoCode);

        // Kiểm tra mã giảm giá
        double discount = 0;
        if (promoCode != null && !promoCode.trim().isEmpty()) {
            PromotionDAO promotionDAO = new PromotionDAO();
            Promotion promotion = promotionDAO.getPromotionByCode(promoCode);

            if (promotion != null && promotion.isActive() && promotion.isValid(order.getTotalPrice())) {
                if ("fixed".equalsIgnoreCase(promotion.getDiscountType())) {
                    discount = promotion.getDiscountValue();
                } else if ("percent".equalsIgnoreCase(promotion.getDiscountType())) {
                    discount = order.getTotalPrice() * (promotion.getDiscountValue() / 100);
                }

                // Áp dụng giới hạn giảm giá tối đa
                if (promotion.getMaxDiscount() != null && discount > promotion.getMaxDiscount()) {
                    discount = promotion.getMaxDiscount();
                }

                // Gán mã giảm giá vào đơn hàng
                order.setPromotionId(promoCode);
                System.out.println("Promotion applied: " + promoCode + ", Discount: " + discount);
            } else {
                System.out.println("Invalid or expired promotion code: " + promoCode);
            }
        }

        // Cộng phí vận chuyển vào tổng giá trị ban đầu
        double totalPriceWithShipping = order.getTotalPrice() + shippingFee;

        // Áp dụng giảm giá vào tổng giá trị đã bao gồm phí vận chuyển
        double totalPriceAfterDiscount = totalPriceWithShipping - discount;

        // Cập nhật tổng giá trị vào đối tượng Order
        order.setTotalPrice(totalPriceAfterDiscount);

        // In ra console để kiểm tra
        System.out.println("Original total price: " + order.getTotalPrice());
        System.out.println("Shipping fee: " + shippingFee);
        System.out.println("Total price with shipping: " + totalPriceWithShipping);
        System.out.println("Discount applied: " + discount);
        System.out.println("Total price after discount: " + totalPriceAfterDiscount);
        System.out.println("Order total price: " + order.getTotalPrice());

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

    void sendOrderConfirmationEmail(Order order, List<OrderDetail> orderDetails) throws MessagingException {
        ProductDAO productDAO = new ProductDAO();
        PromotionDAO promotionDAO = new PromotionDAO();
        StringBuilder emailContent = new StringBuilder();
        NumberFormat currencyVN = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        // Lấy thông tin mã giảm giá (nếu có)
        Promotion promotion = null;
        if (order.getPromotionId() != null) {
            promotion = promotionDAO.getPromotionByCode(order.getPromotionId());
        }

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

        double subtotal = 0;
        for (OrderDetail detail : orderDetails) {
            Product product = productDAO.getProductById(detail.getProductId());
            double itemTotal = detail.getPrice() * detail.getQuantity();
            subtotal += itemTotal;

            emailContent.append("<tr>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>")
                    .append("<img src='").append(product.getimage_url()).append("' alt='").append(product.getName())
                    .append("' style='width: 50px; height: auto; margin-right: 10px;'>")
                    .append(product.getName()).append("</td>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>").append(detail.getQuantity()).append("</td>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>")
                    .append(currencyVN.format(detail.getPrice())).append("</td>");
            emailContent.append("<td style='border: 1px solid #ddd; padding: 8px;'>")
                    .append(currencyVN.format(itemTotal)).append("</td>");
            emailContent.append("</tr>");
        }

        emailContent.append("</tbody>");
        emailContent.append("</table>");

        // Tổng tiền trước giảm giá
        emailContent.append("<p style='margin-top: 20px;'><strong>Subtotal:</strong> ")
                .append(currencyVN.format(subtotal)).append("</p>");

        // Thông tin mã giảm giá (nếu có)
        if (promotion != null) {
            emailContent.append("<p><strong>Promotion Code:</strong> ").append(promotion.getPromotionId()).append("</p>");
            
        } else {
            emailContent.append("<p><strong>Promotion Code:</strong> None</p>");
        }

        // Phí vận chuyển
        emailContent.append("<p><strong>Shipping Fee:</strong> ")
            .append(currencyVN.format(30_000)).append("</p>");

        // Tổng tiền sau giảm giá và phí vận chuyển
        emailContent.append("<p><strong>Total (including shipping):</strong> ")
                .append(currencyVN.format(order.getTotalPrice())).append("</p>");

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
