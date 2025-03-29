package Model;

public class Inventory {
    private int inventoryId;
    private int productId;
    private String staffId; // ID của nhân viên
    private int inventoryQuantity; // Số lượng sản phẩm trong kho
    private String inventoryType; // Loại kho (nhập, xuất)
    private String inventoryImageUrl; // URL hình ảnh liên quan đến kho
    private String productCategoryId; // ID danh mục sản phẩm

    // Constructor đầy đủ
    public Inventory(int inventoryId, int productId, String staffId, int inventoryQuantity, String inventoryType, String inventoryImageUrl, String productCategoryId) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.staffId = staffId;
        this.inventoryQuantity = inventoryQuantity;
        this.inventoryType = inventoryType;
        this.inventoryImageUrl = inventoryImageUrl;
        this.productCategoryId = productCategoryId;
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

    public int getInventoryQuantity() {
        return inventoryQuantity;
    }

    public void setInventoryQuantity(int inventoryQuantity) {
        this.inventoryQuantity = inventoryQuantity;
    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }

    public String getInventoryImageUrl() {
        return inventoryImageUrl;
    }

    public void setInventoryImageUrl(String inventoryImageUrl) {
        this.inventoryImageUrl = inventoryImageUrl;
    }

    public String getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(String productCategoryId) {
        this.productCategoryId = productCategoryId;
    }
}