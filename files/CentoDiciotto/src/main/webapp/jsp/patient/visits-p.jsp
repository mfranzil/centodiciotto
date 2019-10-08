<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your visit - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
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
        <% GeneralPractitioner practitioner = (GeneralPractitioner) session.getAttribute("practitioner"); %>
        <h3><%= practitioner.getFirstName()%>  <%= practitioner.getLastName()%>
        </h3>
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
                <% List<Visit> visits = (List<Visit>) request.getAttribute("visits");
                    for (Visit visit : visits) {%>
                <div class="table-personal">
                    <div class="table-cell practitioner"><%= practitioner.getFirstName()%>  <%= practitioner.getLastName()%>
                    </div>
                    <div class="table-cell date"><%= visit.getVisitDate()%>
                    </div>
                    <div class="table-cell report-state"><% if (visit.getReportAvailable()) { %>Available <%} else {%>
                        Not Available <%}%></div>
                    <div class="table-cell action">
                        <button type="button"
                                class="btn btn-block btn-personal popup-opener" <% if (!visit.getReportAvailable()) { %>
                                disabled <%}%> >See Report
                        </button>
                        <div class="popup-window">
                            <div class="popup animate-in">
                                <div>
                                    <h5>Visit report:</h5>
                                    <br><br>
                                    <p><%= visit.getReport()%>
                                    </p>
                                </div>
                                <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%@ include file="/jsp/fragments/foot.jsp" %>
</body>