<%-- 
    Document   : addPromotion
    Created on : Mar 1, 2025, 6:26:27 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Thêm Khuyến Mãi</title>
    <link rel="stylesheet" type="text/css" href="css/addpromotionCss.css">
</head>
<body>
    <div class="container">
        <h2>Thêm Khuyến Mãi Mới</h2>
        
        <form action="AddPromotionServlet" method="post">
            <label for="name">Tên khuyến mãi:</label>
            <input type="text" id="name" name="name" required> <br>

            <label for="description">Mô tả:</label>
            <input type="text" id="description" name="description" required> <br>

            <label for="discountType">Loại giảm giá:</label>
            <select id="discountType" name="discountType">
                <option value="percent">Phần trăm</option>
                <option value="fixed">Giá cố định</option>
            </select><br>

            <label for="discountValue">Giá trị giảm:</label>
            <input type="number" id="discountValue" name="discountValue" required> <br>

            <label for="startDate">Ngày bắt đầu:</label>
            <input type="date" id="startDate" name="startDate" required> <br>

            <label for="endDate">Ngày kết thúc:</label>
            <input type="date" id="endDate" name="endDate" required> <br>

            <label for="minOrderValue">Giá trị đơn tối thiểu:</label>
            <input type="number" id="minOrderValue" name="minOrderValue"> <br>

            <label for="maxDiscount">Giảm tối đa:</label>
            <input type="number" id="maxDiscount" name="maxDiscount"> <br>

            <label for="isActive">Trạng thái:</label>
            <input type="checkbox" id="isActive" name="isActive" checked> Hoạt động <br>

            <input type="submit" value="Thêm Khuyến Mãi" class="btn btn-add">
            <a href="PromotionServlet" class="btn btn-cancel">Hủy</a>
        </form>
    </div>
</body>
</html>

