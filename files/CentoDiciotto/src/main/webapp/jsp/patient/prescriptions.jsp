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
    <h1>Prescriptions</h1>
    <p class="lead mt-4 mx-4">
        In this section you can download the prescriptions not yet provided.
    </p>
</div>

<div class="container">
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Doctor</th>
            <th scope="col">Date</th>
            <th scope="col">State</th>
            <th scope="col">Prescription</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">Mario Rossi</th>
            <td>23/07/2019</td>
            <td>Available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Download</button>
            </td>
        </tr>
        <tr>
        <tr>
            <th scope="row">Anita Bianchi</th>
            <td>01/04/2019</td>
            <td>Already delivered</td>
            <td>
                <button type="button" class="btn btn-block btn-personal" disabled>Download</button>
            </td>
        </tr>
        <tr>
            <th scope="row">Anita Bianchi</th>
            <td>30/01/2019</td>
            <td>Already delivered</td>
            <td>
                <button type="button" class="btn btn-block btn-personal" disabled>Download</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>