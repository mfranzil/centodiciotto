<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User_table - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
</head>
<body>
    <%@ include file="/jsp/nav.jsp" %>

    <div class="jumbotron mt-4">
        <h1>Exam History</h1>
        <p class="lead mt-4 mx-4">
            In this section you can see all the exams you have ever done.
            It will be possible to view the report when available.
        </p>
    </div>

    <div class="col-md-10" style="margin-left:auto; margin-right:auto">
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
        <tr>
            <th scope="row">Biopsy</th>
            <td>23/07/2019</td>
            <td>Not avaiable</td>
            <td>
                <button type="button" class="btn btn-block mt-4 btn-personal" disabled>See Report</button>
            </td>
        </tr>
        <tr>
            <th scope="row">ECG</th>
            <td>02/03/2018</td>
            <td>Avaiable</td>
            <td><button type="button" class="btn btn-block mt-4 btn-personal">See Report</button>
            </td>
        </tr>
        <tr>
            <th scope="row">TAC</th>
            <td>23/09/2017</td>
            <td>Avaiable</td>
            <td><button type="button" class="btn btn-block mt-4 btn-personal">See Report</button>
            </td>
        </tr>
        </tbody>
    </table>
    </div>

</body>