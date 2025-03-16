/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Nguyen Thanh Long - CE182041
 */
public class Service_Category {
    private String category_id;
    private String name;
    private boolean status;

    public Service_Category() {
    }

    public Service_Category(String category_id, String name, boolean status) {
        this.category_id = category_id;
        this.name = name;
        this.status = status;
    }

    public Service_Category(String category_id, String name) {
        this.category_id = category_id;
        this.name = name;
    }
    

    public String getCategory_id() {
        return category_id;
    }

    public void setCategory_id(String category_id) {
        this.category_id = category_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
    
}
