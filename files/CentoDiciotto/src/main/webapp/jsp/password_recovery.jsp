<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>

<% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
<c:redirect url="./"/>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset your password - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Forgot your password?</h1>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="md-c6" style="text-align: center; margin: auto 15%">
            <form action="reset_password_handler" id="form" method="POST">
                <div class="form-label-group">
                    <input autofocus class="form-control" id="username"
                           name="username" placeholder="Insert your e-mail" required type="email">
                </div>
                <p class="mt-4">We will send you a link to reset your password.</p>
                <button class="btn btn-lg btn-block mt-4 btn-personal" type="submit">Reset password</button>
            </form>
        </div>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>