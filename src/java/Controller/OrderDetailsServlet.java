/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.OrderDAO;
import Model.Order;
import Model.OrderDetail;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Tran Phan Trung Kien - CE180170
 */
@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect("OrderHistoryServlet");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        // Lấy thông tin đơn hàng và chi tiết đơn hàng
        Order order = orderDAO.getOrderById(orderId);
        List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);

        if (order == null || orderDetails.isEmpty()) {
            response.sendRedirect("OrderHistoryServlet");
            return;
        }

        // Đặt thông tin vào request
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);

        // Chuyển tiếp đến trang hiển thị chi tiết đơn hàng
        request.getRequestDispatcher("OrderDetails.jsp").forward(request, response);
    }
}

