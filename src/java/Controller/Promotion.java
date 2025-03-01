package Controller;

import java.sql.Date;

public class Promotion {
    private int promotionId;
    private String name;
    private String description;
    private String discountType;
    private double discountValue;
    private Date startDate;
    private Date endDate;
    private double minOrderValue;
    private Double maxDiscount;
    private boolean isActive;

    //Constructor
    public Promotion(int promotionId, String name, String description, String discountType, double discountValue, Date startDate, Date endDate, double minOrderValue, Double maxDiscount, boolean isActive) {
        this.promotionId = promotionId;
        this.name = name;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.minOrderValue = minOrderValue;
        this.maxDiscount = maxDiscount;
        this.isActive = isActive;
    }
    
    
    public Promotion() {
    }
    
    
    // Getters và Setters
    public int getPromotionId() { return promotionId; }
    public void setPromotionId(int promotionId) { this.promotionId = promotionId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public double getMinOrderValue() { return minOrderValue; }
    public void setMinOrderValue(double minOrderValue) { this.minOrderValue = minOrderValue; }

    public Double getMaxDiscount() { return maxDiscount; }
    public void setMaxDiscount(Double maxDiscount) { this.maxDiscount = maxDiscount; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
}
