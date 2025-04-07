package Model;

import java.sql.Date;
import java.sql.Time;

public class Consultation {
    private int consultationId;
    private String message;
    private String consultationName;
    private String phoneNumber;
    private Date date;
    private Time time;
    private String consultationStatus; // Thêm thuộc tính trạng thái

    public Consultation() {}

    public Consultation(int consultationId, String message, String consultationName, String phoneNumber, Date date, Time time, String consultationStatus) {
        this.consultationId = consultationId;
        this.message = message;
        this.consultationName = consultationName;
        this.phoneNumber = phoneNumber;
        this.date = date;
        this.time = time;
        this.consultationStatus = consultationStatus;
    }

    // Getters and Setters
    public int getConsultationId() {
        return consultationId;
    }

    public void setConsultationId(int consultationId) {
        this.consultationId = consultationId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getConsultationName() {
        return consultationName;
    }

    public void setConsultationName(String consultationName) {
        this.consultationName = consultationName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public String getConsultationStatus() {
        return consultationStatus;
    }

    public void setConsultationStatus(String consultationStatus) {
        this.consultationStatus = consultationStatus;
    }
}