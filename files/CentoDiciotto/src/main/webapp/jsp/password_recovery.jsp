<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset your password - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script>
        $("document").ready(function () {
            $("#password-reset").submit(function (e) {
                e.preventDefault();
                var form = $(this);
                var url = form.attr('action');

                $.ajax({
                    type: "POST",
                    url: url,
                    data: form.serialize(),
                    success: function (data) {
                        $('#email').css("background", "rgba(0, 255, 0, 0.2)").css("border-color", "green").val("");
                        $('#message').html("If " + $('#email').val() + " corresponds to a valid email," +
                            " you'll receive instructions for resetting your password in your inbox. <br>" +
                            "The link is valid for 24 hours.");
                        $('#submit').prop('disabled', true);
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
        <div class="md-c6" style="text-align: center; margin: auto 15%">
            <p id="message" class="mt-4">Insert your email and your new password, then confirm.</p>
            <form action="${pageContext.request.contextPath}/password_reset_handler"
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
                <button id="submit" class="btn btn-lg btn-block mt-4 btn-personal" type="submit">Reset password</button>
            </form>
        </div>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>