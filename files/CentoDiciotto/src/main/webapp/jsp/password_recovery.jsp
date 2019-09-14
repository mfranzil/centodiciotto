<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>

<%
    String loginUrl = request.getParameter("login_url");
    String email = request.getParameter("email");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset your password - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/new_password.js"></script>
    <script>
        $("document").ready(function () {
            $("#password-reset").submit(function (e) {
                e.preventDefault();
                let form = $(this);
                let url = form.attr('action');

                $.ajax({
                    type: "POST",
                    url: url,
                    data: form.serialize(),
                    success: function (__data) {
                        $("#message").html("Password changed successfully.");
                        $("#new-password,#new-password-confirm,#email").slideUp();
                        $("#password-change-button").html("Go to login").click(function (e){
                            e.preventDefault();
                            window.location = window.location.pathname.substring(
                                0, window.location.pathname.indexOf("/", 2)) + "/login";
                        });
                    },
                    error: function (data) {
                        alert("Errore durante il cambiamento della password. L'email inserita non corrisponde.");
                        $('#email').css("background", "rgba(255, 0, 0, 0.2)")
                            .css("border-color", "red");
                        setTimeout(function () {
                            $('#email').css("background", "").css("border-color", "");
                        }, 2000);
                    }
                });
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Let's reset your password.</h1>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="mt-4" style="text-align: center; margin: auto 15%">
            <p id="message" class="mt-4">Insert your email and your new password, then confirm.</p>
            <form action="${pageContext.request.contextPath}/finalize_password_reset"
                  id="password-reset" method="POST">
                <div class="form-label-group">
                    <input autofocus class="form-control mb-2" id="email" name="email"
                           placeholder="Insert your e-mail" required type="email">
                    <input class="form-control mb-2" id="new-password" name="new-password"
                           placeholder="Insert your new password"
                           required type="password">
                    <input class="form-control mb-2" id="new-password-confirm" name="new-password-confirm"
                           placeholder="Confirm your new password"
                           required type="password">
                </div>
                <button id="password-change-button"
                        class="btn btn-lg btn-block mt-4 btn-personal" type="submit">Reset password</button>
            </form>
        </div>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>