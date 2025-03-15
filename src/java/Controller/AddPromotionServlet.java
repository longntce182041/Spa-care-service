/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import Model.Promotion;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

@WebServlet("/AddPromotionServlet")
public class AddPromotionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = new DBConnect().getConnection()) {
            String sql = "INSERT INTO Promotion (name, description, discount_type, discount_value, start_date, end_date, min_order_value, max_discount, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                
                stmt.setString(1, request.getParameter("name"));
                stmt.setString(2, request.getParameter("description"));
                stmt.setString(3, request.getParameter("discountType"));
                String discountValue = request.getParameter("discountValue");
                stmt.setDouble(4, (discountValue != null && !discountValue.isEmpty()) ? Double.parseDouble(discountValue) : 0.0);
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                stmt.setDate(5, (startDate != null && !startDate.isEmpty()) ? Date.valueOf(startDate) : null);
                stmt.setDate(6, (endDate != null && !endDate.isEmpty()) ? Date.valueOf(endDate) : null);
                String minOrderValue = request.getParameter("minOrderValue");
                stmt.setDouble(7, (minOrderValue != null && !minOrderValue.isEmpty()) ? Double.parseDouble(minOrderValue) : 0.0);
                String maxDiscount = request.getParameter("maxDiscount");
                stmt.setObject(8, (maxDiscount != null && !maxDiscount.isEmpty()) ? Double.parseDouble(maxDiscount) : null);
                stmt.setBoolean(9, request.getParameter("isActive") != null);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("PromotionServlet");
    }
}
