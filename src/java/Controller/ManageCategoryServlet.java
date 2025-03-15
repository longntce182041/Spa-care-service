package Controller;

import DAO.CategoryDAO;
import Model.Category;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ManageCategoryServlet handles category and product listing.
 */
@WebServlet("/ManageCategoryServlet")
public class ManageCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CategoryDAO categoryDAO = new CategoryDAO();

        if (action == null || action.equals("listCategories")) {
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("ManageCategory.jsp").forward(request, response);
        } else if (action.equals("viewProducts")) {
            String categoryId = request.getParameter("categoryId");

            // Debugging: Check if categoryId is received
            System.out.println("Category ID received: " + categoryId);

            if (categoryId != null && !categoryId.trim().isEmpty()) {
                List<Product> products = categoryDAO.getProductsByCategory(categoryId);

                // Debugging: Check if products are retrieved
                System.out.println("Products retrieved: " + (products != null ? products.size() : "NULL"));

                request.setAttribute("products", products);
            } else {
                System.out.println("categoryId is null or empty.");
            }

            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.getRequestDispatcher("ManageCategory.jsp").forward(request, response);
        } else if (action.equals("addCategory")) {
            // Extract form parameters for new category
            String catId = request.getParameter("category_id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Category newCategory = new Category(catId, name, description);
            categoryDAO.addCategory(newCategory);
            // Redirect back to list
            response.sendRedirect("ManageCategoryServlet?action=listCategories");
        } else if (action.equals("deleteCategory")) {
            String catId = request.getParameter("category_id");
            categoryDAO.deleteCategory(catId);
            response.sendRedirect("ManageCategoryServlet?action=listCategories");
        } else if (action.equals("updateCategory")) {
            String catId = request.getParameter("category_id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Category updatedCategory = new Category(catId, name, description);
            categoryDAO.updateCategory(updatedCategory);
            response.sendRedirect("ManageCategoryServlet?action=listCategories");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "ManageCategoryServlet";
    }
}
