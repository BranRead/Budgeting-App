package com.brandon.dontspenditall_inoneplace.model;

public class User {
    private int id;
    private String fName;
    private String lName;
    private String username;
    private String password;

    public User(int id, String fName, String lName, String username){
        this.id = id;
        this.fName = fName;
        this.lName = lName;
        this.username = username;
    }

    public User(){}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }
}
