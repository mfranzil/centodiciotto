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
    <div class="icon-container">
        <div class="hover-button" id="patient">
            <img alt="Patient" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/patient.png">
            <br>Patient
        </div>
        <div class="hover-button" id="general_practitioner">
            <img alt="General practitioner" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/general_practitioner.png">
            <br>General<br>practitioner
        </div>
        <div class="hover-button" id="specialized_doctor">
            <img alt="Specialized doctor" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/specialized_doctor.png">
            <br>Specialized<br>doctor
        </div>
        <div class="hover-button" id="chemist">
            <img alt="Chemist's" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/chemist.png">
            <br>Chemist's
        </div>
        <div class="hover-button" id="health_service">
            <img alt="Health Service" class="mb-2 icon"
                 src="${pageContext.request.contextPath}/img/classes/health_service.png">
            <br>Health Service
        </div>
    </div>
</div>
<div class="popup-window" id="form-window">
    <div class="popup animate-in">
        <div class="justify-content-center loading" id="loading-container"
             style="text-align: center; display: none !important">
            <img class="rotating" role="status" style="width: 64px"
                 src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading..."/>
        </div>
        <form action="${pageContext.request.contextPath}/login" id="login" method="POST">
            <div style="display: flex">
                <img id="form-image" class="mini-icon mr-2" style="place-self: center" src="" alt="...">
                <div class="width-100">
                    <div class="form-label-group mb-2">
                        <input autofocus class="form-control" id="user-id-login" name="userID"
                               placeholder="Email" required type="email">
                        <label for="user-id-login">Email</label>
                    </div>
                    <div class="form-label-group" style="margin: 0">
                        <input class="form-control" id="password-login" name="password"
                               placeholder="Password" required type="password">
                        <label for="password-login">Password</label>
                    </div>
                </div>
            </div>
            <div class="my-2" style="display: flex; margin-left: 72px">
                <div class="checkbox" style="flex: 50%;">
                    <label>
                        <input id="remember-me" name="rememberMe" type="checkbox">&nbsp;Remember me
                    </label>
                </div>
                <div style="text-align: right; flex: 50%">
                    <a href="#" id="to-recovery">Forgot your password?</a>
                </div>
            </div>
            <input name="role" id="role" type="hidden" value="none">
            <input name="referrer" id="referrer" type="hidden" value="${param.referrer}">
            <button class="btn btn-lg btn-block btn-personal" id="form-name" type="submit">Login</button>
            <button class="btn btn-lg btn-block btn-secondary popup-closer" type="button" id="close-form">Cancel</button>
        </form>
        <form action="${pageContext.request.contextPath}/password_reset"
              id="recovery" method="POST" style="display: none">
            <div id="message" class="center-100 mb-2">
                Insert your email.<br>We will send you a link to reset your password.
            </div>
            <div class="mb-2">
                <label for="user-id-recovery" style="display: none">Insert your e-mail</label>
                <input autofocus class="form-control" id="user-id-recovery" name="userID"
                       placeholder="Insert your e-mail" required type="email">
            </div>
            <input type="hidden" name="requestType" value="request">
            <button class="btn btn-lg btn-block btn-personal" type="submit" id="submit-recovery">Reset password</button>
            <button class="btn btn-lg btn-block btn-secondary" type="button" id="to-login">Back</button>
        </form>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>