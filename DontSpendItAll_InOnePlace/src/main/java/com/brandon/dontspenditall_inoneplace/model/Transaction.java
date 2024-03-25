package com.brandon.dontspenditall_inoneplace.model;

import java.sql.Date;

public class Transaction {
    private int id;
    private double amount;
    private String tag;
    private Date transaction_date;
    private boolean isIncome;

    public Transaction(int id, double amount, String tag, Date transaction_date, boolean isIncome) {
        this.id = id;
        this.amount = amount;
        this.tag = tag;
        this.transaction_date = transaction_date;
        this.isIncome = isIncome;
    }

    public Transaction() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public Date getTransaction_date() {
        return transaction_date;
    }

    public void setTransaction_date(Date transaction_date) {
        this.transaction_date = transaction_date;
    }

    public boolean isIncome() {
        return isIncome;
    }

    public void setIncome(boolean income) {
        isIncome = income;
    }
}