package com.brandon.dontspenditall_inoneplace.dao;

import com.brandon.dontspenditall_inoneplace.model.Expense;

import java.sql.SQLException;
import java.util.ArrayList;

public interface ExpenseDAO {
    public ArrayList<Expense> selectAll(int user_id) throws SQLException;
    public void add(Expense expense) throws SQLException;
    public void update(Expense expense) throws SQLException;
    public void delete(Expense expense) throws SQLException;
}