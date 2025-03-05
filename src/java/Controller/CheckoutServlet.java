package Controller;

import DAO.OrderDAO;
import Model.CartItem;
import Model.Order;
import Model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
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
        order.setCustomerId(1); // Giả sử customer_id là 1, bạn có thể thay đổi theo logic của bạn
        order.setTotalPrice(cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum());
        order.setStatus("Pending");
        order.setPromotionId(null); // Giả sử không có promotion, bạn có thể thay đổi theo logic của bạn

        // Tạo danh sách OrderDetail từ giỏ hàng
        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartItem cartItem : cart) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductId(cartItem.getProduct().getProductId());
            orderDetail.setQuantity(cartItem.getQuantity());
            orderDetail.setPrice(cartItem.getProduct().getPrice());
            orderDetails.add(orderDetail);
        }

        // Lưu thông tin đơn hàng và các mục đơn hàng vào cơ sở dữ liệu
        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.saveOrder(order, orderDetails);

        // Xóa giỏ hàng sau khi đặt hàng thành công
        session.removeAttribute("cart");
        session.removeAttribute("cartCount");

        // Chuyển thông tin đơn hàng đến trang xác nhận đơn hàng
        request.setAttribute("orderId", orderId);
        request.setAttribute("name", name);
        request.setAttribute("address", address);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);
        request.setAttribute("paymentMethod", paymentMethod);

        // Chuyển hướng đến trang xác nhận đơn hàng
        request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
    }
}