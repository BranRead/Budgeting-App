package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.IncomeDAO;
import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.Income;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static com.brandon.dontspenditall_inoneplace.database.MySQLConnection.getConnection;

public class IncomeDAOImp implements IncomeDAO {
    private static final String SQL_SELECT = "SELECT * FROM income WHERE user_id = ?";
    private static final String  SQL_INSERT = "INSERT INTO income (user_id, name, amount, transaction_date) VALUES(?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE income " +
            "SET name = ?, amount = ?, transaction_date = ? WHERE expense_id = ?";
    private static final String SQL_DELETE = "DELETE FROM expenses WHERE expense_id = ?";
    @Override
    public ArrayList<Income> selectAll(int user_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ArrayList<Income> incomes = new ArrayList<>();

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT);

            preparedStatement.setInt(1, user_id);
            ResultSet rs = preparedStatement.executeQuery();
            while(rs.next()) {
                Income income = new Income();
                income.setUserId(user_id);
                income.setName(rs.getString("name"));
                income.setAmount(rs.getDouble("amount"));
                income.setTransaction_date(rs.getDate("transaction_date"));
                incomes.add(income);
            }
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
            Income income = new Income();

            income.setAmount(-200);

            incomes.add(income);
        }
        return incomes;
    }

    @Override
    public void add(Income income) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_INSERT);

            preparedStatement.setInt(1, income.getUserId());
            preparedStatement.setString(2, income.getName());
            preparedStatement.setDouble(3, income.getAmount());
            preparedStatement.setDate(4, income.getTransaction_date());

            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void update(Income income) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_UPDATE);

            preparedStatement.setString(1, income.getName());
            preparedStatement.setDouble(2, income.getAmount());
            preparedStatement.setDate(3, income.getTransaction_date());
            preparedStatement.setInt(4, income.getId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void delete(Income income) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_DELETE);
            preparedStatement.setInt(1, income.getId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }
}