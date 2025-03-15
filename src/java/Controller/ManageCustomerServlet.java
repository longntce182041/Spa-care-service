/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import ConnectDB.DBConnect;
import DAO.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class ManageCustomerServlet
 */
@WebServlet("/ManageCustomerServlet")
public class ManageCustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageCustomerServlet() {
        super();
    }

    /**
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("delete".equals(action)) {
            String userId = request.getParameter("userId");
            if (userDAO.deleteUser(userId)) {
                request.setAttribute("message", "User deleted successfully.");
            } else {
                request.setAttribute("error", "Failed to delete user.");
            }
        } else if ("update".equals(action)) {
            String userId = request.getParameter("userId");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullname = request.getParameter("fullname");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");

            User user = new User(email, null, role, fullname, address, phone, username, userId);
            if (userDAO.updateUser(user)) {
                request.setAttribute("message", "User updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update user.");
            }
        }

        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> customers = UserDAO.getAllCustomer();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("ManageCustomer.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
