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
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <h1>Welcome: <c:out value="${sessionScope.user.getfName()}"/> <c:out value="${sessionScope.user.getlName()}"/></h1>

    <script>
        let totalIncome = 0;
    </script>

    <h4 id="income">Income: </h4>

    <c:forEach var="income" items="${sessionScope.incomes}">
        <script>
            console.log(${income.getAmount()});
            totalIncome += ${income.getAmount()};
        </script>
    </c:forEach>
    <script>
        document.getElementById("income").innerText = "Income: $" + totalIncome.toFixed(2);
    </script>
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
        Add expense
    </button>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
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
                        <input type="number" id="amount" name="amount">

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

                        <button type="submit">Submit</button>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">

            <c:choose>
                <c:when test="${requestScope.edit == true}">
                    <div class="col-lg-2">
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
                            <input type="number" id="amountEdit" name="amount" value="${requestScope.expenseToEdit.getAmount()}">

                            <label for="date">Transaction date:</label>

                            <input type="date" id="dateEdit" name="date" value="${requestScope.expenseToEdit.getTransaction_date()}"/>

                            <button type="submit" name="editId" value="${requestScope.expenseToEdit.getId()}">Submit</button>
                        </form>
                        <form action="Expense" method="get"><button name="refresh" value="true" type="submit">Exit</button></form>
                    </div>
                </c:when>
            </c:choose>


            <div class="col-lg-3">
                <table id="needs" class="table">
                    <thead>
                        <tr>
                            <c:choose>
                                <c:when test="${sessionScope.budget == null}">
                                    <th>Needs - 50%</th>
                                </c:when>
                                <c:otherwise>
                                    <th>Needs - <c:out value="${sessionScope.budget.getNeeds()}"/>%</th>
                                </c:otherwise>
                            </c:choose>
                            <th></th>
                        </tr>
                    </thead>
                </table>
            </div>

            <div class="col-lg-3">
                <table id="wants" class="table">
                    <thead>
                        <tr>
                            <c:choose>
                                <c:when test="${sessionScope.budget == null}">
                                    <th>Wants - 30%</th>
                                </c:when>
                                <c:otherwise>
                                    <th>Wants - <c:out value="${sessionScope.budget.getWants()}"/>%</th>
                                </c:otherwise>
                            </c:choose>
                            <th></th>
                        </tr>
                    </thead>
                </table>
            </div>

            <div class="col-lg-3">
                <table id="savings" class="table">
                    <thead>
                        <tr>
                            <c:choose>
                                <c:when test="${sessionScope.budget == null}">
                                    <th>Savings - 20%</th>
                                </c:when>
                                <c:otherwise>
                                    <th>Savings - <c:out value="${sessionScope.budget.getSavings()}"/>%</th>
                                </c:otherwise>
                            </c:choose>
                            <th></th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Category</th>
                            <th>Allowed Amount</th>
                            <th>Target Percent</th>
                            <th>Actual Amount</th>
                            <th>Actual Percent</th>
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
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        let needsAmount = 0;
        let wantsAmount = 0;
        let savingsAmount = 0;
    </script>
    <c:forEach var="expense" items="${sessionScope.expenses}">
        <script>
            if("${expense.getTag()}" === "need"){
                let amountFormatted = parseFloat(${expense.getAmount()}).toFixed(2);
                let table = document.getElementById("needs");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);

                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Expense";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${expense.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
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
                let table = document.getElementById("wants");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);
                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Expense";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${expense.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
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
                let table = document.getElementById("savings");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let cellBtns = row.insertCell(1);
                let editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.type = "submit";

                let editButtonForm = document.createElement("form");
                editButtonForm.action = "Expense";
                editButtonForm.method = "GET";
                editButtonForm.appendChild(editButton);
                editButton.name = "editId";
                editButton.value = ${expense.getId()};

                let deleteButton = document.createElement("button");
                deleteButton.textContent = "Delete";
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
        </script>
    </c:forEach>

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
                document.getElementById("needsEstAmount").innerText = "$" + (totalIncome * 0.5).toFixed(2);
                document.getElementById("wantsEstAmount").innerText = "$" + (totalIncome * 0.3).toFixed(2);
                document.getElementById("savingsEstAmount").innerText = "$" + (totalIncome * 0.2).toFixed(2);
            </script>
        </c:when>
        <c:otherwise>
            <script>
                document.getElementById("needsEstAmount").innerText = "$" + (totalIncome * ${sessionScope.budget.getNeeds() / 100}).toFixed(2);
                document.getElementById("wantsEstAmount").innerText = "$" + (totalIncome * ${sessionScope.budget.getWants() / 100}).toFixed(2);
                document.getElementById("savingsEstAmount").innerText = "$" + (totalIncome * ${sessionScope.budget.getSavings() / 100}).toFixed(2);
            </script>
        </c:otherwise>
    </c:choose>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
