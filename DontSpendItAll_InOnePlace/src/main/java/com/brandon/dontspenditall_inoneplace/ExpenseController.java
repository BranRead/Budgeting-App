package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;

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
        try{
            if(Objects.equals(request.getParameter("refresh"), "true")){
                refresh(request);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
                dispatcher.include(request, response);
                dispatcher.forward(request, response);
                response.sendRedirect("/main.jsp");
            } else {
                selectOne(request, response);
            }
        } catch (SQLException | ServletException e){
            throw new RuntimeException(e);
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            if(request.getParameter("deleteId") != null){
                delete(request, response);
            } else if (request.getParameter("editId") != null){
                edit(request, response);
            } else {
                add(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

//    private void select()

    private void selectOne(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        request.setAttribute("edit", true);

        Expense expense = expenseDAOImp.select(Integer.parseInt(request.getParameter("editId")));
        request.setAttribute("expenseToEdit", expense);
        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");

    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Expense expense = new Expense();
        User user = (User) request.getSession().getAttribute("user");

        expense.setUserId(user.getId());
        expense.setName(request.getParameter("name"));
        expense.setAmount(Double.parseDouble(request.getParameter("amount")));
        expense.setTag(request.getParameter("tag"));
        expense.setTransaction_date(Date.valueOf(request.getParameter("date")));
        expenseDAOImp.add(expense);

        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Expense expense = new Expense();

        expense.setName(request.getParameter("name"));
        expense.setAmount(Double.parseDouble(request.getParameter("amount")));
        expense.setTag(request.getParameter("tag"));
        expense.setTransaction_date(Date.valueOf(request.getParameter("date")));
        expense.setId(Integer.parseInt(request.getParameter("editId")));

        expenseDAOImp.update(expense);
        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        expenseDAOImp.delete(Integer.parseInt(request.getParameter("deleteId")));
        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void refresh(HttpServletRequest request) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        ArrayList<Expense> expenses = expenseDAOImp.selectAll(user.getId());
        request.getSession().setAttribute("expenses", expenses);
    }

    public void destroy() {
    }
}