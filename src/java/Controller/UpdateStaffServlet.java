/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import Model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 *
 * @author Admin
 */
@WebServlet("/UpdateStaffServlet")
public class UpdateStaffServlet extends HttpServlet {
    
    // Xử lý yêu cầu GET để hiển thị thông tin nhân viên cần cập nhật
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = new DBConnect().getConnection()) {
            int staffId = Integer.parseInt(request.getParameter("id"));
            String sql = "SELECT * FROM Staff WHERE staff_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Staff staff = new Staff(
                    rs.getInt("staff_id"),
                    rs.getInt("admin_id"),
                    rs.getString("full_name"),
                    rs.getString("position"),
                    rs.getString("phone"),
                    rs.getInt("user_id")
                );
                request.setAttribute("staff", staff);
                request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            } else {
                response.sendRedirect("manageStaff.jsp?error=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageStaff.jsp?error=exception");
        }
    }

    // Xử lý yêu cầu POST để cập nhật nhân viên
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = new DBConnect().getConnection()) {
            String sql = "UPDATE Staff SET admin_id=?, full_name=?, position=?, phone=?, user_id=? WHERE staff_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, Integer.parseInt(request.getParameter("admin_id")));
            stmt.setString(2, request.getParameter("full_name"));
            stmt.setString(3, request.getParameter("position"));
            stmt.setString(4, request.getParameter("phone"));
            stmt.setInt(5, Integer.parseInt(request.getParameter("user_id")));
            stmt.setInt(6, Integer.parseInt(request.getParameter("staff_id")));

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("StaffServlet");
            } else {
                response.sendRedirect("manageStaff.jsp?error=notupdated");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageStaff.jsp?error=exception");
        }
    }
}
