package DAO;

import ConnectDB.DBConnect;
import Model.Promotion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PromotionDAO {

    public Promotion getPromotionByCode(String promoCode) {
        String sql = "SELECT * FROM Promotion WHERE promotion_id = ? AND is_active = 1";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, promoCode);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setPromotionId(rs.getString("promotion_id"));
                promotion.setPromotionName(rs.getString("promotion_name"));
                promotion.setPromotionDescription(rs.getString("promotion_description"));
                promotion.setDiscountType(rs.getString("discount_type"));
                promotion.setDiscountValue(rs.getDouble("discount_value"));
                promotion.setStartDate(rs.getTimestamp("start_date"));
                promotion.setEndDate(rs.getTimestamp("end_date"));
                promotion.setMinOrderValue(rs.getDouble("min_order_value"));
                promotion.setMaxDiscount(rs.getDouble("max_discount"));
                promotion.setActive(rs.getBoolean("is_active"));
                return promotion;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}