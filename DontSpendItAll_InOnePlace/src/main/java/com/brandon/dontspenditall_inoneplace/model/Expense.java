package com.brandon.dontspenditall_inoneplace.model;

import java.sql.Date;

public class Expense extends Transaction{
    private String tag;

    public Expense(int id, int userId, String name, double amount, Date transaction_date, String tag) {
        super(id, userId, name, amount, transaction_date);
        this.tag = tag;
    }

    public Expense() {
    }


    public String getTag() {
        return tag;
    }


    public void setTag(String tag) {
        this.tag = tag;
    }
}