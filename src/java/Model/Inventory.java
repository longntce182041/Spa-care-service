package Model;

public class Inventory {
    private int inventoryId;
    private int productId;
    private String staffId; // Thay đổi kiểu dữ liệu thành String
    private int quantity;
    private String type;
    private String imageUrl;
    private String categoryId; // Thay đổi kiểu dữ liệu thành String

    public Inventory(int inventoryId, int productId, String staffId, int quantity, String type, String imageUrl, String categoryId) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.staffId = staffId;
        this.quantity = quantity;
        this.type = type;
        this.imageUrl = imageUrl;
        this.categoryId = categoryId;
    }

    // Getters and Setters
    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }
}