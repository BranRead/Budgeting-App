<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
  Created by IntelliJ IDEA.
  User: Brandon
  Date: 3/1/2024
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dont' Spend it all in One Place!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&family=Kode+Mono:wght@400..700&family=VT323&display=swap" rel="stylesheet">
</head>
<body style="background-color: #4c4c4c">
<nav class="navbar navbar-expand-lg bg-body-tertiary border-bottom border-black">
    <div class="container-fluid d-flex flex-row justify-content-center">
        <a class="navbar-brand" href="#" style="font-family: 'Dancing Script', cursive; font-weight: normal; font-size: 2rem;">Dont' Spend it all in One Place!</a>
        <div class="d-flex flex-row align-items-center">
            <form class="align-items-center ms-5 my-0" action="PastMonths" method="get">
                <label for="previousMonths">Other Months:</label>
                <select name="monthToGet" id="previousMonths">
                    <option>--Select a Month--</option>
                </select>
                <button type="submit" class="btn btn-primary">See</button>
            </form>
        </div>
    </div>
</nav>

<div class="container">
    <div id="greyOut" style="background-color: #4c4c4c; opacity: 60%; position: absolute; top: 0; bottom: 0; left: 0; right:0; display: none; z-index: 2;"></div>
    <div class="bg-info border border-black my-2">
        <div class="row d-flex flex-row justify-content-center">
            <div class="col-lg-8">
                <h2 class="text-center">Welcome: <c:out value="${sessionScope.user.getfName()}"/> <c:out value="${sessionScope.user.getlName()}"/></h2>
            </div>
        </div>

        <div class="row d-flex flex-row justify-content-center">
            <div class="col-lg-8">
                <div class="d-flex flex-row justify-content-center">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#budgetModal">
                        Change Budget Breakdown
                    </button>

                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#incomeModal">
                        Add Income
                    </button>

                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#expenseModal">
                        Add Expense
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="budgetModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Budget Breakdown</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="Budget" method="post">

                                        <label for="needsPercent" class="form-label">Needs Percent</label>
                                        <c:choose>
                                            <c:when test="${sessionScope.budget == null}">
                                                <input type="range" name="needsPercent" class="form-range" min="0" max="100" step="5" value="50" id="needsPercent">
                                                <%--                        <p id="needsPercentDisplayPlus"></p>--%>
                                                <p id="needsPercentDisplay">50%</p>
                                                <%--                        <p id="needsPercentDisplayMinus"></p>--%>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="range" name="needsPercent" class="form-range" min="0" max="100" step="5" value="${sessionScope.budget.getNeeds()}" id="needsPercent">
                                                <%--                        <p id="needsPercentDisplayPlus"></p>--%>
                                                <p id="needsPercentDisplay"><c:out value="${sessionScope.budget.getNeeds()}" />%</p>
                                                <%--                        <p id="needsPercentDisplayMinus"></p>--%>
                                            </c:otherwise>
                                        </c:choose>
                                        <script>
                                            document.getElementById("needsPercent").addEventListener("input", function (e) {
                                                // let value = this.value;
                                                // document.getElementById("needsPercentDisplayPlus").textContent = (value + 5) + "%";
                                                document.getElementById("needsPercentDisplay").textContent = this.value + "%";
                                                // document.getElementById("needsPercentDisplayMinus").textContent = value - 5 + "%";
                                            })
                                        </script>

                                        <label for="wantsPercent" class="form-label">Wants Percent</label>

                                        <c:choose>
                                            <c:when test="${sessionScope.budget == null}">
                                                <input type="range" name="wantsPercent" class="form-range" min="0" max="100" step="5" value="30" id="wantsPercent">
                                                <p id="wantsPercentDisplay">30%</p>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="range" name="wantsPercent" class="form-range" min="0" max="100" step="5" value="${sessionScope.budget.getWants()}" id="wantsPercent">
                                                <p id="wantsPercentDisplay"><c:out value="${sessionScope.budget.getWants()}"/>%</p>
                                            </c:otherwise>
                                        </c:choose>

                                        <script>
                                            document.getElementById("wantsPercent").addEventListener("input", function (e) {
                                                document.getElementById("wantsPercentDisplay").textContent = this.value + "%";
                                            })
                                        </script>

                                        <label for="savingsPercent" class="form-label">Savings Percent</label>
                                        <c:choose>
                                            <c:when test="${sessionScope.budget == null}">
                                                <input type="range" name="savingsPercent" class="form-range" min="0" max="100" step="5" value="20" id="savingsPercent">
                                                <p id="savingsPercentDisplay">20%</p>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="range" name="savingsPercent" class="form-range" min="0" max="100" step="5" value="${sessionScope.budget.getSavings()}" id="savingsPercent">
                                                <p id="savingsPercentDisplay"><c:out value="${sessionScope.budget.getSavings()}"/>%</p>
                                            </c:otherwise>
                                        </c:choose>
                                        <script>
                                            document.getElementById("savingsPercent").addEventListener("input", function (e) {
                                                document.getElementById("savingsPercentDisplay").textContent = this.value + "%";
                                            })
                                        </script>

                                        <button class="btn btn-primary" type="submit">Submit</button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>



                    <!-- Modal -->
                    <div class="modal fade" id="incomeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Add Income</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="Income" method="post">

                                        <label for="nameIncome">Name:</label>
                                        <input type="text" id="nameIncome" name="name">


                                        <label for="amountIncome">Amount:</label>
                                        <input type="number" id="amountIncome" name="amount" step="0.01">

                                        <label for="dateIncome">Transaction date:</label>

                                        <input type="date" id="dateIncome" name="date" value=""/>
                                        <script>
                                            const date = new Date();
                                            let day = date.getDate();
                                            let month = date.getMonth();
                                            let year = date.getFullYear();

                                            let currentDate = day + "-" + (month + 1) + "-" + year;

                                            document.getElementById("date").setAttribute("value", currentDate);
                                        </script>

                                        <input class="form-check-input" type="checkbox" name="repeating" value="true" id="incomeCheckbox">
                                        <label class="form-check-label" for="incomeCheckbox">
                                            Repeating Income?
                                        </label>

                                        <button class="btn btn-primary" type="submit">Submit</button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="expenseModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Add Expense</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="Expense" method="post">

                                        <label for="name">Name:</label>
                                        <input type="text" id="name" name="name">

                                        <label for="tags">Choose a tag:</label>
                                        <select id="tags" name="tag">
                                            <option>-Choose a tag-</option>
                                            <option value="need">Need</option>
                                            <option value="want">Want</option>
                                            <option value="savings">Savings</option>
                                        </select>

                                        <label for="amount">Amount:</label>
                                        <input type="number" id="amount" name="amount" step="0.01">

                                        <label for="date">Transaction date:</label>

                                        <input type="date" id="date" name="date" value=""/>
                                        <script>
                                            const date = new Date();
                                            let day = date.getDate();
                                            let month = date.getMonth();
                                            let year = date.getFullYear();

                                            let currentDate = day + "-" + (month + 1) + "-" + year;

                                            document.getElementById("date").setAttribute("value", currentDate);
                                        </script>

                                        <input class="form-check-input" type="checkbox" name="repeating" value="true" id="expenseCheckbox">
                                        <label class="form-check-label" for="expenseCheckbox">
                                            Repeating Expense?
                                        </label>

                                        <button class="btn btn-primary" type="submit">Submit</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row d-flex flex-row justify-content-center">
            <div class="col-lg-4">
                <script>
                    function formatJavaDate(textToDisplay, dateToFormatMonth, dateToFormatYear){
                        switch (dateToFormatMonth) {
                            case "0":
                                textToDisplay.textContent += "January, " + dateToFormatYear;
                                break;
                            case "1":
                                textToDisplay.textContent += "February, " + dateToFormatYear;
                                break;
                            case "2":
                                textToDisplay.textContent += "March, " + dateToFormatYear;
                                break;
                            case "3":
                                textToDisplay.textContent += "April, " + dateToFormatYear;
                                break;
                            case "4":
                                textToDisplay.textContent += "May, " + dateToFormatYear;
                                break;
                            case "5":
                                textToDisplay.textContent += "June, " + dateToFormatYear;
                                break;
                            case "6":
                                textToDisplay.textContent += "July, " + dateToFormatYear;
                                break;
                            case "7":
                                textToDisplay.textContent += "August, " + dateToFormatYear;
                                break;
                            case "8":
                                textToDisplay.textContent += "September, " + dateToFormatYear;
                                break;
                            case "9":
                                textToDisplay.textContent += "October, " + dateToFormatYear;
                                break;
                            case "10":
                                textToDisplay.textContent += "November, " + dateToFormatYear;
                                break;
                            case "11":
                                textToDisplay.textContent += "December, " + dateToFormatYear;
                                break;
                        }
                    }
                </script>
                <div class="d-flex flex-column"><h3 class="text-center">Finances for the month of:</h3><h3 id="displayedDate" class="text-center"></h3></div>
                <script>
                    formatJavaDate(document.getElementById("displayedDate"), "${sessionScope.displayedDate.getMonth()}", "${sessionScope.displayedDate.getYear() + 1900}");
                </script>
            </div>
        </div>
    </div>

