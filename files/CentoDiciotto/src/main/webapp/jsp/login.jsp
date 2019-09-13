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
        <div class="hover-button focused" id="patient">
            <img alt="pPtient" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/patient.png"
                 style="width: 128px">
            <br>Patient
        </div>
        <div class="hover-button focused" id="general_practitioner">
            <img alt="General practitioner" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/general_practitioner.png"
                 style="width: 128px;">
            <br>General practitioner
        </div>
        <div class="hover-button focused" id="specialized_doctor">
            <img alt="Specialized doctor" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/specialized_doctor.png"
                 style="width: 128px;">
            <br>Specialized doctor
        </div>
        <div class="hover-button focused" id="chemist">
            <img alt="Chemist's" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/chemist.png"
                 style="width: 128px;">
            <br>Chemist's
        </div>
        <div class="hover-button focused" id="health_service">
            <img alt="Health Service" class="mb-2"
                 src="${pageContext.request.contextPath}/img/classes/health_service.png"
                 style="width: 128px;">
            <br>Health Service
        </div>
    </div>
</div>
<div class="popup_window" id="form-window">
    <div class="popup animate-in">
        <form action="${pageContext.request.contextPath}/login_handler" id="login" method="POST">
            <div style="width: 100%; text-align:center;">
                <img id="form-image" style="width: 32px" src="" alt="...">
            </div>
            <div class="mb-2" id="form-name" style="width: 100%; text-align: center">
                Logging in as...
            </div>
            <input name="role" id="role" type="hidden" value="none">
            <div class="form-label-group">
                <input autofocus class="form-control" id="email-login" name="email" placeholder="Email" required
                       type="email">
                <label for="email-login">Email</label>
            </div>
            <div class="form-label-group">
                <input class="form-control" id="password-login" name="password" placeholder="Password" required
                       type="password">
                <label for="password-login">Password</label>
            </div>
            <div class="mb-2" style="display: flex">
                <div class="checkbox" style="flex: 50%;">
                    <label>
                        <input id="remember-me" name="remember-me" type="checkbox">Remember me
                    </label>
                </div>
                <div style="text-align: right; flex: 50%">
                    <a href="#" id="to-recovery">Forgot your password?</a>
                </div>
            </div>
            <button class="btn btn-lg btn-block btn-personal" type="submit">Login</button>
            <button class="btn btn-lg btn-block btn-secondary" type="button" id="close-form">Cancel</button>
        </form>
        <form action="${pageContext.request.contextPath}/password_reset_handler"
              id="recovery" method="POST" style="display: none">
            <div id="message" class="mb-2" style="width: 100%; text-align: center">
                Insert your email.<br>We will send you a link to reset your password.
            </div>
            <div class="mb-2">
                <input autofocus class="form-control" id="email-recovery" name="email"
                       placeholder="Insert your e-mail" required type="email">
            </div>
            <button class="btn btn-lg btn-block btn-personal" type="submit" id="submit-recovery">Reset password</button>
            <button class="btn btn-lg btn-block btn-secondary" type="button" id="to-login">Cancel</button>
        </form>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>