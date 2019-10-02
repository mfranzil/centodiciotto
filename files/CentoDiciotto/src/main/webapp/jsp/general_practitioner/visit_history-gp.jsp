<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.name {
                width: 35%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.action {
                width: 25%;
            }
        }
    </style>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Visit History</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the visits already done.
        You can add or modify a report.
    </p>
</div>

<div class="container">

    <div class="table-personal table-header">
        <div class="table-cell avt"></div>
        <div class="table-cell name">Name</div>
        <div class="table-cell ssn">SSN</div>
        <div class="table-cell action"></div>
    </div>

        <tr>
            <td>
                <img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                     alt="">
            </td>
            <th scope="row">Renato Lo Cigno</th>
            <td>20/07/2019</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Insert Report</button>
            </td>
        </tr>

</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>