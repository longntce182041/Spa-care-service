/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */

public class Staff {
    private int staffId;
    private int adminId;
    private String fullName;
    private String position;
    private String phone;
    private int userId;

    public Staff(int staffId, int adminId, String fullName, String position, String phone, int userId) {
        this.staffId = staffId;
        this.adminId = adminId;
        this.fullName = fullName;
        this.position = position;
        this.phone = phone;
        this.userId = userId;
    }

    // Getters và Setters
    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
