package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.ExpenseDAO;
import com.brandon.dontspenditall_inoneplace.model.Expense;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static com.brandon.dontspenditall_inoneplace.database.MySQLConnection.getConnection;

public class ExpenseDAOImp implements ExpenseDAO {
    private static final String SQL_SELECT_All = "SELECT * FROM expenses WHERE user_id = ?";
    private static final String SQL_SELECT = "SELECT * FROM expenses WHERE expense_id = ?";

    private static final String  SQL_INSERT = "INSERT INTO expenses (user_id, name, amount, tag, transaction_date) VALUES(?, ?, ?, ?, ?)";

    private static final String SQL_UPDATE = "UPDATE expenses " +
            "SET name = ?, amount = ?, tag = ?, transaction_date = ? WHERE expense_id = ?";
    private static final String SQL_DELETE = "DELETE FROM expenses WHERE expense_id = ?";
    @Override
    public ArrayList<Expense> selectAll(int user_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ArrayList<Expense> expenses = new ArrayList<>();

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT_All);

            preparedStatement.setInt(1, user_id);
            ResultSet rs = preparedStatement.executeQuery();
            while(rs.next()) {
                Expense expense = new Expense();
                expense.setUserId(user_id);
                expense.setId(rs.getInt("expense_id"));
                expense.setName(rs.getString("name"));
                expense.setAmount(rs.getDouble("amount"));
                expense.setTag(rs.getString("tag"));
                expense.setTransaction_date(rs.getDate("transaction_date"));
                expenses.add(expense);
            }

        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
        return expenses;
    }

    @Override
    public Expense select(int expense_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        Expense expense = new Expense();

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT);


            preparedStatement.setInt(1, expense_id);
            ResultSet rs = preparedStatement.executeQuery();
            if(rs.next()){
                expense.setUserId(rs.getInt("user_id"));
                expense.setId(expense_id);
                expense.setName(rs.getString("name"));
                expense.setAmount(rs.getDouble("amount"));
                expense.setTag(rs.getString("tag"));
                expense.setTransaction_date(rs.getDate("transaction_date"));
            }
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
        return expense;
    }

    @Override
    public void add(Expense expense) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_INSERT);

            preparedStatement.setInt(1, expense.getUserId());
            preparedStatement.setString(2, expense.getName());
            preparedStatement.setDouble(3, expense.getAmount());
            preparedStatement.setString(4, expense.getTag());
            preparedStatement.setDate(5, expense.getTransaction_date());

            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void update(Expense expense) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_UPDATE);

            preparedStatement.setString(1, expense.getName());
            preparedStatement.setDouble(2, expense.getAmount());
            preparedStatement.setString(3, expense.getTag());
            preparedStatement.setDate(4, expense.getTransaction_date());
            preparedStatement.setInt(5, expense.getId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void delete(int expenseId) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_DELETE);
            preparedStatement.setInt(1, expenseId);
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }
}