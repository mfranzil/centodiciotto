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
    <script>
        $("document").ready(function () {
            const url = window.href;
            $("#book-visit").submit(function (e) {
                e.preventDefault();

                let form = $(this);
                let button = form.find("button");

                button.prop("disabled", true).html("Requesting..");

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: form.serialize(),
                    success: function (data) {
                        button.html("Successfully booked");
                    }
                });
            });
        });
    </script>
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
        <jsp:useBean id="patientDAO"
                     class="it.unitn.web.centodiciotto.beans.entities.PatientDAOBean"/>
        <jsp:setProperty name="patientDAO" property="patientID"
                         value="${sessionScope.user.ID}"/>
        <jsp:setProperty name="patientDAO" property="init" value=""/>

        <c:set var="practitioner" value="${patientDAO.practitioner}"/>
        <c:set var="alreadyBooked" value="${!empty patientDAO.pendingVisit}"/>

        <h3>${practitioner}</h3>
        <form id="book-visit" method="post">
            <button class="btn btn-block btn-personal" type="submit"
            ${alreadyBooked ? "disabled" : ""}> ${alreadyBooked ? "Already booked" : "Book now"}
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

                <jsp:useBean id="practitionerDAO"
                             class="it.unitn.web.centodiciotto.beans.entities.GeneralPractitionerDAOBean"/>
                <jsp:setProperty name="practitionerDAO" property="init" value=""/>

                <jsp:useBean id="visitDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>

                <c:forEach items="${patientDAO.doneVisits}" var="exam">
                    <c:if test="${exam.practitionerID ne practitioner.ID}">
                        <jsp:setProperty name="practitionerDAO" property="practitionerID"
                                         value="${exam.practitionerID}"/>
                        <c:set var="visitPractitioner" value="${practitionerDAO.practitioner}"/>
                    </c:if>

                    <jsp:setProperty name="visitDate" property="date" value="${exam.date.time}"/>
                    <div class="table-personal">
                        <div class="table-cell practitioner">
                            <c:if test="${exam.practitionerID ne practitioner.ID}">
                                ${visitPractitioner}
                            </c:if>
                            <c:if test="${exam.practitionerID eq practitioner.ID}">
                                ${practitioner}
                            </c:if>
                        </div>
                        <div class="table-cell date">${visitDate.formattedDateTime}</div>
                        <div class="table-cell report-state">${exam.reportAvailable ? "Available" : "Not available"}</div>
                        <div class="table-cell action">
                            <button type="button" class="btn btn-block btn-personal popup-opener"
                                ${exam.reportAvailable ? "" : "disabled"} >See Report
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <div>
                                        <h5>Visit report:</h5>
                                        <p>${exam.report}</p>
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