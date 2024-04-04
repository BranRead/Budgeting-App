package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

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

        if(user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            BudgetSettings budgetSettings = budgetDAOImp.select(user.getId());
            session.setAttribute("budget", budgetSettings);

            Calendar dateNow = Calendar.getInstance();
            ArrayList<Expense> expenses = expenseDAOImp.selectAll(user.getId(), dateNow);
            session.setAttribute("expenses", expenses);

            ArrayList<Income> incomes = incomeDAOImp.selectAll(user.getId());
            session.setAttribute("incomes", incomes);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
            dispatcher.include(request, response);
            dispatcher.forward(request, response);
            response.sendRedirect("/main.jsp");
        } else {
            request.setAttribute("errorLoggingIn", "Wrong username or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.include(request, response);
            dispatcher.forward(request, response);
            response.sendRedirect("/index.jsp");
        }
    }

    public void destroy() {
    }
}