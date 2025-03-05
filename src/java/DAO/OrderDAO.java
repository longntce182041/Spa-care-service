package DAO;

import Model.Order;
import Model.OrderDetail;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int saveOrder(Order order, List<OrderDetail> orderDetails) {
        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement orderDetailStmt = null;
        ResultSet rs = null;
        int orderId = 0;

        try {
            conn = DBConnect.getConnection();
            if (conn == null) {
                throw new SQLException("Unable to connect to database");
            }
            conn.setAutoCommit(false);

            String orderSql = "INSERT INTO Orders (customer_id, order_date, total_price, status, promotion_id) VALUES (?, CURRENT_TIMESTAMP, ?, ?, ?)";
            orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, order.getCustomerId());
            orderStmt.setDouble(2, order.getTotalPrice());
            orderStmt.setString(3, order.getStatus());
            if (order.getPromotionId() != null) {
                orderStmt.setInt(4, order.getPromotionId());
            } else {
                orderStmt.setNull(4, Types.INTEGER);
            }
            orderStmt.executeUpdate();

            rs = orderStmt.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            String orderDetailSql = "INSERT INTO Order_Details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            orderDetailStmt = conn.prepareStatement(orderDetailSql);
            for (OrderDetail detail : orderDetails) {
                orderDetailStmt.setInt(1, orderId);
                orderDetailStmt.setInt(2, detail.getProductId());
                orderDetailStmt.setInt(3, detail.getQuantity());
                orderDetailStmt.setDouble(4, detail.getPrice());
                orderDetailStmt.addBatch();
            }
            orderDetailStmt.executeBatch();

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (orderStmt != null) orderStmt.close();
                if (orderDetailStmt != null) orderDetailStmt.close();
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            if (conn == null) {
                throw new SQLException("Unable to connect to database");
            }
            String sql = "SELECT * FROM Order_Details WHERE order_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderDetailId(rs.getInt("order_detail_id"));
                detail.setOrderId(rs.getInt("order_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));
                orderDetails.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderDetails;
    }
}