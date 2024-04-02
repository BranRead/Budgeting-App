package com.brandon.dontspenditall_inoneplace.dao;

import com.brandon.dontspenditall_inoneplace.model.BudgetSettings;

import java.sql.SQLException;

public interface BudgetDAO {
    public BudgetSettings select(int user_id) throws SQLException;
    public void add(BudgetSettings budgetSettings, boolean isUpdate) throws SQLException;
    public void update(BudgetSettings budgetSettings) throws SQLException;
    public void delete(int user_id) throws SQLException;
}
