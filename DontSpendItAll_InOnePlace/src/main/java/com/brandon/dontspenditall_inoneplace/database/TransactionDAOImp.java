package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.TransactionDao;
import com.brandon.dontspenditall_inoneplace.model.BudgetSettings;
import com.brandon.dontspenditall_inoneplace.model.Transaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static com.brandon.dontspenditall_inoneplace.database.MySQLConnection.getConnection;

public class TransactionDAOImp implements TransactionDao {

    //The table will always be expenses or income

    private static final String SQL_SELECT = "SELECT * FROM ? WHERE user_id = ?";
    private static final String  SQL_INSERT = "INSERT INTO ? (user_id, amount, tag, transaction_date) " +
            "VALUES(?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE ? " +
            "SET amount = ?, tag = ?, transaction_date = ? WHERE ? = ?";
    private static final String SQL_DELETE = "DELETE FROM ? WHERE ? = ?";
    @Override
    public ArrayList<Transaction> selectAll(int user_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ArrayList<Transaction> transactions = new ArrayList<>();

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT);
            preparedStatement.setString(1, "expenses");
            preparedStatement.setInt(2, user_id);
            ResultSet rs = preparedStatement.executeQuery();
            while(rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setUserId(user_id);
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setTag(rs.getString("tag"));
                transaction.setTransaction_date(rs.getDate("transaction_date"));
                transaction.setIncome(false);
                transactions.add(transaction);
            }

            preparedStatement = conn.prepareStatement(SQL_SELECT);
            preparedStatement.setString(1, "income");
            preparedStatement.setInt(2, user_id);
            rs = preparedStatement.executeQuery();
            while(rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setUserId(user_id);
                transaction.setAmount(rs.getDouble("amount"));
                transaction.setTag(rs.getString("tag"));
                transaction.setTransaction_date(rs.getDate("transaction_date"));
                transaction.setIncome(true);
                transactions.add(transaction);
            }

        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
        return transactions;
    }

    @Override
    public void add(Transaction transaction) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_INSERT);
            if(transaction.isIncome()){
                preparedStatement.setString(1, "income");
            } else {
                preparedStatement.setString(1, "expenses");
            }
            preparedStatement.setInt(2, transaction.getUserId());
            preparedStatement.setDouble(3, transaction.getAmount());
            preparedStatement.setString(4, transaction.getTag());
            preparedStatement.setDate(5, transaction.getTransaction_date());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void update(Transaction transaction) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_UPDATE);

            if (transaction.isIncome()){
                preparedStatement.setString(1, "income");
                preparedStatement.setString(5, "income_id");
            } else {
                preparedStatement.setString(1, "expenses");
                preparedStatement.setString(5, "expense_id");
            }

            preparedStatement.setDouble(2, transaction.getAmount());
            preparedStatement.setString(3, transaction.getTag());
            preparedStatement.setDate(4, transaction.getTransaction_date());
            preparedStatement.setInt(6, transaction.getId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    @Override
    public void delete(Transaction transaction) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_DELETE);

            if(transaction.isIncome()) {
                preparedStatement.setString(1, "income");
                preparedStatement.setString(2, "income_id");
            } else {
                preparedStatement.setString(1, "expenses");
                preparedStatement.setString(2, "expense_id");
            }

            preparedStatement.setInt(3, transaction.getId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }
}

