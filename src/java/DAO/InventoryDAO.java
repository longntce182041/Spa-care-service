package DAO;

import Model.Inventory;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.*;

public class InventoryDAO {
    public List<Inventory> getAllInventory() {
        List<Inventory> list = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Inventory");

            while (rs.next()) {
                list.add(new Inventory(
                    rs.getInt("inventory_id"),
                    rs.getInt("product_id"),
                    rs.getInt("staff_id"),
                    rs.getInt("quantity"),
                    rs.getString("type"),
                    rs.getString("image_url")
                ));
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
        return list;
    }

    public void addInventory(Inventory inventory) {
        String sql = "INSERT INTO Inventory (product_id, staff_id, quantity, type, image_url) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, inventory.getProductId());
            stmt.setInt(2, inventory.getStaffId());
            stmt.setInt(3, inventory.getQuantity());
            stmt.setString(4, inventory.getType());
            stmt.setString(5, inventory.getimage_url());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean removeInventory(int id, int quantity) {
        String sqlUpdate = "UPDATE Inventory SET quantity = quantity - ? WHERE inventory_id = ?";
        String sqlSelect = "SELECT quantity FROM Inventory WHERE inventory_id = ?";
        String sqlDelete = "DELETE FROM Inventory WHERE inventory_id = ?";
        Connection conn = null;
        PreparedStatement stmtUpdate = null;
        PreparedStatement stmtSelect = null;
        PreparedStatement stmtDelete = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Giảm số lượng sản phẩm
            stmtUpdate = conn.prepareStatement(sqlUpdate);
            stmtUpdate.setInt(1, quantity);
            stmtUpdate.setInt(2, id);
            stmtUpdate.executeUpdate();

            // Kiểm tra số lượng sản phẩm
            stmtSelect = conn.prepareStatement(sqlSelect);
            stmtSelect.setInt(1, id);
            rs = stmtSelect.executeQuery();

            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                if (currentQuantity <= 0) {
                    // Xóa sản phẩm nếu số lượng <= 0
                    stmtDelete = conn.prepareStatement(sqlDelete);
                    stmtDelete.setInt(1, id);
                    stmtDelete.executeUpdate();
                    conn.commit(); // Commit transaction
                    return true; // Sản phẩm đã bị xóa
                }
            }

            conn.commit(); // Commit transaction nếu không xóa sản phẩm
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmtUpdate != null) stmtUpdate.close();
                if (stmtSelect != null) stmtSelect.close();
                if (stmtDelete != null) stmtDelete.close();
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false; // Sản phẩm không bị xóa
    }
}