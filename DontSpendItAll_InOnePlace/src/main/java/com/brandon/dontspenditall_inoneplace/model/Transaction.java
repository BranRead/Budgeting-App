package com.brandon.dontspenditall_inoneplace.model;

import java.sql.Date;

public class Transaction {
    private int id;
    private int userId;
    private String name;
    private double amount;
    private Date transaction_date;
    private boolean isRepeating;

    public Transaction(int id, int userId, String name, double amount, Date transaction_date, boolean isRepeating) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.amount = amount;
        this.transaction_date = transaction_date;
        this.isRepeating = isRepeating;
    }

    public Transaction() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getTransaction_date() {
        return transaction_date;
    }

    public void setTransaction_date(Date transaction_date) {
        this.transaction_date = transaction_date;
    }

    public boolean isRepeating() {
        return isRepeating;
    }

    public void setRepeating(boolean repeating) {
        isRepeating = repeating;
    }
}