package Controller;

import DAO.ProductDAO;
import Model.CartItem;
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

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean itemExists = false;
        for (CartItem item : cart) {
            if (item.getProduct().getProductId() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                itemExists = true;
                break;
            }
        }

        if (!itemExists) {
            cart.add(new CartItem(product, quantity));
        }

        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", cart.size());

        // Trả về số lượng sản phẩm trong giỏ hàng
        response.setContentType("application/json");
        response.getWriter().write("{\"cartCount\": " + cart.size() + "}");
    }
}