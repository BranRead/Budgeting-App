package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

import com.brandon.dontspenditall_inoneplace.database.BudgetDAOImp;
import com.brandon.dontspenditall_inoneplace.model.BudgetSettings;
import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "BudgetControllerServlet", value = "/Budget")
public class BudgetController extends HttpServlet {
    private BudgetDAOImp budgetDAOImp;

    public void init() {
        budgetDAOImp = new BudgetDAOImp();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            add(request, response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void add(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        BudgetSettings budgetSettings = new BudgetSettings();
        User user = (User) request.getSession().getAttribute("user");

        budgetSettings.setUserId(user.getId());
        budgetSettings.setNeeds(Integer.parseInt(request.getParameter("needsPercent")));
        budgetSettings.setWants(Integer.parseInt(request.getParameter("wantsPercent")));
        budgetSettings.setSavings(Integer.parseInt(request.getParameter("savingsPercent")));
        budgetDAOImp.add(budgetSettings, isUpdateRequired(request));

        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void refresh(HttpServletRequest request) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        BudgetSettings budgetSettings = budgetDAOImp.select(user.getId());
        request.getSession().setAttribute("budget", budgetSettings);
    }

    private boolean isUpdateRequired(HttpServletRequest request){
        return request.getSession().getAttribute("budget") != null;
    }

    public void destroy() {
    }
}