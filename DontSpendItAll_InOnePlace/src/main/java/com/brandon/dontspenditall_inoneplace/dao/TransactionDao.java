package com.brandon.dontspenditall_inoneplace.dao;

import com.brandon.dontspenditall_inoneplace.model.Transaction;

import java.sql.SQLException;
import java.util.ArrayList;

public interface TransactionDao {
    public ArrayList<Transaction> selectAll(int user_id) throws SQLException;
    public void add(Transaction transaction) throws SQLException;
    public void update(Transaction transaction) throws SQLException;
    public void delete(Transaction transaction) throws SQLException;
}
