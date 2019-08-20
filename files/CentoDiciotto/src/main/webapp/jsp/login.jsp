<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
<c:redirect url="./"/>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
<%--<% if (request.getAttribute("loginResult") != null && request.getAttribute("loginResult") == "true") {%>
    <script>
        alert("Invalid username or password, please try again.");
    </script>
    <% }%>--%>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Login as...</h1>
    </div>
    <div style="text-align: center; display: flex; flex-wrap: wrap">
        <div class="hover-button focused" id="citizen" onclick="openMenu(this.id)">
            <img alt="Citizen" class="mb-2" src="${pageContext.request.contextPath}/img/classes/citizen.png"
                 style="width: 128px">
            <br>Citizen
        </div>
        <div class="hover-button focused" id="general_practitioner" onclick="openMenu(this.id)">
            <img alt="General practitioner" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/general_practitioner.png" style="width: 128px;">
            <br>General practitioner
        </div>
        <div class="hover-button focused" id="specialized_doctor" onclick="openMenu(this.id)">
            <img alt="Specialized doctor" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/specialized_doctor.png" style="width: 128px;">
            <br>Specialized doctor
        </div>
        <div class="hover-button focused" id="chemist" onclick="openMenu(this.id)">
            <img alt="Chemist's" class="mb-2" src="${pageContext.request.contextPath}/img/classes/chemist.png"
                 style="width: 128px;">
            <br>Chemist's
        </div>
        <div class="hover-button focused" id="health_service" onclick="openMenu(this.id)">
            <img alt="Health Service" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/health_service.png"
                 style="width: 128px;">
            <br>Health Service
        </div>
    </div>
</div>
<div class="popup_window" id="form_window">
    <form action="login_handler" class="popup animate-in" id="form" method="POST">
        <div style="width: 100%; text-align:center;">
            <img id="form_image" style="width: 32px" src="" alt="...">
        </div>
        <div class="mb-2" id="form_name" style="width: 100%; text-align: center">
            Logging in as...
        </div>
        <input name="role" id="role" type="hidden" value="none">
        <div class="form-label-group">
            <input autofocus class="form-control" id="username" name="username" placeholder="Username" required
                   type="email">
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
                    <input name="rememberMe" type="checkbox" value="true">Remember me
                </label>
            </div>
            <div style="text-align: right; flex: 50%">
                <a href="${pageContext.request.contextPath}/password_recovery">Forgot your password?</a>
            </div>
        </div>
        <button class="btn btn-lg btn-block btn-personal" type="submit">Login</button>
        <button class="btn btn-lg btn-block btn-secondary" type="button" onclick="closeForm()">Cancel</button>
    </form>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>