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
        int productId = Integer.parseInt(request.getParameter("productId"));
        String staffId = request.getParameter("staffId"); // Thay đổi kiểu dữ liệu thành String
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String type = request.getParameter("type");
        String imageUrl = request.getParameter("image_url");
        String categoryId = request.getParameter("categoryId"); // Thay đổi kiểu dữ liệu thành String

        // Kiểm tra sự tồn tại của product_id trong bảng Products
        if (productDAO.productExists(productId)) {
            Inventory inventory = new Inventory(0, productId, staffId, quantity, type, imageUrl, categoryId);
            inventoryDAO.addInventory(inventory);
            response.sendRedirect("StaffWarehouse.jsp"); // Quay lại trang dashboard
        } else {
            // Nếu product_id không tồn tại, hiển thị thông báo lỗi
            response.sendRedirect("StaffWarehouse.jsp?error=Product ID does not exist");
        }
    }
}