/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CategoryDAO;
import DAO.ServiceDAO;
import Model.Category;
import Model.Service;
import Model.Service_Category;
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
@WebServlet(name = "ManageServiceServlet", urlPatterns = {"/ManageServiceServlet"})
public class ManageServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
        String action = request.getParameter("action");
        ServiceDAO serviceDAO = new ServiceDAO();

        if (action == null || action.equals("listServices")) {
            // Get list of services
            List<Service> services = serviceDAO.getAllServices();
            // Get dynamic list of service categories
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Service_Category> categories = categoryDAO.getAllServicesCategory();

            request.setAttribute("services", services);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("ManageService.jsp").forward(request, response);

        } else if (action.equals("addService")) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String imageUrl = request.getParameter("imageUrl");
            String categoryId = request.getParameter("categoryId");

            Service newService = new Service(null, name, description, price, imageUrl, categoryId);
            serviceDAO.addService(newService);
            response.sendRedirect("ManageServiceServlet?action=listServices");

        } else if (action.equals("updateService")) {
            String serviceId = request.getParameter("service_id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String imageUrl = request.getParameter("imageUrl");
            String categoryId = request.getParameter("categoryId");

            Service updatedService = new Service(serviceId, name, description, price, imageUrl, categoryId);
            serviceDAO.updateService(updatedService);
            response.sendRedirect("ManageServiceServlet?action=listServices");

        } else if (action.equals("deleteService")) {
            String serviceId = request.getParameter("service_id");
            serviceDAO.deleteService(serviceId);
            response.sendRedirect("ManageServiceServlet?action=listServices");
        }
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "ManageServiceServlet";
    }// </editor-fold>

}
