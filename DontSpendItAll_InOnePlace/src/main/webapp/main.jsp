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
</head>
<body>
    <h1>Welcome: <c:out value="${requestScope.user.getfName()}"/> <c:out value="${requestScope.user.getlName()}"/></h1>

    <h4>Income: </h4>



    <table>
        <tr>
            <th>Needs</th>
            <th>Wants</th>
            <th>Savings</th>
        </tr>
        <tr>
            <c:choose>
                <c:when test="${sessionScope.budget == null}">
                    <td>50%</td>
                    <td>30%</td>
                    <td>20%</td>
                </c:when>
                <c:otherwise>
                    <td><c:out value="${sessionScope.budget.getNeeds()}"/>%</td>
                    <td><c:out value="${sessionScope.budget.getWants()}"/>%</td>
                    <td><c:out value="${sessionScope.budget.getSavings()}"/>%</td>
                </c:otherwise>
            </c:choose>
            <c:forEach var="transaction" items="${sessionScope.transactions}">

            </c:forEach>
        </tr>
    </table>
</body>
</html>
