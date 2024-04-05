package com.brandon.dontspenditall_inoneplace;

import java.io.*;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import com.brandon.dontspenditall_inoneplace.dao.ExpenseDAO;
import com.brandon.dontspenditall_inoneplace.database.ExpenseDAOImp;
import com.brandon.dontspenditall_inoneplace.database.IncomeDAOImp;
import com.brandon.dontspenditall_inoneplace.model.BudgetSettings;
import com.brandon.dontspenditall_inoneplace.model.Expense;
import com.brandon.dontspenditall_inoneplace.model.Income;
import com.brandon.dontspenditall_inoneplace.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "PastMonthsControllerServlet", value = "/PastMonths")
public class PastMonthsController extends HttpServlet {
    ExpenseDAOImp expenseDAOImp;
    IncomeDAOImp incomeDAOImp;
    public void init() {
        expenseDAOImp = new ExpenseDAOImp();
        incomeDAOImp = new IncomeDAOImp();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try{
            select(request, response);
        } catch (SQLException | ServletException | ParseException e) {
            System.out.println("Error: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    private void select(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException, ParseException {
        if(request.getParameter("monthToGet") != null){
            HttpSession session = request.getSession();
            User user = (User) request.getSession().getAttribute("user");

            Calendar calendar = Calendar.getInstance();

            java.util.Date date = new java.util.Date(java.sql.Date.valueOf(request.getParameter("monthToGet")).getTime());


            calendar.setTime(date);
            session.setAttribute("displayedDate", date);

            ArrayList<Expense> expenses = expenseDAOImp.selectAll(user.getId(), calendar);
            session.setAttribute("expenses", expenses);

            ArrayList<Income> incomes = incomeDAOImp.selectAll(user.getId(), calendar);
            session.setAttribute("incomes", incomes);

            ArrayList<Date> datesOfEntries = expenseDAOImp.selectAllDates(user.getId(), calendar);
            session.setAttribute("datesOfEntries", datesOfEntries);
        }



        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.include(request, response);
        dispatcher.forward(request, response);
        response.sendRedirect("/main.jsp");
    }


    public void destroy() {
    }
}