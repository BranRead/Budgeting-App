package com.brandon.dontspenditall_inoneplace.model;

import java.sql.Date;

public class Income extends Transaction{
    public Income(int id, int userId, String name, double amount, Date transaction_date, boolean isRepeating) {
        super(id, userId, name, amount, transaction_date, isRepeating);
    }

    public Income() {
    }
}