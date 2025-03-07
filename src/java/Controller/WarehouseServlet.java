/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.InventoryDAO;
import Model.Inventory;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet("/warehouse")
public class WarehouseServlet extends HttpServlet {
    private InventoryDAO inventoryDAO = new InventoryDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Inventory> inventoryList = inventoryDAO.getAllInventory();
        request.setAttribute("inventoryList", inventoryList);
        request.getRequestDispatcher("Staffdashboard.jsp").forward(request, response);
    }
}