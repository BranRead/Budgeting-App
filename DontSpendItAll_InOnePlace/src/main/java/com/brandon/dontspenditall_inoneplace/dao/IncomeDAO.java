package com.brandon.dontspenditall_inoneplace.dao;

import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.Income;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IncomeDAO {
    public ArrayList<Income> selectAll(int user_id) throws SQLException;
    public Income select(int income_id) throws SQLException;
    public void add(Income income) throws SQLException;
    public void update(Income income) throws SQLException;
    public void delete(int incomeId) throws SQLException;
}
