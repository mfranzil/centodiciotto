<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Prescription history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Prescriptions</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the prescription provided.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <form action="search_patient" method="POST">
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <!--TO DO SIMONE BARRA DI RICERCA:
                        Si dovrebbero cercare le ricette emesse, sia per nome di farmaco che per nome di
                        paziente. Quindi, in questo caso, il risultato può non essere univoco.
                         -->
                        <input class="form-control mx-2" id="query" name="query"
                               placeholder="Search..." required type="text">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
                <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
                    <thead>
                    <tr>
                        <th scope="col">Doctor</th>
                        <th scope="col">Patient</th>
                        <th scope="col">Prescription Date</th>
                        <th scope="col">Delivery Date</th>
                        <th scope="col">Prescription</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">Mario Rossi</th>
                        <td>Nome Cognome</td>
                        <td>23/07/2019</td>
                        <td>25/07/2019</td>
                        <td>
                            <button type="button" class="btn btn-block btn-personal">Download</button>
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <th scope="row">Anita Bianchi</th>
                        <td>Nome Cognome</td>
                        <td>01/04/2019</td>
                        <td>10/04/2019</td>
                        <td>
                            <button type="button" class="btn btn-block btn-personal">Download</button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Anita Bianchi</th>
                        <td>Nome Cognome</td>
                        <td>30/01/2019</td>
                        <td>12/02/2019</td>
                        <td>
                            <button type="button" class="btn btn-block btn-personal">Download</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>