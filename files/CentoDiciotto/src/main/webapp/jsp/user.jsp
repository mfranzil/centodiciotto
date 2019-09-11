<%@ page import="it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My profile - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/user.js"></script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron">
    <h2 class="my-4">
        Welcome, <%= displayName %>.
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
                    My information
                </h3>
                <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
                    <% switch (role) {
                        case "patient": { %>
                    <tr>
                        <th>Name</th>
                        <td><%= ((Patient)user).getFirstName() %></td>
                    </tr>
                    <tr>
                        <th>Surname</th>
                        <td><%= ((Patient)user).getLastName() %></td>
                    </tr>
                    <tr>
                        <th>E-mail</th>
                        <td><%= ((Patient)user).getEmail() %></td>
                    </tr>
                    <tr>
                        <th>SSN</th>
                        <td><%= ((Patient)user).getSsn() %></td>
                    </tr>
                    <tr>
                        <th>Birthplace</th>
                        <td><%= ((Patient)user).getBirthPlace() %></td>
                    </tr>
                    <tr>
                        <th>Birthdate</th>
                        <c:set var = "birthdate" value = "<%=((Patient)user).getBirthDate()%>" />
                        <td> <fmt:formatDate type = "date" dateStyle = "long"  value = "${birthdate}" /></td>
                    </tr>
                    <tr>
                        <th>Current province</th>
                        <td><%= ((Patient)user).getLivingProvince() %></td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>Male</td>
                    </tr>
                    <tr>
                        <th>Practitioner</th>
                        <%= ((Patient) user).getGeneralPractitionerEmail() %>
                        <td><%= ((Patient)user).getGeneralPractitionerEmail() %></td>
                    </tr>
                    <tr>
                        <th>Profile photo history</th>
                        <td>...DROPDOWN</td>
                    </tr>
                    <% }; break;
                        case "general_practitioner" : { %>
                    <tr>
                        <th>Name</th>
                        <td><%= ((GeneralPractitioner)user).getFirstName() %></td>
                    </tr>
                    <tr>
                        <th>Surname</th>
                        <td><%= ((GeneralPractitioner)user).getLastName() %></td>
                    </tr>
                    <tr>
                        <th>E-mail</th>
                        <td><%= ((GeneralPractitioner)user).getEmail() %></td>
                    </tr>
                    <tr>
                        <th>Working province</th>
                        <td><%= ((GeneralPractitioner)user).getWorkingProvince() %></td>
                    </tr>
                    <% }; break;
                        default: break;}%>
                </table>
            </div>
            <div class="col-md-6">
                <h3 class="my-4">
                    Change your password
                </h3>
                <form action="restricted/password_change_handler" id="password" method="POST">
                    <div class="form-label-group">
                        <input class="form-control mb-2" id="old-password" name="old-password"
                               placeholder="Insert your current password"
                               required type="password">
                        <input class="form-control mb-2" id="new-password" name="new-password"
                               placeholder="Insert your new password"
                               required type="password">
                        <input class="form-control mb-2" id="new-password-confirm" name="new-password-confirm"
                               placeholder="Confirm your new password"
                               required type="password">
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
                        <button class="btn btn-block mt-4 btn-personal" type="submit" formaction="${pageContext.request.contextPath}/restricted/patient/photo_gallery">
                            See gallery
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>
