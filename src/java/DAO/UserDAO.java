package DAO;

import ConnectDB.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Kiểm tra xem email có tồn tại trong bảng Users không
    public boolean isEmailRegistered(String email) {
        String query = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật OTP vào bảng Users
    public boolean updateOTP(String email, String otp) {
        String query = "UPDATE Users SET verification_code = ? WHERE email = ?";
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, otp);
            pstmt.setString(2, email);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra OTP có hợp lệ không
    public boolean verifyOTP(String email, String otp) {
        String query = "SELECT COUNT(*) FROM Users WHERE email = ? AND verification_code = ?";
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, otp);
            ResultSet rs = pstmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật mật khẩu mới cho user
    public boolean updatePassword(String email, String newPassword) {
        String query = "UPDATE Users SET password = ? WHERE email = ?";
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, newPassword);
            pstmt.setString(2, email);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Cập nhật trạng thái xác thực và đặt lại mã xác minh

    public boolean resetVerifiedCode(String email) {
        String query = "UPDATE Users SET is_verified = 1, verification_code = NULL WHERE email = ?";
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, email);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
