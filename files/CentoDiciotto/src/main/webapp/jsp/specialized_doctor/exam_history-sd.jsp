<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Exam History</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the exams already done.
        You can add or modify a report.
    </p>
</div>

<div class="container">
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">&nbsp;</th>
            <th scope="col">Patient</th>
            <th scope="col">Exam</th>
            <th scope="col">Date</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <img class="avatar-small" src="${pageContext.request.contextPath}/img/avatars/default.png"
                     alt="">
            </td>
            <th scope="row">Renato Lo Cigno</th>
            <td>ECG</td>
            <td>20/07/2019</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Insert Report</button>
            </td>
        </tr>
        <tr>
            <td>
                <img class="avatar-small" src="${pageContext.request.contextPath}/img/avatars/default.png"
                     alt="">
            </td>
            <th scope="row">Anneliese De Franceschi</th>
            <td>ECG</td>
            <td>18/07/2019</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Modify Report</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>