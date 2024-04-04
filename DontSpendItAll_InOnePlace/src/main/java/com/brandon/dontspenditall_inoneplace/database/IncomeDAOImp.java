package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.IncomeDAO;
import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.Income;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import static com.brandon.dontspenditall_inoneplace.database.MySQLConnection.getConnection;

public class IncomeDAOImp implements IncomeDAO {
    private static final String SQL_SELECT = "SELECT * FROM income WHERE user_id = ?";

    private static final String SQL_SELECT_ONE = "SELECT * FROM income WHERE income_id = ?";
    private static final String  SQL_INSERT = "INSERT INTO income (user_id, name, amount, transaction_date, is_repeating) VALUES(?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE income " +
            "SET name = ?, amount = ?, transaction_date = ?, is_repeating = ? WHERE income_id = ?";
    private static final String SQL_DELETE = "DELETE FROM income WHERE income_id = ?";
    @Override
    public ArrayList<Income> selectAll(int user_id, Calendar dateToFind) throws SQLException {
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
                income.setTransaction_date(rs.getDate("transaction_date"));
                income.setRepeating(rs.getInt("is_repeating") == 1);
                Date dateOfTransaction = income.getTransaction_date();
                Date dateNow = new Date();

                Calendar calendar = Calendar.getInstance();
                calendar.setTime(dateOfTransaction);
                int yearOfTransaction = calendar.get(Calendar.YEAR);
                int monthOfTransaction = calendar.get(Calendar.MONTH);


                int yearToFind = dateToFind.get(Calendar.YEAR);
                int monthToFind = dateToFind.get(Calendar.MONTH);

                if(!income.isRepeating()){
                    if(yearOfTransaction == yearToFind && monthOfTransaction == monthToFind){
                        income.setId(rs.getInt("income_id"));
                        income.setUserId(user_id);
                        income.setName(rs.getString("name"));
                        income.setAmount(rs.getDouble("amount"));
                        incomes.add(income);
                    }
                } else {
                    if(yearOfTransaction < yearToFind || yearOfTransaction == yearToFind && monthOfTransaction <= monthToFind) {
                        income.setId(rs.getInt("income_id"));
                        income.setUserId(user_id);
                        income.setName(rs.getString("name"));
                        income.setAmount(rs.getDouble("amount"));
                        incomes.add(income);
                    }
                }
            }
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
        return incomes;
    }

    @Override
    public Income select(int income_id) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        Income income = new Income();

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT_ONE);

            preparedStatement.setInt(1, income_id);
            ResultSet rs = preparedStatement.executeQuery();

            rs.next();
            income.setId(rs.getInt("income_id"));
            income.setName(rs.getString("name"));
            income.setAmount(rs.getDouble("amount"));
            income.setTransaction_date(rs.getDate("transaction_date"));
            income.setRepeating(rs.getInt("is_repeating") == 1);
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
            income.setName(exception.getMessage());
        }
        return income;
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
            preparedStatement.setInt(5, booleanToInt(income.isRepeating()));

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
            preparedStatement.setInt(4, booleanToInt(income.isRepeating()));
            preparedStatement.setInt(5, income.getId());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }

    public int booleanToInt(boolean isRepeating){
        if(isRepeating){
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public void delete(int incomeId) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_DELETE);
            preparedStatement.setInt(1, incomeId);
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            System.out.println("Error: " + exception.getMessage());
        }
    }
}