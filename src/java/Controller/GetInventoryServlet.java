package Controller;

import DAO.InventoryDAO;
import Model.Inventory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/GetInventoryServlet")
public class GetInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO = new InventoryDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String inventory_idParam = request.getParameter("inventoryId");
            Gson gson = new Gson();
            String json;

            if (inventory_idParam != null) {
                // Lấy thông tin chi tiết của một hàng tồn kho
                int inventory_id = Integer.parseInt(inventory_idParam);
                Inventory inventory = inventoryDAO.getInventoryById(inventory_id);

                if (inventory != null) {
                    json = gson.toJson(inventory);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } else {
                // Lấy danh sách tất cả các hàng tồn kho
                List<Inventory> inventoryList = inventoryDAO.getAllInventory();
                json = gson.toJson(inventoryList);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}