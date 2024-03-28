package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.BudgetDAO;
import com.brandon.dontspenditall_inoneplace.model.BudgetSettings;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.brandon.dontspenditall_inoneplace.database.MySQLConnection.getConnection;

public class BudgetDAOImp implements BudgetDAO {
    private static final String SQL_SELECT = "SELECT * FROM budget_settings WHERE user_id = ?";
    private static final String  SQL_INSERT = "INSERT INTO budget_settings (user_id, needs, wants, savings) " +
            "VALUES(?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE budget_settings " +
            "SET needs = ?, wants = ?, savings = ? WHERE user_id = ?";
    private static final String SQL_DELETE = "DELETE FROM budget_settings WHERE user_id = ?";

    @Override
    public BudgetSettings select(int user_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        BudgetSettings budgetSettings = new BudgetSettings();

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT);
            preparedStatement.setInt(1, user_id);
            ResultSet rs = preparedStatement.executeQuery();


            if(!rs.next()) {
                budgetSettings = null;
            } else {
                budgetSettings.setUserId(user_id);
                budgetSettings.setNeeds(rs.getInt("needs"));
                budgetSettings.setWants(rs.getInt("wants"));
                budgetSettings.setSavings(rs.getInt("savings"));
            }

        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
        return budgetSettings;
    }

    @Override
    public void add(BudgetSettings budgetSettings) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_INSERT);
            preparedStatement.setInt(1, budgetSettings.getUserId());
            preparedStatement.setInt(2, budgetSettings.getNeeds());
            preparedStatement.setInt(3, budgetSettings.getWants());
            preparedStatement.setInt(4, budgetSettings.getSavings());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void update(BudgetSettings budgetSettings) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_UPDATE);

            preparedStatement.setInt(1, budgetSettings.getNeeds());
            preparedStatement.setInt(2, budgetSettings.getWants());
            preparedStatement.setInt(3, budgetSettings.getSavings());
            preparedStatement.setInt(4, budgetSettings.getUserId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void delete(int user_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_DELETE);

            preparedStatement.setInt(1, user_id);
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }
}