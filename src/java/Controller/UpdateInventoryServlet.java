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
        String staffId = request.getParameter("staffId"); // Thay đổi kiểu dữ liệu thành String
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String type = request.getParameter("type");
        String imageUrl = request.getParameter("image_url");
        String categoryId = request.getParameter("categoryId"); // Thay đổi kiểu dữ liệu thành String

        Inventory inventory = new Inventory(inventoryId, productId, staffId, quantity, type, imageUrl, categoryId);
        inventoryDAO.updateInventory(inventory);

        response.sendRedirect("StaffWarehouse.jsp");
    }
}