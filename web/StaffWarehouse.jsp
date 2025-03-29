<%@ page import="java.sql.*, java.util.*, DAO.InventoryDAO, Model.Inventory" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Staff Warehouse Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/staffdashboard.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Staff Warehouse Dashboard</h2>
        <div class="actions mb-4 text-center">
            <button class="btn btn-primary" data-toggle="modal" data-target="#stockReceivingModal">Stock Receiving</button>
            <button class="btn btn-primary" data-toggle="modal" data-target="#stockDeliveringModal">Stock Delivering</button>
        </div>
        <div id="inventoryTableContainer">
            <table class="inventory-table table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Product ID</th>
                        <th>Staff ID</th>
                        <th>Quantity</th>
                        <th>Type</th>
                        <th>Images</th>
                        <th>Category ID</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="inventoryTableBody">
                    <%
                        InventoryDAO dao = new InventoryDAO();
                        List<Inventory> inventoryList = dao.getAllInventory();
                        for (Inventory item : inventoryList) {
                    %>
                    <tr>
                        <td><%= item.getInventoryId() %></td>
                        <td><%= item.getProductId() %></td>
                        <td><%= item.getStaffId() %></td>
                        <td><%= item.getInventoryQuantity() %></td>
                        <td><%= item.getInventoryType() %></td>
                        <td><img src="<%= item.getInventoryImageUrl() %>" alt="Product Image" style="width: 100px; height: auto;"></td>
                        <td><%= item.getProductCategoryId() %></td>
                        <td>
                            <button class="btn btn-primary" data-toggle="modal" data-target="#editInventoryModal" onclick="loadInventoryData(<%= item.getInventoryId() %>)">
                                <i class="fa fa-pencil"></i> 
                            </button>
                            <button class="btn btn-danger" onclick="deleteInventory(<%= item.getInventoryId() %>)">
                                <i class="fa fa-trash"></i> 
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal for Stock Receiving -->
    <div class="modal fade" id="stockReceivingModal" tabindex="-1" role="dialog" aria-labelledby="stockReceivingModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="stockReceivingModalLabel">Stock Receiving</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="stockReceivingForm" method="POST" action="AddInventoryServlet">
                        <div class="form-group">
                            <label for="productId">Product ID:</label>
                            <input type="text" class="form-control" id="productId" name="productId" required>
                        </div>
                        <div class="form-group">
                            <label for="staffId">Staff ID:</label>
                            <input type="text" class="form-control" id="staffId" name="staffId" required>
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" required>
                        </div>
                        <div class="form-group">
                            <label for="type">Type:</label>
                            <input type="text" class="form-control" id="type" name="type" required>
                        </div>
                        <div class="form-group">
                            <label for="image_url">Image URL:</label>
                            <input type="text" class="form-control" id="image_url" name="image_url" required>
                        </div>
                        <div class="form-group">
                            <label for="categoryId">Category ID:</label>
                            <input type="text" class="form-control" id="categoryId" name="categoryId" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Inventory</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Stock Delivering -->
    <div class="modal fade" id="stockDeliveringModal" tabindex="-1" role="dialog" aria-labelledby="stockDeliveringModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="stockDeliveringModalLabel">Stock Delivering</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="stockDeliveringForm">
                        <div class="form-group">
                            <label for="inventoryId">Inventory ID:</label>
                            <select class="form-control" id="inventoryId" name="inventoryId" required>
                                <%
                                    List<Inventory> inventoryListForSelect = dao.getAllInventory();
                                    for (Inventory inventory : inventoryListForSelect) {
                                %>
                                    <option value="<%= inventory.getInventoryId() %>"><%= inventory.getInventoryId() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Export</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Editing Inventory -->
    <div class="modal fade" id="editInventoryModal" tabindex="-1" role="dialog" aria-labelledby="editInventoryModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editInventoryModalLabel">Edit Inventory</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editInventoryForm">
                        <input type="hidden" id="editInventoryId" name="inventoryId">
                        <div class="form-group">
                            <label for="editProductId">Product ID:</label>
                            <input type="text" class="form-control" id="editProductId" name="productId" readonly>
                        </div>
                        <div class="form-group">
                            <label for="editStaffId">Staff ID:</label>
                            <input type="text" class="form-control" id="editStaffId" name="staffId" readonly>
                        </div>
                        <div class="form-group">
                            <label for="editQuantity">Quantity:</label>
                            <input type="number" class="form-control" id="editQuantity" name="quantity" required>
                        </div>
                        <div class="form-group">
                            <label for="editType">Type:</label>
                            <input type="text" class="form-control" id="editType" name="type" required>
                        </div>
                        <div class="form-group">
                            <label for="editImageUrl">Image URL:</label>
                            <input type="text" class="form-control" id="editImageUrl" name="image_url" required>
                        </div>
                        <div class="form-group">
                            <label for="editCategoryId">Category ID:</label>
                            <input type="text" class="form-control" id="editCategoryId" name="categoryId" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
    <script>
        // Handle form submissions for stock receiving
        $('#stockReceivingForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: 'AddInventoryServlet',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#stockReceivingModal').modal('hide');
                    updateInventoryTable(); // Update the inventory table without reloading the page
                    removeModalBackdrop(); // Remove modal backdrop
                },
                error: function() {
                    alert('Error processing request.');
                }
            });
        });

        // Handle form submissions for stock delivering
        $('#stockDeliveringForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: 'RemoveInventoryServlet',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#stockDeliveringModal').modal('hide');
                    updateInventoryTable(); // Update the inventory table without reloading the page
                    removeModalBackdrop(); // Remove modal backdrop
                },
                error: function() {
                    alert('Error processing request.');
                }
            });
        });

        // Load inventory data into the edit modal
        function loadInventoryData(inventoryId) {
            $.ajax({
                url: 'GetInventoryServlet',
                method: 'GET',
                data: { inventoryId: inventoryId },
                success: function(data) {
                    // Điền dữ liệu vào các trường trong modal
            $('#editInventoryId').val(data.inventoryId);
            $('#editProductId').val(data.productId);
            $('#editStaffId').val(data.staffId);
            $('#editQuantity').val(data.inventoryQuantity);
            $('#editType').val(data.inventoryType);
            $('#editImageUrl').val(data.inventoryImageUrl);
            $('#editCategoryId').val(data.productCategoryId);
                },
                error: function() {
                    alert('Error loading inventory data.');
                }
            });
        }
        // Handle form submissions for editing inventory
        $('#editInventoryForm').on('submit', function(event) {
    event.preventDefault();
    console.log($(this).serialize()); // Log dữ liệu gửi đi
    $.ajax({
        url: 'UpdateInventoryServlet',
        method: 'POST',
        data: $(this).serialize(),
        success: function(response) {
            console.log("Response from UpdateInventoryServlet:", response); // Log phản hồi từ backend
            $('#editInventoryModal').modal('hide');
            updateInventoryTable(); // Update the inventory table without reloading the page
            removeModalBackdrop(); // Remove modal backdrop
        },
        error: function(xhr, status, error) {
            console.error("Error: " + error); // Log lỗi
            console.error("Response: " + xhr.responseText); // Log phản hồi lỗi
            alert('Error processing request.');
        }
    });
});
        // Function to update the inventory table without reloading the page
        function updateInventoryTable() {
    $.ajax({
        url: 'GetInventoryServlet',
        method: 'GET',
        success: function(data) {
            var inventoryTableBody = $('#inventoryTableBody');
            inventoryTableBody.empty();
            data.forEach(function(item) {
                var row = '<tr>' +
                    '<td>' + item.inventoryId + '</td>' +
                    '<td>' + item.productId + '</td>' +
                    '<td>' + item.staffId + '</td>' +
                    '<td>' + item.inventoryQuantity + '</td>' +
                    '<td>' + item.inventoryType + '</td>' +
                    '<td><img src="' + item.inventoryImageUrl + '" alt="Product Image" style="width: 100px; height: auto;"></td>' +
                    '<td>' + item.productCategoryId + '</td>' +
                    '<td><button class="btn btn-primary" data-toggle="modal" data-target="#editInventoryModal" onclick="loadInventoryData(' + item.inventoryId + ')"><i class="fa fa-pencil"></i> Edit</button><button class="btn btn-danger" onclick="deleteInventory(' + item.inventoryId + ')"><i class="fa fa-trash"></i> Delete</button></td>' +
                    '</tr>';
                inventoryTableBody.append(row);
            });
        },
        error: function(xhr, status, error) {
            console.error("Error: " + error); // Log lỗi
            console.error("Response: " + xhr.responseText); // Log phản hồi lỗi
            alert('Error updating inventory table.');
        }
    });
}

        // Function to remove modal backdrop
        function removeModalBackdrop() {
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open');
            $('body').css('padding-right', '');
        }

        // Function to delete inventory
        function deleteInventory(inventoryId) {
            if (confirm("Are you sure you want to delete this inventory item?")) {
                $.ajax({
                    url: 'DeleteInventoryServlet',
                    method: 'POST',
                    data: { inventoryId: inventoryId },
                    success: function(response) {
                        alert("Inventory item deleted successfully.");
                        updateInventoryTable(); // Cập nhật lại bảng sản phẩm
                    },
                    error: function(xhr, status, error) {
                        console.error("Error: " + error); // Log lỗi
                        console.error("Response: " + xhr.responseText); // Log phản hồi lỗi
                        alert('Error deleting inventory item.');
                    }
                });
            }
        }
    </script>
</body>
</html>