package com.brandon.dontspenditall_inoneplace.dao;

import com.brandon.dontspenditall_inoneplace.model.Expense;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public interface ExpenseDAO {
    public ArrayList<Expense> selectAll(int user_id, Calendar dateToFind) throws SQLException;
    public ArrayList<Date> selectAllDates(int user_id, Calendar currentDate) throws SQLException;
    public Expense select(int expense_id) throws  SQLException;
    public void add(Expense expense) throws SQLException;
    public void update(Expense expense) throws SQLException;
    public void delete(int expenseId) throws SQLException;
}
