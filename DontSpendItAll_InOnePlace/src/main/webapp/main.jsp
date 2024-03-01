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
    <h1>Worked!</h1>
    <h1><c:out value="${requestScope.user.getfName()}"/></h1>
    <h1><c:out value="${requestScope.user.getlName()}"/></h1>
</body>
</html>
