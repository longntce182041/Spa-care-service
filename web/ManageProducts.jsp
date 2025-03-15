<%-- 
    Document   : ManageProducts
    Created on : Feb 27, 2025, 5:29:56 AM
    Author     : Nguyen Thanh Long CE182041 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Manage Products</title>
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
            .modal-content {
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                border-bottom: none;
                position: relative;
            }

            .modal-header .close {
                position: absolute;
                right: 20px;
                top: 20px;
                font-size: 1.5rem;
                color: #000;
                opacity: 0.5;
            }

            .modal-header .close:hover {
                color: #000;
                opacity: 1;
            }

            .modal-title {
                font-size: 1.75rem;
                font-weight: bold;
                color: #333;
            }

            .modal-body img {
                max-width: 300px;
                height: auto;
                border-radius: 10px;
                margin-bottom: 20px;
            }

            .modal-body p {
                font-size: 1.1rem;
                color: #555;
                margin-bottom: 10px;
            }

            .modal-body strong {
                color: #333;
            }

            .modal-footer {
                border-top: none;
                text-align: right;
            }

            .modal-footer .btn {
                background-color: #28a745;
                color: #fff;
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 1rem;
            }

            .modal-footer .btn:hover {
                background-color: #218838;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <!-- New Navbar with Icon and Search Box -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#"><i class="fa fa-dashboard"></i> Dashboard</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
            </div>
        </nav>
        <div class="wrapper d-flex align-items-stretch">
            <nav id="sidebar">
                <div class="p-4 pt-5">
                    <a class="navbar-brand" href="index.jsp"><span class="flaticon-pawprint-1 mr-2"></span>Petique Spa</a>
                    <ul class="list-unstyled components mb-5">
                        <li>
                            <a href="admin_Dashboard.jsp">Dashboard</a>
                        </li>
                        <li class="active">
                            <a href="ViewProductServlet">Manage Products</a>
                        </li>
                        <li>
                            <a href="ManageCategoryServlet">Manage Categories</a>
                        </li>
                        <li>
                            <a href="OrderManagement.jsp">Manage Orders</a>
                        </li>
                        <li>
                            <a href="ManageCustomerServlet">Manage Users</a>
                        </li>
                        <li>
                            <a href="ManageStaff.jsp">Manage Staff</a>
                        </li>
                        <li>
                            <a href="PromotionServlet">Manage Promotion</a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Page Content  -->
            <div id="content" class="p-4 p-md-5">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                    <a class="navbar-brand" href="#">Admin Dashboard</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="logout.jsp"><i class="fa fa-sign-out"></i> Logout</a>
                            </li>
                        </ul>
                    </div>
                </nav>
                <h2 class="mb-4"></h2>
                <div class="container">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <p>Number of products: <c:out value="${fn:length(products)}"/></p>
                            <button class="btn btn-success mb-3" data-toggle="modal" data-target="#addProductModal">Add Product</button>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Images</th>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Inventory</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:catch var="error">
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td><img src="<c:out value="${product.image_url}"/>" alt="<c:out value="${product.name}"/>" class="img-thumbnail" style="width: 100px; height: auto;"></td>
                                                    <td><c:out value="${product.name}"/></td>
                                                    <td><c:out value="${product.price}"/> VND</td>
                                                    <td><c:out value="${product.stockQuantity}"/></td>
                                                    <td>
                                                        <button class="btn btn-info detail-button" 
                                                                data-name="<c:out value='${product.name}'/>" 
                                                                data-description="<c:out value='${product.description}'/>" 
                                                                data-price="<c:out value='${product.price}'/> VND"
                                                                data-stock="<c:out value='${product.stockQuantity}'/>" 
                                                                data-image="<c:out value='${product.image_url}'/>">
                                                            View Detail
                                                        </button>
                                                        <button class="btn btn-warning update-button" 
                                                                data-id="<c:out value='${product.productId}'/>" 
                                                                data-name="<c:out value='${product.name}'/>" 
                                                                data-description="<c:out value='${product.description}'/>" 
                                                                data-price="<c:out value='${product.price}'/> VND"
                                                                data-stock="<c:out value='${product.stockQuantity}'/>" 
                                                                data-category="<c:out value='${product.categoryId}'/>"
                                                                data-image="<c:out value='${product.image_url}'/>">
                                                            Update
                                                        </button>
                                                        <form action="ViewProductServlet" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="productId" value="<c:out value='${product.productId}'/>">
                                                            <button type="submit" class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:catch>
                                        <c:if test="${not empty error}">
                                            <script>console.error("Error rendering products: ${error}");</script>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3>No products available</h3>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Add Product Modal -->
                <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="ViewProductServlet" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="name">Name:</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description:</label>
                                        <input type="text" class="form-control" id="description" name="description" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Price:</label>
                                        <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="stockQuantity">Stock Quantity:</label>
                                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="categoryId">Category:</label>
                                        <select class="form-control" id="categoryId" name="categoryId" required>
                                            <c:forEach var="cat" items="${categories}">
                                                 <option value="${cat.category_id}">${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="imageUrl">Image URL:</label>
                                        <input type="text" class="form-control" id="imageUrl" name="imageUrl" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Add Product</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Update Product Modal -->
                <div class="modal fade" id="updateProductModal" tabindex="-1" role="dialog" aria-labelledby="updateProductModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateProductModalLabel">Update Product</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="ViewProductServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" id="updateProductId" name="productId">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="updateName">Name:</label>
                                        <input type="text" class="form-control" id="updateName" name="name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="updateDescription">Description:</label>
                                        <input type="text" class="form-control" id="updateDescription" name="description" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="updatePrice">Price:</label>
                                        <input type="number" step="0.01" class="form-control" id="updatePrice" name="price" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="updateStockQuantity">Stock Quantity:</label>
                                        <input type="number" class="form-control" id="updateStockQuantity" name="stockQuantity" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="updateCategoryId">Category:</label>
                                        <select class="form-control" id="updateCategoryId" name="categoryId" required>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.category_id}">${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="updateImageUrl">Image URL:</label>
                                        <input type="text" class="form-control" id="updateImageUrl" name="imageUrl" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Update Product</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Modal popup -->
                <div id="productModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2 id="modalTitle"></h2>
                        <img id="modalImage" class="img-fluid" style="width: 200px; height: auto;">
                        <p><strong>Describe:</strong> <span id="modalDescription"></span></p>
                        <p><strong>Price:</strong> <span id="modalPrice"></span></p>
                        <p><strong>Inventory:</strong> <span id="modalStock"></span></p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                try {
                    let modal = document.getElementById("productModal");
                    let modalTitle = document.getElementById("modalTitle");
                    let modalImage = document.getElementById("modalImage");
                    let modalDescription = document.getElementById("modalDescription");
                    let modalPrice = document.getElementById("modalPrice");
                    let modalStock = document.getElementById("modalStock");
                    let closeBtn = document.querySelector(".close");

                    document.querySelectorAll(".detail-button").forEach(button => {
                        button.addEventListener("click", function () {
                            try {
                                modalTitle.innerText = this.getAttribute("data-name");
                                modalImage.src = this.getAttribute("data-image");
                                modalDescription.innerText = this.getAttribute("data-description");
                                modalPrice.innerText = this.getAttribute("data-price");
                                modalStock.innerText = this.getAttribute("data-stock");
                                modal.style.display = "block";
                            } catch (error) {
                                console.error("Lỗi khi mở modal:", error);
                            }
                        });
                    });

                    document.querySelectorAll(".update-button").forEach(button => {
                        button.addEventListener("click", function () {
                            try {
                                document.getElementById("updateProductId").value = this.getAttribute("data-id");
                                document.getElementById("updateName").value = this.getAttribute("data-name");
                                document.getElementById("updateDescription").value = this.getAttribute("data-description");
                                document.getElementById("updatePrice").value = this.getAttribute("data-price").replace(' VND', '');
                                document.getElementById("updateStockQuantity").value = this.getAttribute("data-stock");
                                document.getElementById("updateCategoryId").value = this.getAttribute("data-category");
                                document.getElementById("updateImageUrl").value = this.getAttribute("data-image");
                                $('#updateProductModal').modal('show');
                            } catch (error) {
                                console.error("Lỗi khi mở modal cập nhật:", error);
                            }
                        });
                    });

                    closeBtn.addEventListener("click", function () {
                        try {
                            modal.style.display = "none";
                        } catch (error) {
                            console.error("Lỗi khi đóng modal:", error);
                        }
                    });

                    window.addEventListener("click", function (event) {
                        try {
                            if (event.target === modal) {
                                modal.style.display = "none";
                            }
                        } catch (error) {
                            console.error("Lỗi khi ẩn modal:", error);
                        }
                    });
                } catch (error) {
                    console.error("Lỗi khi tải script:", error);
                }
            });
        </script>

        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.timepicker.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
