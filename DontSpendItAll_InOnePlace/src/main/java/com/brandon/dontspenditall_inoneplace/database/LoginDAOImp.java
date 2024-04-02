package com.brandon.dontspenditall_inoneplace.database;

import com.brandon.dontspenditall_inoneplace.dao.LoginDAO;
import com.brandon.dontspenditall_inoneplace.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.brandon.dontspenditall_inoneplace.database.MySQLConnection.getConnection;

public class LoginDAOImp implements LoginDAO {
    private static final String SQL_SELECT = "SELECT user_id, f_name, l_name, username FROM users WHERE username = ? AND password = ?";
    private Connection jdbcConnection;

    @Override
    public User select(String username, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        User loggedInUser = null;

        try {
            conn = getConnection();
            preparedStatement = conn.prepareStatement(SQL_SELECT);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            rs = preparedStatement.executeQuery();
            rs.next();

            //This is NOT always true, ignore error
            if(rs != null){
                loggedInUser = new User(
                        rs.getInt("user_id"),
                        rs.getString("f_name"),
                        rs.getString("l_name"),
                        rs.getString("username")
                );
            }

        } catch (Exception exception){
            System.out.println("Error: " + exception.getMessage());
        }
        return loggedInUser;
    }
}
