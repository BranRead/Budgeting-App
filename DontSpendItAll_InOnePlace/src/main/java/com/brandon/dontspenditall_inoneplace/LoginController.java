package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import com.brandon.dontspenditall_inoneplace.database.LoginDAOImp;
import com.brandon.dontspenditall_inoneplace.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "loginController", value = "/login")
public class LoginController extends HttpServlet {
    LoginDAOImp loginDAOImp;


    public void init() {
        loginDAOImp = new LoginDAOImp();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            select(request, response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void destroy() {
    }

    private void select(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        User user = loginDAOImp.select(request.getParameter("username"), request.getParameter("password"));
        if(user != null) {
            request.setAttribute("user", user);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
            dispatcher.include(request, response);
            dispatcher.forward(request, response);
            response.sendRedirect("/main.jsp");
        }
    }
}