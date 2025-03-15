/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Product;
import DAO.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import ConnectDB.DBConnect;

/**
 *
 * @author Admin
 */
@WebServlet("/ViewProductDetailServlet")
public class ViewProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productId = request.getParameter("id");
        Product product = null;
        Connection conn = null;

        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();
            String sql = "SELECT * FROM Products WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(productId));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                            rs.getInt("product_id"),
                            rs.getString("name"), 
                            rs.getString("description"), 
                            rs.getDouble("price"), 
                            rs.getInt("stock_quantity"), 
                            rs.getString("image_url"), 
                            rs.getString("category_id"));
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("viewproductdetail.jsp").forward(request, response);
    }
}