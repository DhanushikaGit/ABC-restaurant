package com.res.model;

public class Staff {
    private int id;
    private String name;
    private String email;
    private String password;
    private String profileImagePath;

    // Constructor with all fields
    public Staff(int id, String name, String email, String password, String profileImagePath) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.profileImagePath = profileImagePath;
    }

    // Constructor without ID (for creating new staff members)
    public Staff(String name, String email, String password, String profileImagePath) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.profileImagePath = profileImagePath;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfileImagePath() {
        return profileImagePath;
    }

    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }
}
