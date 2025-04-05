/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import DAO.StaffDAO;
import Model.Staff;
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
@WebServlet("/ManageStaffServlet")
public class ManageStaffServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            List<Staff> list = StaffDAO.getAllStaff();
            request.setAttribute("staffList", list);
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            String staffId = request.getParameter("id");
            StaffDAO.deleteStaff(staffId);
            response.sendRedirect("ManageStaffServlet");
            
        } else if (action.equals("update")) {
            String staffId = request.getParameter("id");
            Staff staff = StaffDAO.getStaffById(staffId);
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String staffId = request.getParameter("staff_id");
        String fullName = request.getParameter("full_name");
        String position = request.getParameter("position");
        String phone = request.getParameter("phone");
        String userId = request.getParameter("user_id");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String img = request.getParameter("img");

        Staff staff = new Staff(staffId, fullName, position, phone, userId, role, email, password, img);

        if ("add".equals(action)) {
            StaffDAO.addStaff(staff);
        } else if ("update".equals(action)) {
            StaffDAO.updateStaff(staff);
        }

        response.sendRedirect("ManageStaffServlet");
    }
}