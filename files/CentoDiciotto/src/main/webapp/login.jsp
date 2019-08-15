<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
<c:redirect url="./"/>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="/jsp/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Login as...</h1>
    </div>
</div>
<div style="text-align: center; display: flex; overflow: fragments; flex-wrap: wrap; padding-left: 10vh; padding-right: 10vh">
    <div class="hover-button focused" id="citizen" onclick="openMenu(this.id)">
        <img alt="Citizen" class="mb-2" src="${pageContext.request.contextPath}/img/classes/citizen.png" style="width: 128px">
        <br>Citizen
    </div>
    <div class="hover-button focused" id="medic" onclick="openMenu(this.id)">
        <img alt="General practitioner" class="mb-2" src="${pageContext.request.contextPath}/img/classes/medic.png" style="width: 128px;">
        <br>General practitioner
    </div>
    <div class="hover-button focused" id="specialized-medic" onclick="openMenu(this.id)">
        <img alt="Specialized doctor" class="mb-2" src="${pageContext.request.contextPath}/img/classes/specialized-medic.png" style="width: 128px;">
        <br>Specialized doctor
    </div>
    <div class="hover-button focused" id="chemist" onclick="openMenu(this.id)">
        <img alt="Chemist's" class="mb-2" src="${pageContext.request.contextPath}/img/classes/chemist.png" style="width: 128px;">
        <br>Chemist's
    </div>
    <div class="hover-button focused" id="health-service" onclick="openMenu(this.id)">
        <img alt="Health Service" class="mb-2" src="${pageContext.request.contextPath}/img/classes/health-service.png" style="width: 128px;">
        <br>Health Service
    </div>
</div>
<div class="login_modal" id="form_window">
    <form action="login_handler" class="login animate-in" id="form" method="POST">
        <div style="width: 100%; text-align:center;">
            <img id="form_image" style="width: 32px" src="" alt="...">
        </div>
        <div class="mb-2" id="form_name" style="width: 100%; text-align: center">
            Logging in as...
        </div>
        <div class="form-label-group">
            <input autofocus class="form-control" id="username" name="username" placeholder="Username" required type="email">
            <label for="username">
                Username
            </label>
        </div>
        <div class="form-label-group">
            <input class="form-control" id="password" name="password" placeholder="Password" required type="password">
            <label for="password">Password</label>
        </div>
        <div class="mb-2" style="display: flex">
            <div class="checkbox" style="flex: 50%;">
                <label>
                    <input name="rememberMe" type="checkbox" value="true"> Remember me
                </label>
            </div>
            <div style="text-align: right; flex: 50%">
                <a href="${pageContext.request.contextPath}/password_recovery">Forgot your password?</a>
            </div>
        </div>
        <button class="btn btn-lg bg-118-dark btn-block white" type="submit">Login</button>
        <button class="btn btn-lg btn-secondary btn-block" type="button" onclick="closeForm()">Cancel</button>
    </form>
</div>
</body>
</html>