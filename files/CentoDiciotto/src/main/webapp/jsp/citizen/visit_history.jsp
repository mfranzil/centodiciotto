<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visit history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Visit History</h1>
    <p class="lead mt-4 mx-4">
        Here you can see all the visits that you have done, and when the report will be avaiable
        you will be able to see it too.
    </p>
</div>

<div class="container">
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Visit specialist</th>
            <th scope="col">Specialization</th>
            <th scope="col">Date</th>
            <th scope="col">Report State</th>
            <th scope="col">Report</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Mario Rossi</td>
            <th scope="row">Cardiology</th>
            <td>23/07/2019</td>
            <td>Not available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal" disabled>See Report</button>
            </td>
        </tr>
        <tr>
            <td>Luigi Verdi</td>
            <th scope="row">Edocrinology</th>
            <td>02/03/2018</td>
            <td>Available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">See Report</button>
            </td>
        </tr>
        <tr>
            <td>Veronica Bianchi</td>
            <th scope="row">Endocrinology</th>
            <td>23/09/2017</td>
            <td>Available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">See Report</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>