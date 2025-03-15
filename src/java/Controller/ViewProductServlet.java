/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Product;
import DAO.CategoryDAO;
import DAO.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import ConnectDB.DBConnect;
import Model.Category;

/**
 *
 * @author Admin
 */
@WebServlet("/ViewProductServlet")
public class ViewProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();
            String sql = "SELECT * FROM Products";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getString("category_id"));
                products.add(product);
            }
            request.setAttribute("products", products);
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("ManageProducts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
                default:
                    doGet(request, response);
                    break;
            }
        } else {
            doGet(request, response);
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String imageUrl = request.getParameter("imageUrl");
        String category = request.getParameter("categoryId");

        try ( Connection conn = DBConnect.getConnection()) {
            String sql = "INSERT INTO Products (name, description, price, stock_quantity, image_url, category_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setInt(4, stockQuantity);
            stmt.setString(5, imageUrl);
            stmt.setString(6, category);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("ViewProductServlet");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String imageUrl = request.getParameter("imageUrl");
        String category = request.getParameter("categoryId");

        int productId = Integer.parseInt(productIdStr);
        double price = Double.parseDouble(priceStr);
        int stockQuantity = Integer.parseInt(stockQuantityStr);

        try ( Connection conn = DBConnect.getConnection()) {
            String sql = "UPDATE Products SET name = ?, description = ?, price = ?, stock_quantity = ?, image_url = ?, category_id = ? WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setInt(4, stockQuantity);
            stmt.setString(5, imageUrl);
            stmt.setString(6, category);
            stmt.setInt(7, productId);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("ViewProductServlet");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        try ( Connection conn = DBConnect.getConnection()) {
            String sql = "DELETE FROM Products WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("ViewProductServlet");
    }
}
