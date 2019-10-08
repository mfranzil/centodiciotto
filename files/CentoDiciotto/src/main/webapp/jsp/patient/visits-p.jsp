<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your visit - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.practitioner {
                width: 40%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.report-state {
                width: 15%;
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
    <h1>Book a visit!</h1>
    <p class="lead mt-4 mx-4">
        Here you can book a visit to your practitioner.
    </p>
</div>

<div style="text-align: center;" class="container">
    <div style="width: 50%; margin: auto">
        <h4>Gino Perna</h4>
        <button type="button" class="btn btn-block btn-personal">Book now</button>
    </div>
</div>

<div class="jumbotron mt-4">
    <h1>Visit History</h1>
    <p class="lead mt-4 mx-4">
        Here you can see all the visits that you have done, and when the report will be avaiable
        you will be able to see it too.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell practitioner">Practitioner</div>
                    <div class="table-cell date">Date</div>
                    <div class="table-cell report-state">Report State</div>
                    <div class="table-cell action">Report</div>
                </div>
                <div class="table-personal">
                    <div class="table-cell practitioner">Gino Perna</div>
                    <div class="table-cell date">23/07/2019</div>
                    <div class="table-cell report-state">Not available</div>
                    <div class="table-cell action">
                        <button type="button" class="btn btn-block btn-personal" disabled>See Report</button>
                    </div>
                </div>
                <hr>
                <div class="table-personal">
                    <div class="table-cell practitioner">Luigi Verdi</div>
                    <div class="table-cell date">02/03/2018</div>
                    <div class="table-cell report-state">Available</div>
                    <div class="table-cell action">
                        <button type="button" class="btn btn-block btn-personal">See Report</button>
                    </div>
                </div>
                <hr>
            </div>
        </div>
    </div>
</div>

<%@ include file="/jsp/fragments/foot.jsp" %>
</body>