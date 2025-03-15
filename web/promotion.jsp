<%-- 
    Document   : promotion
    Created on : Mar 2, 2025, 2:00:24 AM
    Author     : Nguyen Thanh Long - CE182041 
--%>

<%@ page import="java.util.List" %>
<%@ page import="Model.Promotion" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <title>Quản lý Khuyến mãi</title>
        <link rel="stylesheet" type="text/css" href="css/promotionCss.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    </head>
    <body>
        <!-- New Navbar with Icon and Search Box -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#"><i class="fa fa-dashboard"></i> Dashboard</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
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
                        <li>
                            <a href="ViewProductServlet">Manage Products</a>
                        </li>
                        <li>
                            <a href="ManageCategories.jsp">Manage Categories</a>
                        </li>
                        <li>
                            <a href="ManageOrders.jsp">Manage Orders</a>
                        </li>
                        <li>
                            <a href="ManageUsers.jsp">Manage Users</a>
                        </li>
                        <li>
                            <a href="ManageStaff.jsp">Manage Staff</a>
                        </li>
                        <li class="active">
                            <a href="PromotionServlet">Manage Promotion</a>
                        </li>
                    </ul>
                </div>
            </nav>
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
                <h2 class="md-4">Danh sách Khuyến mãi</h2>
                <div class="container">
                    <a href="addPromotion.jsp" class="btn btn-add">Thêm khuyến mãi mới</a>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên khuyến mãi</th>
                                    <th>Mô tả</th>
                                    <th>Loại giảm giá</th>
                                    <th>Giá trị giảm</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                    <th>Đơn hàng tối thiểu</th>
                                    <th>Giảm tối đa</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Promotion> promotions = (List<Promotion>) request.getAttribute("promotions");
                                    if (promotions != null) {
                                        for (Promotion promo : promotions) {
                                %>
                                <tr>
                                    <td><%= promo.getPromotionId() %></td>
                                    <td><%= promo.getName() %></td>
                                    <td><%= promo.getDescription() %></td>
                                    <td><%= promo.getDiscountType() %></td>
                                    <td><%= promo.getDiscountValue() %>%</td>
                                    <td><%= promo.getStartDate() %></td>
                                    <td><%= promo.getEndDate() %></td>
                                    <td><%= promo.getMinOrderValue() %></td>
                                    <td><%= promo.getMaxDiscount() != null ? promo.getMaxDiscount() : "Không giới hạn" %></td>
                                    <td><%= promo.isActive() ? "Hoạt động" : "Không hoạt động" %></td>
                                    <td>
                                        <a href="UpdatePromotionServlet?id=<%= promo.getPromotionId() %>" class="btn btn-edit">Sửa</a>
                                        <a href="DeletePromotionServlet?id=<%= promo.getPromotionId() %>" class="btn btn-delete" onclick="return confirm('Xác nhận xóa?');">Xóa</a>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="11">Không có khuyến mãi nào.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
