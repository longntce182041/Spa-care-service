package Model;

public class Inventory {
    private int inventoryId;
    private int productId;
    private int staffId;
    private int quantity;
    private String type;
    private String imageUrl;
    private int categoryId;

    public Inventory(int inventoryId, int productId, int staffId, int quantity, String type, String imageUrl, int categoryId) {
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

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}