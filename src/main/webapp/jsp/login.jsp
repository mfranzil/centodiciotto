<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Login as...</h1>
    </div>
    <div class="flex-wrap">
        <div class="hover-button focused" id="patient">
            <img alt="Patient" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/patient.png">
            <br>Patient
        </div>
        <div class="hover-button focused" id="general_practitioner">
            <img alt="General practitioner" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/general_practitioner.png">
            <br>General practitioner
        </div>
        <div class="hover-button focused" id="specialized_doctor">
            <img alt="Specialized doctor" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/specialized_doctor.png">
            <br>Specialized doctor
        </div>
        <div class="hover-button focused" id="chemist">
            <img alt="Chemist's" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/chemist.png">
            <br>Chemist's
        </div>
        <div class="hover-button focused" id="health_service">
            <img alt="Health Service" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/health_service.png">
            <br>Health Service
        </div>
    </div>
</div>
<div class="popup-window" id="form-window">
    <div class="popup animate-in">
        <div class="justify-content-center loading" id="loading-container" style="text-align: center; display: none !important">
            <img class="rotating" role="status" style="width: 64px"
                 src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading.."/>
        </div>
        <form action="${pageContext.request.contextPath}/login" id="login" method="POST">
            <div class="center-100">
                <img id="form-image" style="width: 32px" src="" alt="...">
            </div>
            <div class="mb-2 center-100" id="form-name">
                Logging in as...
            </div>
            <input name="role" id="role" type="hidden" value="none">
            <input name="referrer" id="referrer" type="hidden" value="${pageContext.request.getParameter('referrer')}">
            <div class="form-label-group">
                <input autofocus class="form-control" id="user-id-login" name="userID"
                       placeholder="Email" required type="email">
                <label for="user-id-login">Email</label>
            </div>
            <div class="form-label-group">
                <input class="form-control" id="password-login" name="password"
                       placeholder="Password" required type="password">
                <label for="password-login">Password</label>
            </div>
            <div class="mb-2" style="display: flex">
                <div class="checkbox" style="flex: 50%;">
                    <label>
                        <input id="remember-me" name="rememberMe" type="checkbox">Remember me
                    </label>
                </div>
                <div style="text-align: right; flex: 50%">
                    <a href="#" id="to-recovery">Forgot your password?</a>
                </div>
            </div>
            <button class="btn btn-lg btn-block btn-personal" type="submit">Login</button>
            <button class="btn btn-lg btn-block btn-secondary" type="button" id="close-form">Cancel</button>
        </form>
        <form action="${pageContext.request.contextPath}/request_password_reset"
              id="recovery" method="POST" style="display: none">
            <div id="message" class="center-100 mb-2">
                Insert your email.<br>We will send you a link to reset your password.
            </div>
            <div class="mb-2">
                <label for="user-id-recovery" style="display: none">Insert your e-mail</label>
                <input autofocus class="form-control" id="user-id-recovery" name="userID"
                       placeholder="Insert your e-mail" required type="email">
            </div>
            <button class="btn btn-lg btn-block btn-personal" type="submit" id="submit-recovery">Reset password</button>
            <button class="btn btn-lg btn-block btn-secondary" type="button" id="to-login">Back</button>
        </form>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>