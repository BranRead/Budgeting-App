package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;

import com.brandon.dontspenditall_inoneplace.database.IncomeDAOImp;
import com.brandon.dontspenditall_inoneplace.model.BudgetSettings;
import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.Income;
import com.brandon.dontspenditall_inoneplace.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "IncomeControllerServlet", value = "/Income")
public class IncomeController extends HttpServlet {
    IncomeDAOImp incomeDAOImp;

    public void init() {
        incomeDAOImp = new IncomeDAOImp();
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
                select(request, response);
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

    public void add(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Income income = new Income();
        User user = (User) request.getSession().getAttribute("user");

        income.setUserId(user.getId());
        income.setName(request.getParameter("name"));
        income.setAmount(Double.parseDouble(request.getParameter("amount")));
        income.setTransaction_date(Date.valueOf(request.getParameter("date")));

        incomeDAOImp.add(income);

        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    public void select(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("editIncome", true);

        Income income  = incomeDAOImp.select(Integer.parseInt(request.getParameter("editId")));

        request.setAttribute("incomeToEdit", income);
        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Income income = new Income();

        income.setName(request.getParameter("name"));
        income.setAmount(Double.parseDouble(request.getParameter("amount")));

        income.setTransaction_date(Date.valueOf(request.getParameter("date")));
        income.setId(Integer.parseInt(request.getParameter("editId")));

        incomeDAOImp.update(income);
        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        incomeDAOImp.delete(Integer.parseInt(request.getParameter("deleteId")));
        refresh(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }

    private void refresh(HttpServletRequest request) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        ArrayList<Income> incomes = incomeDAOImp.selectAll(user.getId());
        request.getSession().setAttribute("incomes", incomes);
    }


    public void destroy() {
    }
}