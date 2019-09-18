<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tickets - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Tickets</h1>
    <p class="lead mt-4 mx-4">
        From this menu you can pay for your tickets.
    </p>
</div>

<div class="container">
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Doctor</th>
            <th scope="col">Exam</th>
            <th scope="col">Date</th>
            <th scope="col">Amount</th>
            <th scope="col">Ticket</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Mario Rossi</td>
            <td>ECG</td>
            <td>23/07/2019</td>
            <td>5$</td>
            <td>
                <input onclick='document.getElementById("myButton1").value="Payed"; this.disabled=true;' type="button" class="btn btn-block btn-personal" value="Pay" id="myButton1"
                       style="width:130px"/>
            </td>
        </tr>
        <tr>
        <tr>
            <td>Anita Bianchi</td>
            <td>ECG</td>
            <td>01/04/2019</td>
            <td>5$</td>
            <td>
                <input onclick='document.getElementById("myButton2").value="Payed"; this.disabled=true;' type="button" class="btn btn-block btn-personal" value="Pay" id="myButton2"
                        style="width:130px"/>
            </td>
        </tr>
        <tr>
            <td>Anita Bianchi</td>
            <td>ECG</td>
            <td>30/01/2019</td>
            <td>5$</td>
            <td>
                <input onclick='document.getElementById("myButton3").value="Payed"; this.disabled=true;' type="button" class="btn btn-block btn-personal" value="Pay" id="myButton3"
                       style="width:130px"/>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>