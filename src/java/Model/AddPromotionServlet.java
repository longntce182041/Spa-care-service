/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import ConnectDB.DBConnect;
import Controller.Promotion;
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
        Connection conn = null;
        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();
            String sql = "INSERT INTO Promotion (name, description, discount_type, discount_value, start_date, end_date, min_order_value, max_discount, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("PromotionServlet");
    }
}

