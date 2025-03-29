package DAO;

import Model.Consultation;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.*;

public class ConsultationDAO {

    public void addConsultation(Consultation consultation) {
        String sql = "INSERT INTO Consultation (message, name, phone_number, date, time, consultation_status) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, consultation.getMessage());
            stmt.setString(2, consultation.getName());
            stmt.setString(3, consultation.getPhoneNumber());
            stmt.setDate(4, consultation.getDate());
            stmt.setTime(5, consultation.getTime());
            stmt.setString(6, "Pending"); // Trạng thái mặc định là Pending
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Consultation> getAllConsultations() {
        List<Consultation> list = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Consultation");

            while (rs.next()) {
                list.add(new Consultation(
                        rs.getInt("consultation_id"),
                        rs.getString("message"),
                        rs.getString("name"),
                        rs.getString("phone_number"),
                        rs.getDate("date"),
                        rs.getTime("time"),
                        rs.getString("consultation_status") // Lấy consultation_status
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public void updateConsultationStatus(int consultationId, String consultationStatus) {
        String sql = "UPDATE Consultation SET consultation_status = ? WHERE consultation_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, consultationStatus);
            stmt.setInt(2, consultationId);

            System.out.println("Executing query: " + stmt.toString());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                DBConnect.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
