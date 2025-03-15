/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Category;
import Model.Product;
import ConnectDB.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Thanh Long - CE182041
 */
public class CategoryDAO {

    // Get all categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM Categories")) {
            while (rs.next()) {
                Category category = new Category(
                        rs.getString("category_id"),
                        rs.getString("name"),
                        rs.getString("description"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Get category by ID
    public Category getCategoryById(String categoryId) {
        Category category = null;
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Categories WHERE category_id = ?")) {
            stmt.setString(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                category = new Category(
                        rs.getString("category_id"),
                        rs.getString("name"),
                        rs.getString("description"));
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }

    // Add a new category
    public void addCategory(Category category) {
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO Categories (category_id, name, description) VALUES (?, ?, ?)")) {
            stmt.setString(1, category.getCategory_id());
            stmt.setString(2, category.getName());
            stmt.setString(3, category.getDescription());
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update an existing category
    public void updateCategory(Category category) {
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE Categories SET name = ?, description = ? WHERE category_id = ?")) {
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setString(3, category.getCategory_id());
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete a category
    public void deleteCategory(String categoryId) {
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM Categories WHERE category_id = ?")) {
            stmt.setString(1, categoryId);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get all products by category
    public List<Product> getProductsByCategory(String categoryId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.* FROM Products p WHERE p.category_id = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        categoryId);
                products.add(product);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}
