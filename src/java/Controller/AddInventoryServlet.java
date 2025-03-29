package Controller;

import DAO.InventoryDAO;
import DAO.ProductDAO;
import Model.Inventory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddInventoryServlet")
public class AddInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO = new InventoryDAO();
    private ProductDAO productDAO = new ProductDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productIdParam = request.getParameter("productId");
            if (productIdParam == null || productIdParam.isEmpty()) {
                throw new IllegalArgumentException("Product ID is required.");
            }
            int productId = Integer.parseInt(productIdParam);

            String staffId = request.getParameter("staffId");
            int inventoryQuantity = Integer.parseInt(request.getParameter("quantity"));
            String inventoryType = request.getParameter("type");
            String inventoryImageUrl = request.getParameter("image_url");
            String productCategoryId = request.getParameter("categoryId");

            // Kiểm tra sự tồn tại của product_id trong bảng Products
            if (productDAO.productExists(productId)) {
                Inventory inventory = new Inventory(0, productId, staffId, inventoryQuantity, inventoryType, inventoryImageUrl, productCategoryId);
                inventoryDAO.addInventory(inventory);
                response.sendRedirect("StaffWarehouse.jsp"); // Quay lại trang dashboard
            } else {
                response.sendRedirect("StaffWarehouse.jsp?error=Product ID does not exist");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("StaffWarehouse.jsp?error=Invalid Product ID");
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendRedirect("StaffWarehouse.jsp?error=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StaffWarehouse.jsp?error=An unexpected error occurred");
        }
    }
}