<%-- 
    Document   : ManageService
    Created on : Mar 17, 2025, 4:49:50 AM
    Author     : Nguyen Thanh Long - CE182041 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Service" %>
<%@ page import="Model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Manage Services</title>
    <!-- Using same CSS as ManageProducts.jsp -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/Style_manageProduct.css">
    <link rel="stylesheet" href="css/Style_admin_dashboard.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <style>
      .service-list { margin-top: 20px; }
      .modal-header { color: #fff; }
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
            <li class="active"><a href="ManageServiceServlet">Manage Services</a></li>
            <li><a href="ManageCategoryServlet">Manage Categories</a></li>
            <li><a href="OrderManagement.jsp">Manage Orders</a></li>
            <li><a href="ManageCustomerServlet">Manage Users</a></li>
            <li><a href="PromotionServlet">Manage Promotion</a></li>
          </ul>
        </div>
      </nav>
      
      <!-- Page Content -->
      <div id="content" class="p-4 p-md-5">
        <h1 class="mb-4">Manage Services</h1>
        <div class="row">
          <div class="col-md-12">
            <!-- Services Table -->
            <table class="table table-bordered">
              <thead class="thead-dark">
                <tr>
                  <th>Service ID</th>
                  <th>Name</th>
                  <th>Description</th>
                  <th>Price</th>
                  <th>Image</th>
                  <th>Category</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="service" items="${services}">
                  <tr>
                    <td><c:out value="${service.service_id}" /></td>
                    <td><c:out value="${service.name}" /></td>
                    <td><c:out value="${service.description}" /></td>
                    <td><c:out value="${service.price}" /></td>
                    <td>
                      <img src="<c:out value='${service.image_url}' />" alt="<c:out value='${service.name}' />" style="width:100px; height:auto;">
                    </td>
                    <td><c:out value="${service.category_id}" /></td>
                    <td>
                      <!-- Edit Button -->
                      <button type="button" class="btn btn-sm btn-warning" data-toggle="modal" data-target="#editServiceModal" 
                        data-id="${service.service_id}" data-name="${service.name}" data-description="${service.description}"
                        data-price="${service.price}" data-imageurl="${service.image_url}" data-category="${service.category_id}">
                        Edit
                      </button>
                      <!-- Delete Form -->
                      <form action="ManageServiceServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="deleteService">
                        <input type="hidden" name="service_id" value="${service.service_id}">
                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
            <!-- Button trigger add service modal -->
            <button class="btn btn-primary" data-toggle="modal" data-target="#addServiceModal">Add Service</button>
          </div>
        </div>
        
        <!-- Add Service Modal -->
        <div class="modal fade" id="addServiceModal" tabindex="-1" role="dialog" aria-labelledby="addServiceModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <form action="ManageServiceServlet" method="post">
                <div class="modal-header">
                  <h5 class="modal-title" id="addServiceModalLabel">Add Service</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <input type="hidden" name="action" value="addService">
                  <div class="form-group">
                    <label for="serviceName">Name</label>
                    <input type="text" class="form-control" id="serviceName" name="name" required>
                  </div>
                  <div class="form-group">
                    <label for="serviceDescription">Description</label>
                    <textarea class="form-control" id="serviceDescription" name="description" required></textarea>
                  </div>
                  <div class="form-group">
                    <label for="servicePrice">Price</label>
                    <input type="number" step="0.01" class="form-control" id="servicePrice" name="price" required>
                  </div>
                  <div class="form-group">
                    <label for="serviceImageUrl">Image URL</label>
                    <input type="text" class="form-control" id="serviceImageUrl" name="imageUrl" required>
                  </div>
                  <div class="form-group">
                    <label for="serviceCategory">Category</label>
                    <select class="form-control" id="serviceCategory" name="categoryId" required>
                      <c:forEach var="cat" items="${categories}">
                        <option value="${cat.category_id}">${cat.name}</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Add Service</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        
        <!-- Edit Service Modal -->
        <div class="modal fade" id="editServiceModal" tabindex="-1" role="dialog" aria-labelledby="editServiceModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <form action="ManageServiceServlet" method="post">
                <div class="modal-header">
                  <h5 class="modal-title" id="editServiceModalLabel">Edit Service</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <input type="hidden" name="action" value="updateService">
                  <div class="form-group">
                    <label for="editServiceId">Service ID</label>
                    <input type="text" class="form-control" id="editServiceId" name="service_id" readonly>
                  </div>
                  <div class="form-group">
                    <label for="editServiceName">Name</label>
                    <input type="text" class="form-control" id="editServiceName" name="name" required>
                  </div>
                  <div class="form-group">
                    <label for="editServiceDescription">Description</label>
                    <textarea class="form-control" id="editServiceDescription" name="description" required></textarea>
                  </div>
                  <div class="form-group">
                    <label for="editServicePrice">Price</label>
                    <input type="number" step="0.01" class="form-control" id="editServicePrice" name="price" required>
                  </div>
                  <div class="form-group">
                    <label for="editServiceImageUrl">Image URL</label>
                    <input type="text" class="form-control" id="editServiceImageUrl" name="imageUrl" required>
                  </div>
                  <div class="form-group">
                    <label for="editServiceCategory">Category</label>
                    <select class="form-control" id="editServiceCategory" name="categoryId" required>
                      <c:forEach var="cat" items="${categories}">
                        <option value="${cat.category_id}">${cat.name}</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Update Service</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        
      </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script>
      $('#editServiceModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var serviceId = button.data('id');
        var serviceName = button.data('name');
        var serviceDescription = button.data('description');
        var servicePrice = button.data('price');
        var serviceImageUrl = button.data('imageurl');
        var serviceCategory = button.data('category');
        
        var modal = $(this);
        modal.find('#editServiceId').val(serviceId);
        modal.find('#editServiceName').val(serviceName);
        modal.find('#editServiceDescription').val(serviceDescription);
        modal.find('#editServicePrice').val(servicePrice);
        modal.find('#editServiceImageUrl').val(serviceImageUrl);
        modal.find('#editServiceCategory').val(serviceCategory);
      });
    </script>
  </body>
</html>
