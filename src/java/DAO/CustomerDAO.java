/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import ConnectDB.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Controller.Customer;

/**
 *
 * @author Nguyen Thanh Long - CE182041
 */
public class CustomerDAO {

    public static List<Customer> getAllProducts() {
        List<Customer> customerList = new ArrayList<>();
        try ( Connection conn = DBConnect.getConnection();  Statement stmt = conn.createStatement();  ResultSet rs = stmt.executeQuery("select * from Customers")) {
            while (rs.next()) {
                Customer customer = new Customer(rs.getInt("customer_id"),
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("address"));
                customerList.add(customer);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return customerList;
    }

    public static Customer getCustomerId(int CustomerId) {
        Customer customer = null;
        try ( Connection conn = DBConnect.getConnection();  PreparedStatement stmt = conn.prepareStatement("select * from Customers where customer_id = ?")) {
            stmt.setInt(1, CustomerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                customer = new Customer(rs.getInt("customer_is"), rs.getInt("user_id"), rs.getString("full_name"), rs.getString("address"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

}
