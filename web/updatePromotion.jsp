<%-- 
    Document   : updatePromotion
    Created on : Mar 1, 2025, 6:31:15 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Promotion" %>
<%
    Promotion promo = (Promotion) request.getAttribute("promotion");
    if (promo == null) {
        response.sendRedirect("PromotionServlet");
        return;
    }
%>
<html>
<head>
    <title>Cập Nhật Khuyến Mãi</title>
    <link rel="stylesheet" type="text/css" href="css/addpromotionCss.css">
</head>
<body>
    <div class="container">
        <h2>Cập Nhật Khuyến Mãi</h2>

        <form action="UpdatePromotionServlet" method="post">
            <input type="hidden" name="id" value="<%= promo.getPromotionId() %>">
            
            <label for="name">Tên khuyến mãi:</label>
            <input type="text" id="name" name="name" value="<%= promo.getName() %>" required> <br>

            <label for="description">Mô tả:</label>
            <input type="text" id="description" name="description" value="<%= promo.getDescription() %>" required> <br>

            <label for="discountType">Loại giảm giá:</label>
            <select id="discountType" name="discountType">
                <option value="percent" <%= promo.getDiscountType().equals("percent") ? "selected" : "" %>>Phần trăm</option>
                <option value="fixed" <%= promo.getDiscountType().equals("fixed") ? "selected" : "" %>>Giá cố định</option>
            </select><br>

            <label for="discountValue">Giá trị giảm:</label>
            <input type="number" id="discountValue" name="discountValue" value="<%= promo.getDiscountValue() %>" required> <br>

            <label for="startDate">Ngày bắt đầu:</label>
            <input type="date" id="startDate" name="startDate" value="<%= promo.getStartDate() %>" required> <br>

            <label for="endDate">Ngày kết thúc:</label>
            <input type="date" id="endDate" name="endDate" value="<%= promo.getEndDate() %>" required> <br>

            <label for="minOrderValue">Giá trị đơn tối thiểu:</label>
            <input type="number" id="minOrderValue" name="minOrderValue" value="<%= promo.getMinOrderValue() %>"> <br>

            <label for="maxDiscount">Giảm tối đa:</label>
            <input type="number" id="maxDiscount" name="maxDiscount" value="<%= promo.getMaxDiscount() != null ? promo.getMaxDiscount() : "" %>"> <br>

            <label for="isActive">Trạng thái:</label>
            <input type="checkbox" id="isActive" name="isActive" <%= promo.isActive() ? "checked" : "" %>> Hoạt động <br>

            <input type="submit" value="Cập Nhật" class="btn btn-update">
            <a href="PromotionServlet" class="btn btn-cancel">Hủy</a>
        </form>
    </div>
</body>
</html>
