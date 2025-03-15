/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import ConnectDB.DBConnect;
import Model.Pet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Pet
 */
public class PetDAO {

    public List<Pet> getAllPets() {
        List<Pet> pets = new ArrayList<>();
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT * FROM Pets";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet(
                        rs.getString("pet_id"),
                        rs.getString("name"),
                        rs.getString("type"),
                        rs.getInt("age"),
                        rs.getString("user_id"),
                        rs.getDouble("weight_kg"),
                        rs.getString("note"));
                pets.add(pet);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pets;
    }

    public Pet getPetById(int petId) {
        Pet pet = null;
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT * FROM Pets WHERE pet_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, petId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                pet = new Pet(
                      rs.getString("pet_id"),
                        rs.getString("name"),
                        rs.getString("type"),
                        rs.getInt("age"),
                        rs.getString("user_id"),
                        rs.getDouble("weight_kg"),
                        rs.getString("note"));
                                    }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pet;
    }

    public boolean addPet(Pet pet) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = " INSERT INTO Pets (pet_id, name, type , age, user_id, weight_kg, note ) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, pet.getPet_id());
            stmt.setString(2, pet.getName_pet());
            stmt.setString(3, pet.getType());
            stmt.setInt(4, pet.getAge());
            stmt.setString(5, pet.getUser_id());
            stmt.setDouble(6, pet.getWeight_kg());
            stmt.setString(7, pet.getNote());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePet(Pet pet) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "  UPDATE Pets SET name = ?, type = ?, age = ?, user_id = ?, note = ? , weight_kg = ? Where pet_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, pet.getName_pet());
            stmt.setString(2, pet.getType());
            stmt.setInt(3, pet.getAge());
            stmt.setString(4, pet.getUser_id());
            stmt.setString(5, pet.getNote());
            stmt.setDouble(6, pet.getWeight_kg());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePet(int petId) {
        try (Connection conn = DBConnect.getConnection()) {
            String sql = "DELETE FROM Pets WHERE pet_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, petId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
