package Model;

public class Product {

    private int productId;
    private String name;
    private String description;
    private double price;
    private int stockQuantity;
    private String image_url;
    private String categoryId;
    private String description_detail;

    // Constructor mặc định
    public Product() {
    }

    // Constructor với các tham số
    public Product(int productId, String name, String description, double price, int stockQuantity, String image_url, String categoryId) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.image_url = image_url;
        this.categoryId = categoryId;
    }

    public Product(int productId, String name, String description, double price, int stockQuantity, String image_url, String categoryId, String description_detail) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.image_url = image_url;
        this.categoryId = categoryId;
        this.description_detail = description_detail;
    }

    // Getters và setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getimage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription_detail() {
        return description_detail;
    }

    public void setDescription_detail(String description_detail) {
        this.description_detail = description_detail;
    }

}
