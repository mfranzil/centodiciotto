<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User profile - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/user.js"></script>
    <script src="${pageContext.request.contextPath}/js/newPassword.js"></script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron">
    <h2 class="my-4">
        Welcome, ${sessionScope.displayName}.
    </h2>
    <c:if test="${sessionScope.role eq 'patient'}">
        <jsp:useBean id="patientDAO" class="it.unitn.web.centodiciotto.beans.entities.PatientDAOBean"/>
        <jsp:setProperty name="patientDAO" property="patientID" value="${sessionScope.user.ID}"/>
        <jsp:setProperty name="patientDAO" property="init" value=""/>

        <jsp:useBean id="birth" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>
        <jsp:setProperty name="birth" property="date" value="${sessionScope.user.birthDate.time}"/>

        <c:set var="practitioner" value="${patientDAO.practitioner}"/>
        <img class="avatar" src="${patientDAO.photoPath}" alt="">
    </c:if>
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
                <table class="table table-unresponsive" style="margin: auto; overflow-wrap: break-word">
                    <c:choose>
                        <c:when test="${sessionScope.role eq 'patient'}">
                            <tr>
                                <th>Name</th>
                                <td>${sessionScope.user.firstName}</td>
                            </tr>
                            <tr>
                                <th>Surname</th>
                                <td>${sessionScope.user.lastName} </td>
                            </tr>
                            <tr>
                                <th>E-mail</th>
                                <td>${sessionScope.user.ID} </td>
                            </tr>
                            <tr>
                                <th>Gender</th>
                                <td>${sessionScope.user.fullGender}</td>
                            </tr>
                            <tr>
                                <th>SSN</th>
                                <td>${sessionScope.user.SSN} </td>
                            </tr>
                            <tr>
                                <th>Birthplace</th>
                                <td>${sessionScope.user.birthPlace} </td>
                            </tr>
                            <tr>
                                <th>Birthdate</th>
                                <td>${birth.formattedDate}</td>
                            </tr>
                            <tr>
                                <th>Living place</th>
                                <td>${sessionScope.user.livingPlace}</td>
                            </tr>
                            <tr>
                                <th>Living province</th>
                                <td>${sessionScope.user.livingProvince}</td>
                            </tr>
                            <tr>
                                <th>Practitioner</th>
                                <td>${practitioner}</td>
                            </tr>
                        </c:when>
                        <c:when test="${sessionScope.role eq 'general_practitioner'}">
                            <tr>
                                <th>Name</th>
                                <td>${sessionScope.user.firstName}</td>
                            </tr>
                            <tr>
                                <th>Surname</th>
                                <td>${sessionScope.user.lastName}</td>
                            </tr>
                            <tr>
                                <th>E-mail</th>
                                <td>${sessionScope.user.ID}</td>
                            </tr>
                            <tr>
                                <th>Working place</th>
                                <td>${sessionScope.user.workingPlace}</td>
                            </tr>
                            <tr>
                                <th>Working province</th>
                                <td>${sessionScope.user.workingProvince}</td>
                            </tr>
                        </c:when>
                        <c:when test="${sessionScope.role eq 'specialized_doctor'}">
                            <tr>
                                <th>Name</th>
                                <td>${sessionScope.user.firstName}</td>
                            </tr>
                            <tr>
                                <th>Surname</th>
                                <td>${sessionScope.user.lastName}</td>
                            </tr>
                            <tr>
                                <th>E-mail</th>
                                <td>${sessionScope.user.ID}</td>
                            </tr>
                            <tr>
                                <th>Working place</th>
                                <td>${sessionScope.user.workingPlace}</td>
                            </tr>
                        </c:when>
                        <c:when test="${sessionScope.role eq 'health_service'}">
                            <tr>
                                <th>Operating Province</th>
                                <td>${sessionScope.user.operatingProvince}
                                </td>
                            </tr>
                        </c:when>
                        <c:when test="${sessionScope.role eq 'chemist'}">
                            <tr>
                                <th>Name</th>
                                <td>${sessionScope.user.name} </td>
                            </tr>
                            <tr>
                                <th>E-mail</th>
                                <td>${sessionScope.user.ID} </td>
                            </tr>
                            <tr>
                                <th>Working place</th>
                                <td>${sessionScope.user.workingPlace}</td>
                            </tr>
                            <tr>
                                <th>Working province</th>
                                <td>${sessionScope.user.province} </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <th>Error</th>
                                <td>Not supported yet</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </table>
            </div>
            <div class="col-md-6">
                <h3 class="my-4">
                    Change your password
                </h3>
                <form action="${pageContext.request.contextPath}/restricted/user"
                      id="password-change" method="POST">
                    <div class="form-label-group">
                        <input class="form-control mb-2" id="old-password" name="oldPassword"
                               placeholder="Insert your current password"
                               required type="password">
                        <input class="form-control mb-2" id="new-password" name="newPassword"
                               placeholder="Insert your new password"
                               required type="password">
                        <input class="form-control mb-2" id="new-password-confirm" name="newPasswordConfirm"
                               placeholder="Confirm your new password"
                               required type="password">
                        <input type="hidden" name="requestType" value="passwordChange">
                    </div>
                    <button id="password-change-button" class="btn btn-block mt-2 btn-personal" disabled type="submit">
                        Change password
                    </button>
                </form>
                <c:if test="${sessionScope.role eq 'patient'}">
                    <h3 class="my-4">
                        Change your profile picture
                    </h3>
                    <div class="input-group">
                        <form action="${pageContext.request.contextPath}/restricted/user"
                              id="avatar" class="center-100" method="POST" enctype="multipart/form-data">
                            <div class="custom-file" style="z-index: 0; text-align: left">
                                <input type="file" class="custom-file-input"
                                       name="avatarSelect" id="avatar-select" accept="image/png, image/jpeg">
                                <label class="custom-file-label" for="avatar-select">Choose file</label>
                                <input id="extension" type="hidden" name="extension" value="none">
                            </div>
                            <button class="btn btn-block mt-2 btn-personal" id="upload-avatar" type="submit">
                                Upload
                            </button>
                        </form>
                        <form class="center-100"
                              action="${pageContext.request.contextPath}/restricted/patient/photo_gallery">
                            <button class="btn btn-block mt-2 btn-personal" type="submit">
                                See gallery
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>
