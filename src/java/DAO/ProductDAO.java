package DAO;

import Model.Product;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.*;

public class ProductDAO {
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Products");

            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("product_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock_quantity"),
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

    public boolean productExists(int productId) {
        String sql = "SELECT COUNT(*) FROM Products WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
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
        return false;
    }
}