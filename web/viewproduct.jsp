<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Controller.Product" %>
<html>
<head>
    <title>List Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #28a745;
            color: white;
        }

        img {
            width: 100px;
            height: 100px;
            border-radius: 8px;
        }

        .detail-button {
            background-color: #28a745;
            color: white;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
            transition: 0.3s;
        }

        .detail-button:hover {
            background-color: #218838;
        }

        /* Modal popup */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            width: 50%;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: #555;
        }

        .close:hover {
            color: red;
        }

        .modal img {
            width: 200px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>List Products</h2>

        <% List<Product> products = (List<Product>) request.getAttribute("products"); %>

        <table>
            <tr>
                <th>Images</th>
                <th>Products Name</th>
                <th>Price</th>
                <th>Inventory</th>
                <th>Detail</th>
            </tr>
            <% for (Product product : products) { %>
            <tr>
                <td><img src="<%= product.getImageUrl() %>"></td>
                <td><%= product.getName() %></td>
                <td><%= product.getPrice() %> VND</td>
                <td><%= product.getStockQuantity() %></td>
                <td>
                    <button class="detail-button" 
                        data-name="<%= product.getName() %>" 
                        data-description="<%= product.getDescription() %>" 
                        data-price="<%= product.getPrice() %> VND"
                        data-stock="<%= product.getStockQuantity() %>"
                        data-image="<%= product.getImageUrl() %>">
                        View detail
                    </button>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- Modal popup -->
    <div id="productModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modalTitle"></h2>
            <img id="modalImage">
            <p><strong>Describe:</strong> <span id="modalDescription"></span></p>
            <p><strong>Price:</strong> <span id="modalPrice"></span></p>
            <p><strong>Inventory:</strong> <span id="modalStock"></span></p>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let modal = document.getElementById("productModal");
            let modalTitle = document.getElementById("modalTitle");
            let modalImage = document.getElementById("modalImage");
            let modalDescription = document.getElementById("modalDescription");
            let modalPrice = document.getElementById("modalPrice");
            let modalStock = document.getElementById("modalStock");
            let closeBtn = document.querySelector(".close");

            // Bắt sự kiện bấm nút "Xem chi tiết"
            document.querySelectorAll(".detail-button").forEach(button => {
                button.addEventListener("click", function() {
                    modalTitle.innerText = this.getAttribute("data-name");
                    modalImage.src = this.getAttribute("data-image");
                    modalDescription.innerText = this.getAttribute("data-description");
                    modalPrice.innerText = this.getAttribute("data-price");
                    modalStock.innerText = this.getAttribute("data-stock");
                    modal.style.display = "block";
                });
            });

            // Đóng popup khi bấm vào dấu 'x'
            closeBtn.addEventListener("click", function() {
                modal.style.display = "none";
            });

            // Đóng popup khi bấm bên ngoài
            window.addEventListener("click", function(event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            });
        });
    </script>

</body>
</html>
