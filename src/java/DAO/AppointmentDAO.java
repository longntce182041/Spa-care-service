package DAO;

import Model.Appointment;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.*;

public class AppointmentDAO {

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Appointments");

            while (rs.next()) {
                list.add(new Appointment(
                        rs.getInt("appointment_id"),
                        rs.getInt("user_id"), // Lấy thông tin user_id
                        rs.getInt("pet_id"),
                        rs.getInt("service_id"),
                        rs.getInt("staff_id"),
                        rs.getTimestamp("appointment_date"),
                        rs.getString("status")
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

    public void confirmAppointment(int appointmentId) {
        String sql = "UPDATE Appointments SET status = 'Confirmed' WHERE appointment_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);
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

    public void cancelAppointment(int appointmentId) {
        String sql = "UPDATE Appointments SET status = 'Cancelled' WHERE appointment_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);
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

    public void deleteAppointment(int appointmentId) {
        String sql = "DELETE FROM Appointments WHERE appointment_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnect.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);
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