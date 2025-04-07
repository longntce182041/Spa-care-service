package DAO;

import Model.Consultation;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.*;

public class ConsultationDAO {

    public void addConsultation(Consultation consultation) {
        String sql = "INSERT INTO Consultation (message, consultation_name, phone_number, date, time) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, consultation.getMessage());
            stmt.setString(2, consultation.getConsultationName());
            stmt.setString(3, consultation.getPhoneNumber());
            stmt.setDate(4, consultation.getDate());
            stmt.setTime(5, consultation.getTime());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void updateConsultationStatus(int consultationId, String status) {
        String sql = "UPDATE Consultation SET Consultation_status = ? WHERE consultation_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, consultationId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Consultation> getAllConsultations() {
        List<Consultation> consultations = new ArrayList<>();
        String sql = "SELECT * FROM Consultation";
        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                consultations.add(new Consultation(
                    rs.getInt("consultation_id"),
                    rs.getString("message"),
                    rs.getString("consultation_name"),
                    rs.getString("phone_number"),
                    rs.getDate("date"),
                    rs.getTime("time"),
                    rs.getString("Consultation_status") // Lấy trạng thái
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consultations;
    }
}
