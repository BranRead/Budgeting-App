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

    <h4>Income: </h4>

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

    <table id="needs">
        <tr>
            <th>Needs</th>
        </tr>
        <tr>
            <c:choose>
                <c:when test="${sessionScope.budget == null}">
                    <td>50%</td>
                </c:when>
                <c:otherwise>
                    <td><c:out value="${sessionScope.budget.getNeeds()}"/>%</td>
                </c:otherwise>
            </c:choose>
        </tr>
    </table>

    <table id="wants">
        <tr>
            <th>Wants</th>
        </tr>
        <tr>
            <c:choose>
                <c:when test="${sessionScope.budget == null}">
                    <td>30%</td>
                </c:when>
                <c:otherwise>
                    <td><c:out value="${sessionScope.budget.getWants()}"/>%</td>
                </c:otherwise>
            </c:choose>
        </tr>
    </table>

    <table id="savings">
        <tr>
            <th>Savings</th>
        </tr>
        <tr>
            <c:choose>
                <c:when test="${sessionScope.budget == null}">
                    <td>20%</td>
                </c:when>
                <c:otherwise>
                    <td><c:out value="${sessionScope.budget.getSavings()}"/>%</td>
                </c:otherwise>
            </c:choose>
        </tr>
    </table>

    <table>
        <tr>
            <th>Category</th>
            <th>Allowed Amount</th>
            <th>Target Percent</th>
            <th>Actual Amount</th>
            <th>Actual Percent</th>
        </tr>
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
    </table>
    <script>
        let needsAmount = 0;
        let wantsAmount = 0;
        let savingsAmount = 0;
    </script>
    <c:forEach var="expense" items="${sessionScope.expenses}">
        <script>
            if("${expense.getTag()}" === "need"){
                let table = document.getElementById("needs");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${expense.getName()}";
                amount.innerText = "$${expense.getAmount()}";
                cell.appendChild(name);
                cell.appendChild(amount);
                needsAmount += ${expense.getAmount()};
            }

            if("${expense.getTag()}" === "want"){
                let table = document.getElementById("wants");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${expense.getName()}";
                amount.innerText = "$${expense.getAmount()}";
                cell.appendChild(name);
                cell.appendChild(amount);
                wantsAmount += ${expense.getAmount()};
            }

            if("${expense.getTag()}" === "savings"){
                let table = document.getElementById("savings");
                let row = table.insertRow(-1);
                let cell = row.insertCell(0);
                let name = document.createElement("p");
                let amount = document.createElement("p");
                name.innerText = "${expense.getName()}";
                amount.innerText = "$${expense.getAmount()}";
                cell.appendChild(name);
                cell.appendChild(amount);
                savingsAmount += ${expense.getAmount()};
            }

            document.getElementById("needsActAmount").innerText = "$" + needsAmount;
            document.getElementById("wantsActAmount").innerText = "$" + wantsAmount;
            document.getElementById("savingsActAmount").innerText = "$" + savingsAmount;
        </script>
    </c:forEach>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
