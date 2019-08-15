<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User_table - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
</head>
<body>
    <%@ include file="/jsp/nav.jsp" %>

    <table class="table">
     <thead>
        <tr>
            <th scope="col">Exam</th>
            <th scope="col">Date</th>
            <th scope="col">Report State</th>
            <th scope="col">Report</th>
        </tr>
     </thead>
        <tbody>
        <tr>
            <th scope="row">Biopsy</th>
            <td>23/07/2019</td>
            <td>Not avaiable</td>
            <td>
                <button type="button" class="btn btn-lg btn-primary" disabled>See Report</button>
            </td>
        </tr>
        <tr>
            <th scope="row">ECG</th>
            <td>02/03/2018</td>
            <td>Avaiable</td>
            <td><button type="button" class="btn btn-lg btn-primary">See Report</button>
            </td>
        </tr>
        <tr>
            <th scope="row">TAC</th>
            <td>23/09/2017</td>
            <td>Avaiable</td>
            <td><button type="button" class="btn btn-lg btn-primary">See Report</button>
            </td>
        </tr>
        </tbody>
    </table>

</body>