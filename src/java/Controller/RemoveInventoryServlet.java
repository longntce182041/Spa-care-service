package Controller;

import DAO.InventoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RemoveInventoryServlet")
public class RemoveInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO = new InventoryDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Giảm số lượng và kiểm tra nếu số lượng về 0
        boolean isDeleted = inventoryDAO.removeInventory(inventoryId, quantity);

        if (isDeleted) {
            // Nếu sản phẩm bị xóa, chuyển hướng đến trang dashboard
            response.sendRedirect("StaffWarehouse.jsp");
        } else {
            // Nếu sản phẩm không bị xóa, chuyển hướng đến trang dashboard
            response.sendRedirect("StaffWarehouse.jsp");
        }
    }
}