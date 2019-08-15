<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User_table - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
    <script>
        $("document").ready(function () {
            $('#new-password, #new-password-confirm').on('keyup', function () {
                let message = $('#message');
                if ($('#new-password').val() === $('#new-password-confirm').val()
                    && $('#new-password').val() != ""
                    && $('#new-password-confirm').val() != "") {
                    message.html('Passwords match!')
                        .css('background-color', 'green')
                        .removeAttr("disabled");
                    setTimeout(function () {
                        message.html('Change your password').css('background-color', '');
                    }, 2000);
                } else {
                    message.html('Passwords do not match.')
                        .css('background-color', 'red')
                        .prop('disabled', true);
                }
            });

            $('#avatar-select').on('change', function () {
                var fileName = $(this).val();
                $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', ""));
            })
        });
    </script>
</head>
<body>
<%@ include file="/jsp/nav.jsp" %>
<div class="jumbotron">
    <h2 class="my-4">
        Welcome, user.
    </h2>
    <img class="avatar" src="${pageContext.request.contextPath}/img/avatars/default.png" alt="">
    <p class="lead mt-4 mx-4">
        To get started, use the navigation bar on top.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md-6">
                <h3 class="my-4">
                    Citizen information
                </h3>
                <!-- Sta parte va modificata in maniera dinamica! -->
                <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
                    <tr>
                        <th>Name</th>
                        <td>Matteo</td>
                    </tr>
                    <tr>
                        <th>Surname</th>
                        <td>Franzil</td>
                    </tr>
                    <tr>
                        <th>E-mail</th>
                        <td>rewqasdfcxz11@gmail.com</td>
                    </tr>
                    <tr>
                        <th>SSN</th>
                        <td>FRNMTT98E20I452H</td>
                    </tr>
                    <tr>
                        <th>Birthplace</th>
                        <td>Sassari (SS)</td>
                    </tr>
                    <tr>
                        <th>Birthdate</th>
                        <td>May 20, 1998</td> <!--USARE CLASSE DATA JSTL-->
                    </tr>
                    <tr>
                        <th>Current province</th>
                        <td>SASSARI SS</td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>Male</td>
                    </tr>
                    <tr>
                        <th>Practitioner</th>
                        <td>Francesca Annibaletti</td>
                    </tr>
                    <tr>
                        <th>Profile photo history</th>
                        <td>...DROPDOWN</td>
                    </tr>
                </table>

            </div>
            <div class="col-md-6">
                <h3 class="my-4">
                    Change your password
                </h3>
                <form action="change_password_handler" id="password" method="POST">
                    <div class="form-label-group">
                        <input class="form-control mb-2" id="old-password"
                               name="old-password" placeholder="Insert your current password" required type="password">
                        <input class="form-control mb-2" id="new-password"
                               name="new-password" placeholder="Insert your new password" required type="password">
                        <input class="form-control mb-2" id="new-password-confirm"
                               name="new-password-confirm" placeholder="Confirm your new password" required type="password">
                    </div>
                    <button id="message" class="btn btn-block mt-4 btn-personal" disabled type="submit">
                        Change password
                    </button>
                </form>
                <h3 class="my-4">
                    Change your profile picture
                </h3>
                <div class="input-group">
                    <form action="change_avatar_handler" id="avatar" method="POST" style="width: 100%">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input"
                                   name="avatar-select" id="avatar-select" accept="image/png, image/jpeg">
                            <label class="custom-file-label" for="avatar-select">Choose file</label>
                        </div>
                        <button class="btn btn-block mt-4 btn-personal" type="submit">
                            Upload
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
