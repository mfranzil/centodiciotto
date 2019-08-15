<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User_table - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
</head>
<body>
    <%@ include file="/jsp/nav.jsp" %>

    <table class="table" style="position: relative; left: 30px; top: 20px">
     <thead>
        <tr>
            <th scope="col">Exam</th>
            <th scope="col">Date</th>
            <th scope="col">Time</th>
            <th scope="col">Doctor</th>
        </tr>
     </thead>
        <tbody>
        <tr>
            <th scope="row">Biopsy</th>
            <td>23/07/2019</td>
            <td>13:45</td>
            <td>
                -
            </td>
        </tr>
        <tr>
            <th scope="row">ECG</th>
            <td>02/03/2018</td>
            <td>17:15</td>
            <td>-</td>
        </tr>
        <tr>
            <th scope="row">TAC</th>
            <td>23/09/2017</td>
            <td>16:00</td>
            <td>-</td>
        </tr>
        </tbody>
    </table>

</body>