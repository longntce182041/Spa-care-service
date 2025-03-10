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
 *
 * @author Nguyen Thanh Long - CE182041
 */
@WebServlet(name = "ManageCustomerServlet", urlPatterns = {"/ManageCustomerServlet"})
public class ManageCustomerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        List<Customer> customers = CustomerDAO.getAllCustomer();
        List<User> customer = UserDAO.getAllCustomer();
        request.setAttribute("customers", customer);
        request.getRequestDispatcher("ManageCustomer.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

            User user = new User(email, null, null, fullname, address, phone, username, userId);
            if (userDAO.updateUser(user)) {
                request.setAttribute("message", "User updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update user.");
            }
        }

        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
