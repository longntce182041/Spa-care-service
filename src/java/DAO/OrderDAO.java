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

            String orderSql = "INSERT INTO Orders (order_date, total_price, status, promotion_id, user_id, product_id, name, phone, email, address, payment_method) VALUES (CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setDouble(1, order.getTotalPrice());
            orderStmt.setString(2, order.getStatus());
            if (order.getPromotionId() != null) {
                orderStmt.setInt(3, order.getPromotionId());
            } else {
                orderStmt.setNull(3, Types.INTEGER);
            }
            orderStmt.setInt(4, order.getUserId());
            orderStmt.setInt(5, order.getProductId());
            orderStmt.setString(6, order.getName());
            orderStmt.setString(7, order.getPhone());
            orderStmt.setString(8, order.getEmail());
            orderStmt.setString(9, order.getAddress());
            orderStmt.setString(10, order.getPaymentMethod());
            orderStmt.executeUpdate();

            rs = orderStmt.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // In ra console để kiểm tra
            System.out.println("Order ID: " + orderId);

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

    public Order getOrderById(int orderId) {
        Order order = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            if (conn == null) {
                throw new SQLException("Unable to connect to database");
            }
            String sql = "SELECT * FROM Orders WHERE order_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderDate(rs.getTimestamp("order_date")); // Lấy giá trị order_date từ cơ sở dữ liệu
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setPromotionId(rs.getInt("promotion_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setName(rs.getString("name"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setAddress(rs.getString("address"));
                order.setPaymentMethod(rs.getString("payment_method"));
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
        return order;
    }
}