package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.TransactionDao;
import com.brandon.dontspenditall_inoneplace.model.Transaction;

import java.sql.SQLException;
import java.util.ArrayList;

public class TransactionDAOImp implements TransactionDao {
    @Override
    public ArrayList<Transaction> selectAll(int user_id) throws SQLException {
        return null;
    }

    @Override
    public void add(Transaction transaction) throws SQLException {

    }

    @Override
    public void update(Transaction transaction) throws SQLException {

    }

    @Override
    public void delete(int user_id) throws SQLException {

    }
}
