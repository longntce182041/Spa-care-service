package Servlet;

import DAO.InventoryDAO;
import Model.Inventory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateInventoryServlet")
public class UpdateInventoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO = new InventoryDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String type = request.getParameter("type");
        String image_url = request.getParameter("image_url");

        Inventory inventory = new Inventory(inventoryId, productId, staffId, quantity, type, image_url);
        inventoryDAO.updateInventory(inventory);

        response.sendRedirect("Staffdashboard.jsp");
    }
}
