package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;

import com.brandon.dontspenditall_inoneplace.database.BudgetDAOImp;
import com.brandon.dontspenditall_inoneplace.database.IncomeDAOImp;
import com.brandon.dontspenditall_inoneplace.database.LoginDAOImp;
import com.brandon.dontspenditall_inoneplace.database.ExpenseDAOImp;
import com.brandon.dontspenditall_inoneplace.model.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "loginController", value = "/login")
public class LoginController extends HttpServlet {
    LoginDAOImp loginDAOImp;
    BudgetDAOImp budgetDAOImp;
    ExpenseDAOImp expenseDAOImp;
    IncomeDAOImp incomeDAOImp;

    public void init() {
        loginDAOImp = new LoginDAOImp();
        budgetDAOImp = new BudgetDAOImp();
        expenseDAOImp = new ExpenseDAOImp();
        incomeDAOImp = new IncomeDAOImp();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            select(request, response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void select(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        User user = loginDAOImp.select(request.getParameter("username"), request.getParameter("password"));
        ArrayList<Expense> expenses = expenseDAOImp.selectAll(user.getId());
        BudgetSettings budgetSettings = budgetDAOImp.select(user.getId());
        ArrayList<Income> incomes = incomeDAOImp.selectAll(user.getId());
        if(user != null) {
            request.setAttribute("user", user);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("budget", budgetSettings);
            session.setAttribute("expenses", expenses);
            session.setAttribute("incomes", incomes);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
            dispatcher.include(request, response);
            dispatcher.forward(request, response);
            response.sendRedirect("/main.jsp");
        }
    }

    public void destroy() {
    }
}