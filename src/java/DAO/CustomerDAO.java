///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package DAO;
//
//import ConnectDB.DBConnect;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//import Model.Customer;
//
///**
// *
// * @author Nguyen Thanh Long - CE182041
// */
//public class CustomerDAO {
//
//    public static List<Customer> getAllCustomer() {
//        List<Customer> customerList = new ArrayList<>();
//        try (Connection conn = DBConnect.getConnection(); 
//             Statement stmt = conn.createStatement(); 
//             ResultSet rs = stmt.executeQuery("SELECT * FROM Users WHERE role = 'customer'")) {
//            while (rs.next()) {
//                Customer customer = new Customer(
//                        rs.getInt("user_id"), 
//                        rs.getString("username"),
//                        rs.getString("email"), 
//                        rs.getString("full_name"), 
//                        rs.getString("address"), 
//                        rs.getString("phone"));
//                customerList.add(customer);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return customerList;
//    }
//
//    public static Customer getCustomerById(int customerId) {
//        Customer customer = null;
//        try (Connection conn = DBConnect.getConnection(); 
//             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Users WHERE user_id = ? AND role = 'customer'")) {
//            stmt.setInt(1, customerId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                customer = new Customer(
//                        rs.getInt("user_id"), 
//                        rs.getString("username"),
//                        rs.getString("email"), 
//                        rs.getString("full_name"), 
//                        rs.getString("address"), 
//                        rs.getString("phone"));
//            }
//            rs.close();
//            stmt.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return customer;
//    }
//
//}
