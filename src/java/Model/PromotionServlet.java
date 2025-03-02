/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;


import ConnectDB.DBConnect;
import Controller.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/PromotionServlet")
public class PromotionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        List<Promotion> promotions = new ArrayList<>();
        
        try {
            conn = DBConnect.getConnection();
            String sql = "SELECT * FROM Promotion";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Promotion promo = new Promotion();
                promo.setPromotionId(rs.getInt("promotion_id"));
                promo.setName(rs.getString("name"));
                promo.setDescription(rs.getString("description"));
                promo.setDiscountType(rs.getString("discount_type"));
                promo.setDiscountValue(rs.getDouble("discount_value"));
                promo.setStartDate(rs.getDate("start_date"));
                promo.setEndDate(rs.getDate("end_date"));
                promo.setMinOrderValue(rs.getDouble("min_order_value"));
                promo.setMaxDiscount(rs.getObject("max_discount") != null ? rs.getDouble("max_discount") : null);
                promo.setActive(rs.getInt("is_active") == 1);

                promotions.add(promo);
            }
            request.setAttribute("promotions", promotions);
            request.getRequestDispatcher("promotion.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}
