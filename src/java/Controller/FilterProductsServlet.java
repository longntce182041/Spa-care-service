package Controller;

import DAO.ProductDAO;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/FilterProductsServlet")
public class FilterProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList;

        if (category == null || category.isEmpty()) {
            // Nếu danh mục là rỗng, lấy tất cả sản phẩm
            productList = productDAO.getAllProducts();
        } else {
            // Nếu danh mục không rỗng, lấy sản phẩm theo danh mục
            productList = productDAO.getProductsByCategory(category);
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        for (Product product : productList) {
            out.println("<div class='col-md-4 d-flex align-items-stretch'>");
            out.println("<div class='card mb-4 shadow-sm product-card' data-product-id='" + product.getProductId() + "'>");
            out.println("<img src='" + product.getimage_url() + "' class='card-img-top' alt='" + product.getName() + "'>");
            out.println("<div class='card-body'>");
            out.println("<h5 class='card-title'>" + product.getName() + "</h5>");
            out.println("<p class='card-text'>" + product.getDescription() + "</p>");
            out.println("<p class='card-text'><strong>Price: $" + product.getPrice() + "</strong></p>");
            out.println("<a href='javascript:void(0);' class='btn btn-outline-primary add-to-cart' data-product-id='" + product.getProductId() + "'><i class='fa fa-shopping-cart'></i> Add to Cart</a>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
        }
    }
}
