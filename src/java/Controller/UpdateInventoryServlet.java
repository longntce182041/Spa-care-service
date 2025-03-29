package Controller;

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
        String staffId = request.getParameter("staffId");
        int inventoryQuantity = Integer.parseInt(request.getParameter("quantity"));
        String inventoryType = request.getParameter("type");
        String inventoryImageUrl = request.getParameter("image_url");
        String productCategoryId = request.getParameter("categoryId");

        Inventory inventory = new Inventory(inventoryId, productId, staffId, inventoryQuantity, inventoryType, inventoryImageUrl, productCategoryId);
        inventoryDAO.updateInventory(inventory);

        response.sendRedirect("StaffWarehouse.jsp");
    }
}