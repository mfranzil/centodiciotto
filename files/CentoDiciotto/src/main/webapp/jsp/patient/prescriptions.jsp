<%@ page import="java.util.List" %>
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
        <% List<Prescription> prescriptions = (List<Prescription>) request.getAttribute("prescriptions"); %>
        <% for (Prescription prescription : prescriptions) {%>
        <tr>
            <th scope="row"><%=prescription.getPrescriptionPractitioner()%></th>
            <td><%=prescription.getPrescriptionDate()%></td>
            <td>Available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Download</button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>