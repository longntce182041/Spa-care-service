/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
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


