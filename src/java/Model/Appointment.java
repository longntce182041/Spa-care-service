package Model;

import java.sql.Timestamp;

public class Appointment {

    private int appointmentId;
    private int userId;
    private String petId; // Thay đổi kiểu dữ liệu thành String
    private String serviceId; // Thay đổi kiểu dữ liệu thành String
    private String staffId; // Thay đổi kiểu dữ liệu thành String
    private Timestamp appointmentDate;
    private String status;

    public Appointment(int appointmentId, int userId, String petId, String serviceId, String staffId, Timestamp appointmentDate, String status) {
        this.appointmentId = appointmentId;
        this.userId = userId;
        this.petId = petId;
        this.serviceId = serviceId;
        this.staffId = staffId;
        this.appointmentDate = appointmentDate;
        this.status = status;
    }

    // Getters and Setters
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPetId() {
        return petId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public Timestamp getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Timestamp appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}