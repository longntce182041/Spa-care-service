<%@ page import="java.util.List" %>
<%@ page import="Controller.Promotion" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Quản lý Khuyến mãi</title>
    <link rel="stylesheet" type="text/css" href="css/promotionCss.css">
</head>
<body>
    <div class="container">
        <h2>Danh sách Khuyến mãi</h2>
        <a href="addPromotion.jsp" class="btn btn-add">Thêm khuyến mãi mới</a>
        <table>
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
        </table>
    </div>
</body>
</html>
