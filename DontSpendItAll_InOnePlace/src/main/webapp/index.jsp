<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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
    </div>
</nav>
<div class="container">
    <div class="row mt-5">
        <div class="offset-4 col-4 bg-info border border-black rounded">
            <h2 class="text-center">Login</h2>
            <form class="d-flex flex-column" action="login" method="POST">
                <label for="username">Username</label>
                <input class="form-control" id="username" type="text" name="username"/>

                <label for="password">Password</label>
                <input class="form-control" id="password" type="password" name="password"/>

                <button class="btn btn-primary my-2" type="submit">Login</button>
            </form>
            <c:choose>
                <c:when test="${requestScope.errorLoggingIn != null}">
                    <p><c:out value="${requestScope.errorLoggingIn}"/></p>
                </c:when>
            </c:choose>
            <p></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>