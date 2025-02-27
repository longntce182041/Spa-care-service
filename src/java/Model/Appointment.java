package Model;

import java.sql.Timestamp;

public class Appointment {

    private int appointmentId;
    private int customerId;
    private int petId;
    private int serviceId;
    private int staffId;
    private Timestamp appointmentDate;
    private String status;

    public Appointment(int appointmentId, int customerId, int petId, int serviceId, int staffId, Timestamp appointmentDate, String status) {
        this.appointmentId = appointmentId;
        this.customerId = customerId;
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

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getPetId() {
        return petId;
    }

    public void setPetId(int petId) {
        this.petId = petId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
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
