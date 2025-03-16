/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import ConnectDB.DBConnect;
import Model.Service;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {
//    public static void main(String[] args) {
//        List<Service> services = getAllServices();
//        for (Service service : services) {
//            System.out.println(service);
//        }
//    }

    public static List<Service> getAllServices() {
        List<Service> serviceList = new ArrayList<>();
        String sql = "SELECT service_id, name, description, price, image_url, category_id FROM Services";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Service service = new Service(
                        rs.getString("service_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getString("category_id")
                );
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Loaded services: " + serviceList.size());

        return serviceList;
    }

    // Thay thế phương thức getServiceById cũ bằng đoạn code mới này
    public Service getServiceById(int serviceId) {
        String sql = "SELECT service_id, name, description, price, image_url, category_id FROM Services WHERE service_id = ?";
        try ( Connection conn = new DBConnect().getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            System.out.println("Connecting to database..."); // Debug
            System.out.println("Executing SQL: " + sql);
            System.out.println("Service ID parameter: " + serviceId);

            pstmt.setInt(1, serviceId);
            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("✅ Service found: " + rs.getString("name")); // Debug

                    return new Service(
                            rs.getString("service_id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("image_url"),
                            rs.getString("category_id")
                    );
                } else {
                    System.out.println("❌ Service not found for ID: " + serviceId); // Debug
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean insertRating(String userId, int serviceId, int ratingStar, String comment) {
        String sql = "INSERT INTO Ratings (user_id, service_id, rating_star, comment) VALUES (?, ?, ?, ?)";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            pstmt.setInt(2, serviceId);
            pstmt.setInt(3, ratingStar);
            pstmt.setString(4, comment);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // get all service by category_id
    public static List<Service> getAllServicesByCategory(String categoryId) {
        List<Service> serviceList = new ArrayList<>();
        String sql = "SELECT s.* FROM Services s JOIN Service_Categories sc ON s.category_id = sc.category_id WHERE sc.name = ?";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, categoryId);

            try ( ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Service service = new Service(
                            rs.getString("service_id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("image_url"),
                            rs.getString("category_id")
                    );
                    serviceList.add(service);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return serviceList;
    }
    //add service
    public static boolean addService(Service service) {
        String sql = "INSERT INTO Services (name, description, price, image_url, category_id) VALUES (?, ?, ?, ?, ?)";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, service.getName());
            pstmt.setString(2, service.getDescription());
            pstmt.setDouble(3, service.getPrice());
            pstmt.setString(4, service.getImage_url());
            pstmt.setString(5, service.getCategory_id());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    //update service
    public static boolean updateService(Service service) {
        String sql = "UPDATE Services SET name = ?, description = ?, price = ?, image_url = ?, category_id = ? WHERE service_id = ?";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, service.getName());
            pstmt.setString(2, service.getDescription());
            pstmt.setDouble(3, service.getPrice());
            pstmt.setString(4, service.getImage_url());
            pstmt.setString(5, service.getCategory_id());
            pstmt.setString(6, service.getService_id());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    //delete service    
    public static boolean deleteService(String serviceId) {
        String sql = "DELETE FROM Services WHERE service_id = ?";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, serviceId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // delete rating
    public static boolean deleteRating(int ratingId) {
        String sql = "DELETE FROM Ratings WHERE rating_id = ?";

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, ratingId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // delete service by category_id
    public static boolean deleteServiceByCategory(String categoryId) {
        String sql = "DELETE FROM Services WHERE category_id = ?";   

        try ( Connection conn = DBConnect.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        
                pstmt.setString(1, categoryId);
    
                int rowsAffected = pstmt.executeUpdate();
                return rowsAffected > 0;
    
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
        }
    }
}