<%--End of the top widget--%>


    <c:forEach var="date" items="${sessionScope.datesOfEntries}">
        <script>
            {
                let option = document.createElement("option");
                option.value = "${date}";
                document.getElementById("previousMonths").appendChild(option);
                formatJavaDate(option, "${date.getMonth()}", "${date.getYear() + 1900}");
            }
        </script>
    </c:forEach>
        <div class="row d-flex flex-row justify-content-center my-2">
            <c:choose>
                <c:when test="${requestScope.editIncome == true}">
                    <script>
                        document.getElementById("greyOut").style.display = "block";
                    </script>
                    <div class="col-lg-2 border border-white rounded" style="background-color: #999999; z-index: 3;">
                        <div class="d-flex flex-row justify-content-between">
                            <h3>Edit Income</h3>
                            <form action="Expense" method="get"><button class="btn btn-danger border border-white rounded" name="refresh" value="true" type="submit">X</button></form>
                        </div>

                        <form method="post" action="Income">
                            <label for="nameEditIncome">Name:</label>
                            <input type="text" id="nameEditIncome" name="name" value="${requestScope.incomeToEdit.getName()}">


                            <label for="amountEditIncome">Amount:</label>
                            <input type="number" id="amountEditIncome" name="amount" value="${requestScope.incomeToEdit.getAmount()}" step="0.01">

                            <label for="date">Transaction date:</label>
                            <input type="date" id="dateEditIncome" name="date" value="${requestScope.incomeToEdit.getTransaction_date()}"/>

                            <label class="form-check-label" for="incomeCheckboxEdit">
                                Repeating Income?
                            </label>
                            <input class="form-check-input" type="checkbox" name="repeating" value="true" id="incomeCheckboxEdit">


                            <script>
                                if("${requestScope.incomeToEdit.isRepeating()}" === "true"){
                                    document.getElementById("incomeCheckboxEdit").checked = true;
                                }
                            </script>
                            <button class="btn btn-primary" type="submit" name="editId" value="${requestScope.incomeToEdit.getId()}">Submit</button>
                        </form>

                    </div>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${requestScope.edit == true}">
                    <script>
                        document.getElementById("greyOut").style.display = "block";
                    </script>
                    <div class="col-lg-2 border border-white rounded" style="background-color: #999999; z-index: 3">
                        <div class="d-flex flex-row justify-content-between">
                            <h3>Edit Expense</h3>
                            <form action="Expense" method="get"><button class="btn btn-danger border border-white rounded" name="refresh" value="true" type="submit">X</button></form>
                        </div>

                        <form method="post" action="Expense">
                            <label for="nameEdit">Name:</label>
                            <input type="text" id="nameEdit" name="name" value="${requestScope.expenseToEdit.getName()}">

                            <label for="tagsEdit">Choose a tag:</label>
                            <select id="tagsEdit" name="tag">
                                <option>-Choose a tag-</option>
                                <option id="needEdit" value="need">Need</option>
                                <option id="wantEdit" value="want">Want</option>
                                <option id="savingsEdit" value="savings">Savings</option>
                            </select>
                            <script>
                                if("${requestScope.expenseToEdit.getTag()}" === "need"){
                                    document.getElementById("tagsEdit").options[1].selected = true;
                                    document.getElementById("tagsEdit").value = "need";
                                } else if ("${requestScope.expenseToEdit.getTag()}" === "want"){
                                    document.getElementById("tagsEdit").options[2].selected = true;
                                    document.getElementById("tagsEdit").value = "want";
                                } else if ("${requestScope.expenseToEdit.getTag()}" === "savings"){
                                    document.getElementById("tagsEdit").options[3].selected = true;
                                    document.getElementById("tagsEdit").value = "savings";
                                }
                            </script>

                            <label for="amountEdit">Amount:</label>
                            <input type="number" id="amountEdit" name="amount" value="${requestScope.expenseToEdit.getAmount()}" step="0.01">

                            <label for="date">Transaction date:</label>

                            <input type="date" id="dateEdit" name="date" value="${requestScope.expenseToEdit.getTransaction_date()}"/>

                            <label class="form-check-label" for="expenseCheckboxEdit">
                                Repeating Income?
                            </label>
                            <input class="form-check-input" type="checkbox" name="repeating" value="true" id="expenseCheckboxEdit">


                            <script>
                                if("${requestScope.expenseToEdit.isRepeating()}" === "true"){
                                    document.getElementById("expenseCheckboxEdit").checked = true;
                                }
                            </script>

                            <button class="btn btn-primary" type="submit" name="editId" value="${requestScope.expenseToEdit.getId()}">Submit</button>
                        </form>

                    </div>
                </c:when>
            </c:choose>
        </div>
        <div class="row d-flex flex-row justify-content-center my-2">
            <div class="col-lg-4 border border-white rounded" style="background-color: #999999">
                <h3 class="text-center">Income Sources</h3>
                <table id="incomeSources" class="table table-striped">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Amount</th>
                    </tr>
                    </thead>
                    <tbody id="incomeSourcesBody"></tbody>
                </table>
                <h4 id="income" class="text-center bg-info border border-white">Total Income: $</h4>
            </div>
        </div>

        <div class="row d-flex flex-row justify-content-center">
            <div class="d-flex flex-column justify-content-center border border-white rounded" style="background-color: #999999">
                <h3 class="text-center">Expenses</h3>

                <div class="d-flex flex-row justify-content-center">
                    <div class="col-lg-3 mx-2">
                        <table id="needs" class="table table-striped">
                            <thead>
                            <tr>
                                <c:choose>
                                    <c:when test="${sessionScope.budget == null}">
                                        <th class="text-center" colspan="2">Needs - 50%</th>
                                    </c:when>
                                    <c:otherwise>
                                        <th class="text-center" colspan="2">Needs - <c:out value="${sessionScope.budget.getNeeds()}"/>%</th>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            </thead>
                            <tbody id="needsBody"></tbody>
                        </table>
                    </div>

                    <div class="col-lg-3 mx-2">
                        <table id="wants" class="table table-striped">
                            <thead>
                            <tr>
                                <c:choose>
                                    <c:when test="${sessionScope.budget == null}">
                                        <th class="text-center" colspan="2">Wants - 30%</th>
                                    </c:when>
                                    <c:otherwise>
                                        <th class="text-center" colspan="2">Wants - <c:out value="${sessionScope.budget.getWants()}"/>%</th>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            </thead>
                            <tbody id="wantsBody"></tbody>
                        </table>
                    </div>

                    <div class="col-lg-3 mx-2">
                        <table id="savings" class="table table-striped">
                            <thead>
                            <tr>
                                <c:choose>
                                    <c:when test="${sessionScope.budget == null}">
                                        <th class="text-center" colspan="2">Savings - 20%</th>
                                    </c:when>
                                    <c:otherwise>
                                        <th class="text-center" colspan="2">Savings - <c:out value="${sessionScope.budget.getSavings()}"/>%</th>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            </thead>
                            <tbody id="savingsBody"></tbody>
                        </table>
                    </div>
                </div>
                <h4 id="totalExpense" class="text-center bg-info border border-white">Total Expenses: $</h4>
                <h4 id="leftoverMoney" class="text-center bg-info border border-white">Left Over Money: $</h4>
            </div>
        </div>

        <div class="row d-flex flex-row justify-content-center my-2">
            <div class="d-flex flex-column align-items-center border border-white rounded" style="background-color: #999999">
                <h3 class="text-center">Money Stats</h3>
                <div class="col-lg-5">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Category</th>
                            <th>Allowed Amount</th>
                            <th>Target Percent</th>
                            <th>Actual Amount</th>
                            <th>Actual Percent</th>
                            <th>Surplus/Deficit</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Needs</td>
                            <td id="needsEstAmount">To be Imp</td>
                            <c:choose>
                                <c:when test="${sessionScope.budget == null}">
                                    <td>50%</td>
                                </c:when>
                                <c:otherwise>
                                    <td><c:out value="${sessionScope.budget.getNeeds()}"/>%</td>
                                </c:otherwise>
                            </c:choose>
                            <td id="needsActAmount"></td>
                            <td id="needsActPercent"></td>
                            <td id="needsAmountLeftOver"></td>
                        </tr>
                        <tr>
                            <td>Wants</td>
                            <td id="wantsEstAmount">To be Imp</td>
                            <c:choose>
                                <c:when test="${sessionScope.budget == null}">
                                    <td>30%</td>
                                </c:when>
                                <c:otherwise>
                                    <td><c:out value="${sessionScope.budget.getWants()}"/>%</td>
                                </c:otherwise>
                            </c:choose>
                            <td id="wantsActAmount"></td>
                            <td id="wantsActPercent"></td>
                            <td id="wantsAmountLeftOver"></td>
                        </tr>
                        <tr>
                            <td>Savings</td>
                            <td id="savingsEstAmount">To be Imp</td>
                            <c:choose>
                                <c:when test="${sessionScope.budget == null}">
                                    <td>20%</td>
                                </c:when>
                                <c:otherwise>
                                    <td><c:out value="${sessionScope.budget.getSavings()}"/>%</td>
                                </c:otherwise>
                            </c:choose>
                            <td id="savingsActAmount"></td>
                            <td id="savingsActPercent"></td>
                            <td id="savingsAmountLeftOver"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        let needsAmount = 0;
        let wantsAmount = 0;
        let savingsAmount = 0;
        let totalExpense = 0;
    </script>

    <c:forEach var="expense" items="${sessionScope.expenses}">
        <script>
            if("${expense.getTag()}" === "need"){

                let amountFormatted = parseFloat(${expense.getAmount()}).toFixed(2);
                let table = document.getElementById("needsBody");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);

                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn");
                editButton.classList.add("btn-primary");
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Expense";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${expense.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
                deleteButton.classList.add("btn");
                deleteButton.classList.add("btn-primary");
                deleteButton.type = "submit";

                let deleteButtonForm = document.createElement("form");
                deleteButtonForm.action = "Expense";
                deleteButtonForm.method = "POST";
                deleteButtonForm.appendChild(deleteButton);
                deleteButton.name = "deleteId";
                deleteButton.value = ${expense.getId()};

                cellBtns.appendChild(editButtonForm);
                cellBtns.appendChild(deleteButtonForm);


                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${expense.getName()}";
                amount.innerText = "$" + amountFormatted;
                cell.appendChild(name);
                cell.appendChild(amount);
                needsAmount += ${expense.getAmount()};
            }

            if("${expense.getTag()}" === "want"){
                let amountFormatted = parseFloat(${expense.getAmount()}).toFixed(2);
                let table = document.getElementById("wantsBody");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);
                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn");
                editButton.classList.add("btn-primary");
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Expense";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${expense.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
                deleteButton.classList.add("btn");
                deleteButton.classList.add("btn-primary");
                deleteButton.type = "submit";

                let deleteButtonForm = document.createElement("form");
                deleteButtonForm.action = "Expense";
                deleteButtonForm.method = "POST";
                deleteButtonForm.appendChild(deleteButton);
                deleteButton.name = "deleteId";
                deleteButton.value = ${expense.getId()};

                cellBtns.appendChild(editButtonForm);
                cellBtns.appendChild(deleteButtonForm);
                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${expense.getName()}";
                amount.innerText = "$" + amountFormatted;
                cell.appendChild(name);
                cell.appendChild(amount);
                wantsAmount += ${expense.getAmount()};
            }

            if("${expense.getTag()}" === "savings"){
                let amountFormatted = parseFloat(${expense.getAmount()}).toFixed(2);
                let table = document.getElementById("savingsBody");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);
                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn");
                editButton.classList.add("btn-primary");
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Expense";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${expense.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
                deleteButton.classList.add("btn");
                deleteButton.classList.add("btn-primary");
                deleteButton.type = "submit";

                let deleteButtonForm = document.createElement("form");
                deleteButtonForm.action = "Expense";
                deleteButtonForm.method = "POST";
                deleteButtonForm.appendChild(deleteButton);
                deleteButton.name = "deleteId";

                deleteButton.value = ${expense.getId()};

                cellBtns.appendChild(editButtonForm);
                cellBtns.appendChild(deleteButtonForm);
                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${expense.getName()}";
                amount.innerText = "$" + amountFormatted;
                cell.appendChild(name);
                cell.appendChild(amount);
                savingsAmount += ${expense.getAmount()};
            }
            totalExpense += ${expense.getAmount()};
        </script>
    </c:forEach>

    <script>
        document.getElementById("totalExpense").textContent += totalExpense.toFixed(2)
        let totalIncome = 0;
    </script>

    <c:forEach var="income" items="${sessionScope.incomes}">
        <script>
            {
                totalIncome += ${income.getAmount()};
                console.log(${income.getAmount()})
                let table = document.getElementById("incomeSourcesBody");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);

                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn");
                editButton.classList.add("btn-primary");
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Income";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${income.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
                deleteButton.classList.add("btn");
                deleteButton.classList.add("btn-primary");
                deleteButton.type = "submit";

                let deleteButtonForm = document.createElement("form");
                deleteButtonForm.action = "Income";
                deleteButtonForm.method = "POST";
                deleteButtonForm.appendChild(deleteButton);
                deleteButton.name = "deleteId";
                deleteButton.value = ${income.getId()};

                cellBtns.appendChild(editButtonForm);
                cellBtns.appendChild(deleteButtonForm);

                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${income.getName()}";
                amount.innerText = "$" + parseFloat(${income.getAmount()}).toFixed(2);
                cell.appendChild(name);
                cell.appendChild(amount);
            }
        </script>
    </c:forEach>

    <script>
        document.getElementById("income").textContent += totalIncome.toFixed(2);
        document.getElementById("leftoverMoney").textContent += (totalIncome - totalExpense).toFixed(2);
        if(totalIncome - totalExpense < 0){
            document.getElementById("leftoverMoney").style.color = "red";
        }
    </script>

    <script>
        document.getElementById("needsActAmount").innerText = "$" + needsAmount;
        document.getElementById("wantsActAmount").innerText = "$" + wantsAmount;
        document.getElementById("savingsActAmount").innerText = "$" + savingsAmount;
        document.getElementById("needsActPercent").innerText = ((needsAmount / totalIncome) * 100).toFixed(2) + "%"
        document.getElementById("wantsActPercent").innerText = ((wantsAmount / totalIncome) * 100).toFixed(2) + "%"
        document.getElementById("savingsActPercent").innerText = ((savingsAmount / totalIncome) * 100).toFixed(2) + "%"
    </script>

    <c:choose>
        <c:when test="${sessionScope.budget == null}">
            <script>
                let needsEstAmount = totalIncome * 0.5;
                let wantsEstAmount = totalIncome * 0.3;
                let savingsEstAmount = totalIncome * 0.2;
            </script>
        </c:when>
        <c:otherwise>
            <script>
                let needsEstAmount = totalIncome * ${sessionScope.budget.getNeeds() / 100};
                let wantsEstAmount = totalIncome * ${sessionScope.budget.getWants() / 100};
                let savingsEstAmount = totalIncome * ${sessionScope.budget.getSavings() / 100};
            </script>
        </c:otherwise>
    </c:choose>

    <script>
        document.getElementById("needsEstAmount").innerText = "$" + (needsEstAmount).toFixed(2);
        document.getElementById("wantsEstAmount").innerText = "$" + (wantsEstAmount).toFixed(2);
        document.getElementById("savingsEstAmount").innerText = "$" + (savingsEstAmount).toFixed(2);

        let needsAmountLeftOver = needsEstAmount - needsAmount;
        let wantsAmountLeftOver = wantsEstAmount - wantsAmount;
        let savingsAmountLeftOver = savingsEstAmount - savingsAmount;

        document.getElementById("needsAmountLeftOver").textContent = "$" + needsAmountLeftOver.toFixed(2)
        document.getElementById("wantsAmountLeftOver").textContent = "$" + wantsAmountLeftOver.toFixed(2)
        document.getElementById("savingsAmountLeftOver").textContent = "$" + savingsAmountLeftOver.toFixed(2)

        if(needsAmountLeftOver < 0){
            document.getElementById("needsAmountLeftOver").style.color = "red";
        }

        if(wantsAmountLeftOver < 0){
            document.getElementById("wantsAmountLeftOver").style.color = "red";
        }

        if(savingsAmountLeftOver < 0){
            document.getElementById("savingsAmountLeftOver").style.color = "red";
        }
    </script>
    <footer class="bg-dark border-top border-white rounded-top py-1" style="color: white; height: 50px;">
        <h3 class="my-0 pb-2 text-center" style="font-family: 'Dancing Script', cursive; font-weight: normal;">Inspired by poor money habits</h3>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
