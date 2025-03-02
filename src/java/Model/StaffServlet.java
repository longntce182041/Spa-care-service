/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import ConnectDB.DBConnect;
import Controller.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author Admin
 */
@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Staff> staffList = new ArrayList<>();
        try (Connection conn = new DBConnect().getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Staff");
            while (rs.next()) {
                staffList.add(new Staff(
                    rs.getInt("staff_id"),
                    rs.getInt("admin_id"),
                    rs.getString("full_name"),
                    rs.getString("position"),
                    rs.getString("phone"),
                    rs.getInt("user_id")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
    }
}
