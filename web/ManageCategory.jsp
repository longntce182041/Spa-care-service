<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Category" %>
<%@ page import="Model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Manage Categories</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/Style_admin_dashboard.css">
    <link rel="stylesheet" href="css/Style_manageProduct.css">
    
    <style>
      .category-list { margin-top: 20px; }
      .category-item { cursor: pointer; color: #007bff; }
      .category-item:hover { text-decoration: underline; }
      .modal-header { background-color: #007bff; color: #fff; }
      /* Adjust main content padding if needed */
      #content { padding: 20px; }
    </style>
  </head>
  <body>
    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <a class="navbar-brand" href="admin_Dashboard.jsp"><i class="fa fa-dashboard"></i> Dashboard</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" 
              aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </nav>
    
    <div class="wrapper d-flex align-items-stretch">
      <!-- Sidebar -->
      <nav id="sidebar">
        <div class="p-4 pt-5">
          <a class="navbar-brand" href="admin_Dashboard.jsp">
            <span class="flaticon-pawprint-1 mr-2"></span>Petique Spa
          </a>
          <ul class="list-unstyled components mb-5">
            <li><a href="ManageProductsServlet">Manage Products</a></li>
            <li class="active"><a href="ManageCategoryServlet">Manage Categories</a></li>
            <li><a href="ManageOrders.jsp">Manage Orders</a></li>
            <li><a href="ManageCustomerServlet">Manage Users</a></li>
            <li><a href="StaffServlet">Manage Staff</a></li>
            <li><a href="PromotionServlet">Manage Promotion</a></li>
          </ul>
        </div>
      </nav>
      
      <!-- Page Content -->
      <div id="content" class="p-4 p-md-5">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
          <a class="navbar-brand" href="#">Manage Categories</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCat" 
                  aria-controls="navbarCat" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
        </nav>
        <h2 class="mb-4">Manage Categories</h2>
        
        <div class="row">
          <!-- Categories List -->
          <div class="col-md-4">
            <h4>Categories</h4>
            <ul class="list-group category-list">
              <c:forEach var="category" items="${categories}">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                  <span onclick="viewProducts('<c:out value='${category.category_id}'/>')" class="category-item">
                    <c:out value="${category.name}" />
                  </span>
                  <span>
                    <!-- Edit Button -->
                    <button type="button" class="btn btn-sm btn-warning" data-toggle="modal" data-target="#editCategoryModal" 
                            data-id="${category.category_id}" data-name="${category.name}" data-description="${category.description}">
                      Edit
                    </button>
                    <!-- Delete Form -->
                    <form action="ManageCategoryServlet" method="post" style="display:inline;">
                      <input type="hidden" name="action" value="deleteCategory">
                      <input type="hidden" name="category_id" value="${category.category_id}">
                      <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                    </form>
                  </span>
                </li>
              </c:forEach>
            </ul>
            <br/>
            <!-- Button trigger add category modal -->
            <button class="btn btn-primary" data-toggle="modal" data-target="#addCategoryModal">Add Category</button>
          </div>
          
          <!-- Products List -->
          <div class="col-md-8">
            <h4>Products in Selected Category</h4>
            <div class="product-list">
              <c:choose>
                <c:when test="${not empty products}">
                  <table class="table table-bordered">
                    <thead class="thead-dark">
                      <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Image</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="product" items="${products}">
                        <tr>
                          <td><c:out value="${product.name}" /></td>
                          <td><c:out value="${product.description}" /></td>
                          <td><c:out value="${product.price}" /></td>
                          <td><c:out value="${product.stockQuantity}" /></td>
                          <td>
                            <img src="<c:out value='${product.image_url}' />" alt="<c:out value='${product.name}' />" style="width: 100px; height: auto;">
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </c:when>
                <c:otherwise>
                  <p>No products available for this category.</p>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
        
        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form action="ManageCategoryServlet" method="post">
                <input type="hidden" name="action" value="addCategory">
                <div class="modal-body">
                  <div class="form-group">
                    <label for="category_id">Category ID</label>
                    <input type="text" class="form-control" id="category_id" name="category_id" required>
                  </div>
                  <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                  </div>
                  <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" required></textarea>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Add Category</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        
        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <form action="ManageCategoryServlet" method="post">
                <input type="hidden" name="action" value="updateCategory">
                <div class="modal-body">
                  <div class="form-group">
                    <label for="edit_category_id">Category ID</label>
                    <input type="text" class="form-control" id="edit_category_id" name="category_id" readonly>
                  </div>
                  <div class="form-group">
                    <label for="edit_name">Name</label>
                    <input type="text" class="form-control" id="edit_name" name="name" required>
                  </div>
                  <div class="form-group">
                    <label for="edit_description">Description</label>
                    <textarea class="form-control" id="edit_description" name="description" required></textarea>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Update Category</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
          function viewProducts(categoryId) {
            window.location.href = 'ManageCategoryServlet?action=viewProducts&categoryId=' + categoryId;
          }
          
          // Populate the Edit Category Modal fields when triggered
          $('#editCategoryModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var catId = button.data('id');
            var catName = button.data('name');
            var catDesc = button.data('description');
            var modal = $(this);
            modal.find('#edit_category_id').val(catId);
            modal.find('#edit_name').val(catName);
            modal.find('#edit_description').val(catDesc);
          });
        </script>
      </div>
    </div>
  </body>
</html>