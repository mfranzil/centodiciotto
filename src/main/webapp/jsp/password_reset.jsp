<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset your password - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/new_password.js"></script>
    <script>
        $("document").ready(function () {
            const url = window.href;
            $("#password-reset").submit(function (e) {
                e.preventDefault();
                let form = $(this);

                if ($("#user-id").val() !== "${requestScope.userID}") {
                    alert("Invalid email provided.");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: form.serialize(),
                    success: function (__data) {
                        $("#message").html("Password changed successfully.");
                        $("#new-password,#new-password-confirm,#user-id").slideUp();
                        $("#password-change-button").html("Go to login").click(function (e) {
                            e.preventDefault();
                            window.location = getContextPath() + "/login";
                        });
                    },
                    error: function (data) {
                        alert("Error while changing password");
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
            <form action="${pageContext.request.contextPath}/password_reset"
                  id="password-reset" method="POST">
                <div class="form-label-group">
                    <input autofocus class="form-control mb-2" id="user-id" name="userID"
                           placeholder="Insert your e-mail" required type="email">
                    <input class="form-control mb-2" id="new-password" name="newPassword"
                           placeholder="Insert your new password" required type="password">
                    <input class="form-control mb-2" id="new-password-confirm" name="newPasswordConfirm"
                           placeholder="Confirm your new password" required type="password">
                </div>
                <input type="hidden" name="requestType" value="confirm">
                <button id="password-change-button"
                        class="btn btn-lg btn-block mt-4 btn-personal" type="submit">Reset password
                </button>
            </form>
        </div>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>