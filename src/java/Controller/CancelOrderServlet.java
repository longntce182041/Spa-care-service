package Controller;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        String reason = request.getParameter("reason");

        if (orderIdStr == null || orderIdStr.trim().isEmpty() || reason == null || reason.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Order ID and reason are required.");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);

            // Kiểm tra trạng thái đơn hàng
            String status = orderDAO.getOrderStatus(orderId);
            if (!"Pending".equalsIgnoreCase(status)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Only pending orders can be canceled.");
                return;
            }

            // Hủy đơn hàng và lưu lý do
            boolean isCanceled = orderDAO.cancelOrder(orderId, "Canceled", reason);
            if (isCanceled) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Order canceled successfully.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to cancel the order.");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid Order ID.");
        }
    }
}