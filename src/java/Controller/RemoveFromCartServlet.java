package Controller;

import Model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Your cart is empty.\"}");
                return;
            }

            boolean removed = cart.removeIf(item -> item.getProduct().getProductId() == productId);

            if (!removed) {
                response.getWriter().write("{\"success\": false, \"message\": \"Product not found in cart.\"}");
                return;
            }

            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());

            double totalPrice = cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();

            response.getWriter().write("{\"success\": true, \"message\": \"Product removed successfully.\", \"cartCount\": " + cart.size() + ", \"totalPrice\": \"" + String.format("%,.0f VNĐ", totalPrice) + "\"}");
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid product ID.\"}");
        }
    }
}