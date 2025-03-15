package Controller;

import Model.Product;
import ConnectDB.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ManageProductsServlet")
public class ManageProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnect.getConnection()) {
            if (conn != null) {
                System.out.println("Database connection successful!");
            }
            String sql = "SELECT * FROM Products";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery()) {
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
            } catch (SQLException e) {
                System.err.println("Error executing query: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (SQLException e) {
            System.err.println("Error connecting to the database: " + e.getMessage());
            e.printStackTrace();
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("ManageProducts.jsp").forward(request, response);
    }
}