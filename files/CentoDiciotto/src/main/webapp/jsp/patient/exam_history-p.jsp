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
    <h1>Exam History</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the exams you have ever done.
        It will be possible to view the report when available.
    </p>
</div>

<div class="container">
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Exam</th>
            <th scope="col">Date</th>
            <th scope="col">Report State</th>
            <th scope="col">Report</th>
        </tr>
        </thead>
        <tbody>
        <% List<Exam> exams_history = (List<Exam>) request.getAttribute("exams"); %>
        <% for (Exam exam : exams_history) {%>
        <tr>
            <th scope="row"> <%= exam.getExamDescription() %></th>
            <td> <%= exam.getExamDate() %></td>
            <td> <% if(exam.getExamDone()){ %> Available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">See Report</button>
            </td>
            <% } else { %> Not Available</td>
            <td>
                <button type="button" class="btn btn-block btn-personal" disabled>See Report</button>
            </td>
            <%}%>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>