<%--suppress ELValidationInJSP --%>
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
        Here you can book a visit to your practitioner:
    </p>
</div>

<div style="text-align: center;" class="container">
    <div style="width: 50%; margin: auto">

        <c:set var="practitioner" value="${sessionScope.practitioner}"/>
        <c:set var="already_booked" value="${requestScope.already_booked}"/>
        <h3>${practitioner.firstName} ${practitioner.lastName}</h3>
        <form action="${pageContext.request.contextPath}/restricted/patient/visits" id="book_visit" method="post">
            <button id="booknow" class="btn btn-block btn-personal" type="submit"
            ${already_booked ? "disabled" : ""}> ${already_booked ? "Already booked" : "Book now"}
            </button>
        </form>
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
                <c:forEach items="${requestScope.visits}" var="visit">

                    <!-- TODO: MODIFICARE IL NOME/COGNOME DEL MEDICO -->
                    <div class="table-personal">
                        <div class="table-cell practitioner">{practitioner.firstName} {practitioner.lastName}
                        </div>
                        <div class="table-cell date">${visit.date}
                        </div>
                        <div class="table-cell report-state">${visit.reportAvailable ? "Available" : "Not available"}</div>
                        <div class="table-cell action">
                            <button type="button" class="btn btn-block btn-personal popup-opener"
                                ${visit.reportAvailable ? "" : "disabled"} >See Report
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <div>
                                        <h5>Visit report:</h5>
                                        <br>
                                        <p>${visit.report}</p>
                                    </div>
                                    <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<%@ include file="/jsp/fragments/foot.jsp" %>
</body>