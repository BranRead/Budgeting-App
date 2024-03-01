package com.brandon.dontspenditall_inoneplace.dao;

import com.brandon.dontspenditall_inoneplace.model.User;

import java.sql.SQLException;

public interface LoginDAO {
    public User select(String username, String password) throws SQLException;
}
