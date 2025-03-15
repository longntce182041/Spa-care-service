/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import Model.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 *
 * @author Admin
 */
@WebServlet("/UpdatePromotionServlet")
public class UpdatePromotionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int promotionId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;

        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();
            String sql = "SELECT * FROM Promotion WHERE promotion_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Promotion promo = new Promotion(
                    rs.getInt("promotion_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("discount_type"),
                    rs.getDouble("discount_value"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date"),
                    rs.getDouble("min_order_value"),
                    rs.getObject("max_discount") != null ? rs.getDouble("max_discount") : null,
                    rs.getBoolean("is_active")
                );
                request.setAttribute("promotion", promo);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("updatePromotion.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();
            String sql = "UPDATE Promotion SET name=?, description=?, discount_type=?, discount_value=?, start_date=?, end_date=?, min_order_value=?, max_discount=?, is_active=? WHERE promotion_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, request.getParameter("name"));
            stmt.setString(2, request.getParameter("description"));
            stmt.setString(3, request.getParameter("discount_type"));
            stmt.setDouble(4, Double.parseDouble(request.getParameter("discount_value")));
            stmt.setDate(5, Date.valueOf(request.getParameter("start_date")));
            stmt.setDate(6, Date.valueOf(request.getParameter("end_date")));
            stmt.setDouble(7, Double.parseDouble(request.getParameter("min_order_value")));
            stmt.setObject(8, request.getParameter("max_discount").isEmpty() ? null : Double.parseDouble(request.getParameter("max_discount")));
            stmt.setBoolean(9, request.getParameter("is_active") != null);
            stmt.setInt(10, Integer.parseInt(request.getParameter("id")));
            
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("PromotionServlet");
    }
}
