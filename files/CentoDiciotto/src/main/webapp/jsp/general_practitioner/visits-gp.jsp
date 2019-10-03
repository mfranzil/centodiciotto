<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visits - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Requests for visits</h1>
        <p class="lead mt-4 mx-4">
            For each pending visit, you can pick a date and time and confirm it.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">Patient</th>
                        <th scope="col">SSN</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                 alt="">
                        </td>
                        <th scope="row">Matteo Franzil</th>
                        <td>FRNMTT98E20I452H</td>
                        <td>
                            <button class="btn btn-block btn-personal popup-opener">
                                Choose date and time
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    Insert a date and time for the appointment, then confirm.
                                    <input class="form-control my-4" type="datetime-local">
                                    <button class="btn btn-lg btn-block btn-personal" type="submit">
                                        Confirm the appointment</button>
                                    <button class="btn btn-lg btn-block popup-closer btn-secondary" type="button">
                                        Cancel</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                 alt="">
                        </td>
                        <th scope="row">Alessia Marcolini</th>
                        <td>MRCLSS98C65L781O</td>
                        <td>
                            <button class="btn btn-block btn-personal popup-opener">
                                Choose date and time
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>