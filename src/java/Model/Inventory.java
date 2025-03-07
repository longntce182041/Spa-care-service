package Model;

public class Inventory {

    private int inventoryId;
    private int productId;
    private int staffId;
    private int quantity;
    private String type;
    private String image_url;

    public Inventory(int inventoryId, int productId, int staffId, int quantity, String type, String image_url) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.staffId = staffId;
        this.quantity = quantity;
        this.type = type;
        this.image_url = image_url;
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

    public String getimage_url() {
        return image_url;
    }

    public void setimage_url(String image_url) {
        this.image_url = image_url;
    }
}
