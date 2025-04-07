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
@WebServlet("/VnpayReturnServlet")
public class VnpayReturnServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");

        if ("00".equals(vnp_ResponseCode)) {
            // Thanh toán thành công
            int orderId = Integer.parseInt(vnp_TxnRef);

            // Cập nhật trạng thái đơn hàng
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.updateOrderStatus(orderId, "Confirmed");

            // Gửi email xác nhận đơn hàng
            Order order = orderDAO.getOrderById(orderId);
            List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
            try {
                CheckoutServlet checkoutServlet = new CheckoutServlet();
                checkoutServlet.sendOrderConfirmationEmail(order, orderDetails);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Chuyển hướng đến trang xác nhận đơn hàng
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
        } else {
            // Thanh toán thất bại
            response.sendRedirect("Checkout.jsp?error=Payment failed");
        }
    }
}