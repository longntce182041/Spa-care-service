/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import ConnectDB.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;


/**
 *
 * @author Admin
 */
@WebServlet("/DeletePromotionServlet")
public class DeletePromotionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            DBConnect dbConnect = new DBConnect();
            conn = dbConnect.getConnection();
            String sql = "DELETE FROM Promotion WHERE promotion_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, Integer.parseInt(request.getParameter("id")));
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("PromotionServlet");
    }
}
