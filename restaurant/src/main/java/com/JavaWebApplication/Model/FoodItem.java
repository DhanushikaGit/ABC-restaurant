package com.JavaWebApplication.Model;

import java.math.BigDecimal;

public class FoodItem {
    private String name;
    private String description;
    private BigDecimal price;
    private String category;
    private String image;

    // Constructor
    public FoodItem(String name, String description, BigDecimal price, String category, String image) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.image = image;
    }

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}
