/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */

public class Rating {
    private int ratingId;
    private String userName;
    private String serviceName;
    private int ratingStar;
    private String comment;

    // Constructor
    public Rating(int ratingId, String userName, String serviceName, int ratingStar, String comment) {
        this.ratingId = ratingId;
        this.userName = userName;
        this.serviceName = serviceName;
        this.ratingStar = ratingStar;
        this.comment = comment;
    }

    public Rating(String username, String serviceName, int ratingStar, String comment) {
        
    }

    // Getter methods
    public int getRatingId() {
        return ratingId;
    }

    public String getUserName() {
        return userName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public int getRatingStar() {
        return ratingStar;
    }

    public String getComment() {
        return comment;
    }
}
