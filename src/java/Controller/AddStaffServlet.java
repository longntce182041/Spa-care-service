/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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
@WebServlet("/AddStaffServlet")
public class AddStaffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = new DBConnect().getConnection()) {
            String sql = "INSERT INTO Staff (admin_id, full_name, position, phone, user_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(request.getParameter("admin_id")));
            stmt.setString(2, request.getParameter("full_name"));
            stmt.setString(3, request.getParameter("position"));
            stmt.setString(4, request.getParameter("phone"));
            stmt.setInt(5, Integer.parseInt(request.getParameter("user_id")));

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("StaffServlet");
    }
}
