package Controller;

import DAO.OrderDAO;
import DAO.ProductDAO;
import Model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        // Cập nhật trạng thái đơn hàng
        orderDAO.updateOrderStatus(orderId, status);

        // Nếu trạng thái là "Confirmed", trừ số lượng sản phẩm trong bảng Products
        if ("Confirmed".equals(status)) {
            List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
            for (OrderDetail detail : orderDetails) {
                productDAO.updateProductQuantity(detail.getProductId(), -detail.getQuantity());
            }
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Success");
    }
}