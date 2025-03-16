<%-- 
    Document   : RatingService
    Created on : Mar 15, 2025, 5:18:44 PM
    Author     : TruongMinhDan CE181520
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, java.util.ArrayList" %>
<%@page import="Model.Service" %>
<% 
    List<Service> services = (List<Service>) session.getAttribute("services_list"); 
    if (services == null) {
         response.sendRedirect("ServiceRatingServlet"); 
        return;// Tránh lỗi NullPointerException
    }
    
    String status = request.getParameter("status");

%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rating</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin=" anonymous"></script>
        <link rel="stylesheet" href="./css/rating.css">
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll('.btn-check').forEach(function (input) {
                    input.addEventListener('click', function () {
                        if (this.hasAttribute('data-checked')) {
                            this.removeAttribute('data-checked');
                            this.checked = false;
                        } else {
                            document.querySelectorAll('.btn-check').forEach(el => el.removeAttribute('data-checked'));
                            this.setAttribute('data-checked', 'true');
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <div class="container mt-5 w-50 ">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-center mb-0">Rating Service Petique Spa</h3>
                </div>
                <div class="card-body">

                    <%-- Hiển thị thông báo --%>
                    <% if ("success".equals(status)) { %>
                    <div class="alert alert-success">Thank you! Your feedback has been submitted.</div>
                    <% } else if ("error".equals(status)) { %>
                    <div class="alert alert-danger">Error submitting feedback. Please try again.</div>
                    <% } %>

                    <form action="ServiceRatingServlet" method="POST">
                        <!-- Chọn dịch vụ -->
                        <div class="mb-4 ">
                            <label class="form-label">Select service:</label>
                            <div class="w-auto group-services "> 
                                <% if (!services.isEmpty()) { %>
                                <% for (Service service : services) { %>
                                <input type="radio" class="btn-check" name="service" id="service<%= service.getServiceId() %>" value="<%= service.getServiceId() %>" autocomplete="off">
                                <label class="btn btn-outline-primary" for="service<%= service.getServiceId() %>">
                                    <%= service.getName() %>
                                </label>
                                <% } %>
                                <% } else { %>
                                <p class="text-danger">No services available.</p>
                                <% } %>
                            </div>
                        </div>

                        <!-- Đánh giá sao -->
                        <div class="mb-4">
                            <label class="form-label">Rating service:</label>
                            <div class="rating d-flex justify-content-center flex-row-reverse">
                                <input type="radio" id="star5" name="rating" value="5"/><label for="star5">★</label>
                                <input type="radio" id="star4" name="rating" value="4"/><label for="star4">★</label>
                                <input type="radio" id="star3" name="rating" value="3"/><label for="star3">★</label>
                                <input type="radio" id="star2" name="rating" value="2"/><label for="star2">★</label>
                                <input type="radio" id="star1" name="rating" value="1"/><label for="star1">★</label>
                            </div>
                        </div>

                        <!-- Bình luận -->
                        <div class="mb-4 comment">
                            <label class="form-label">Comnent:</label>
                            <textarea class="form-control " name="comment" rows="4" placeholder="Viết đánh giá của bạn..."></textarea>
                        </div>

                        <!-- Nút gửi đánh giá -->
                        <div class="btn-action">
                            <button type="submit" class="btn btn-back back-home" name="action" value="back">Back</button>
                            <button type="submit" class="btn btn-success" name="action" value="submitRating">Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
