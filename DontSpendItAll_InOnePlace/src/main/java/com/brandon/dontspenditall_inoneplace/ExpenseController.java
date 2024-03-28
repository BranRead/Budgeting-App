package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

import com.brandon.dontspenditall_inoneplace.database.ExpenseDAOImp;
import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.Transaction;
import com.brandon.dontspenditall_inoneplace.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "ExpenseControllerServlet", value = "/Expense")
public class ExpenseController extends HttpServlet {
    ExpenseDAOImp expenseDAOImp;

    public void init() {
        expenseDAOImp = new ExpenseDAOImp();
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

//    private void select()

    private void add(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Expense expense = new Expense();
        User user = (User) request.getSession().getAttribute("user");

        expense.setUserId(user.getId());
        expense.setName(request.getParameter("name"));
        expense.setAmount(Double.parseDouble(request.getParameter("amount")));
        expense.setTag(request.getParameter("tag"));
        expense.setTransaction_date(Date.valueOf(request.getParameter("date")));
        expenseDAOImp.add(expense);

        ArrayList<Expense> expenses = expenseDAOImp.selectAll(user.getId());
        request.getSession().setAttribute("expenses", expenses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    public void destroy() {
    }
}