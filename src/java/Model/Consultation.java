package Model;

import java.sql.Date;
import java.sql.Time;

public class Consultation {
    private int consultationId;
    private String message;
    private String name;
    private String phoneNumber;
    private Date date;
    private Time time;

    public Consultation(int consultationId, String message, String name, String phoneNumber, Date date, Time time) {
        this.consultationId = consultationId;
        this.message = message;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.date = date;
        this.time = time;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
}