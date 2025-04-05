/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import ConnectDB.DBConnect;
import Model.Staff;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class StaffDAO {

    public static List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM Staff";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Staff staff = new Staff(
                    rs.getString("staff_id"),
                    rs.getString("full_name"),
                    rs.getString("position"),
                    rs.getString("phone"),
                    rs.getString("user_id"),
                    rs.getString("role"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("img")
                );
                list.add(staff);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static Staff getStaffById(String staffId) {
        String sql = "SELECT * FROM Staff WHERE staff_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Staff(
                    rs.getString("staff_id"),
                    rs.getString("full_name"),
                    rs.getString("position"),
                    rs.getString("phone"),
                    rs.getString("user_id"),
                    rs.getString("role"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("img")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean addStaff(Staff staff) {
        String sql = "INSERT INTO Staff (staff_id, full_name, position, phone, user_id, role, email, password, img) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staff.getStaffId());
            ps.setString(2, staff.getFullName());
            ps.setString(3, staff.getPosition());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getUserId());
            ps.setString(6, staff.getRole());
            ps.setString(7, staff.getEmail());
            ps.setString(8, staff.getPassword());
            ps.setString(9, staff.getImg());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateStaff(Staff staff) {
        String sql = "UPDATE Staff SET full_name=?, position=?, phone=?, user_id=?, role=?, email=?, password=?, img=? WHERE staff_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staff.getFullName());
            ps.setString(2, staff.getPosition());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getUserId());
            ps.setString(5, staff.getRole());
            ps.setString(6, staff.getEmail());
            ps.setString(7, staff.getPassword());
            ps.setString(8, staff.getImg());
            ps.setString(9, staff.getStaffId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deleteStaff(String staffId) {
        String sql = "DELETE FROM Staff WHERE staff_id=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staffId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}