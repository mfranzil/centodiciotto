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
    <h1>Visit Calendar</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the visits to be completed.
        You can mark them as done and they will be moved in your visit history, where you may add a report.
    </p>
</div>

<div class="container">
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">&nbsp;</th>
            <th scope="col">Patient</th>
            <th scope="col">Date</th>
            <th scope="col">Time</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                     alt="">
            </td>
            <th scope="row">Alberto Montresor</th>
            <td>23/07/2019</td>
            <td>15:00</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Mark as completed</button>
            </td>
        </tr>
        <tr>
            <td>
                <img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                     alt="">
            </td>
            <th scope="row">Renato Lo Cigno</th>
            <td>20/07/2019</td>
            <td>17:20</td>
            <td>
                <button type="button" class="btn btn-block btn-personal" disabled>Completed</button>
            </td>
        </tr>
        <tr>
            <td>
                <img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                     alt="">
            </td>
            <th scope="row">Anneliese De Franceschi</th>
            <td>18/07/2019</td>
            <td>09:30</td>
            <td>
                <button type="button" class="btn btn-block btn-personal" disabled>Completed</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>