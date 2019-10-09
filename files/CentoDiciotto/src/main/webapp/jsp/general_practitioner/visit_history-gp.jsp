<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="it.unitn.web.utils.Pair" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.name {
                width: 20%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.date {
                width: 15%;
            }

            .table-cell.action {
                width: 25%;
            }

            textarea {
                width: 550px;
                height: 150px;
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
        <div class="table-cell date">Date</div>
        <div class="table-cell action"></div>
    </div>
    <% List<Pair<Patient, Visit>> patient_visits_report = (List<Pair<Patient, Visit>>) request.getAttribute("patient_visits_report");
        for (Pair<Patient, Visit> tmp : patient_visits_report) {
            Date visit_date = new Date(tmp.getSecond().getVisitDate().getTime());
            Boolean insert = (tmp.getSecond().getReport() == null); %>
    <div class="table-personal">
        <div class="table-cell avt"><img class="avatar-small"
                                         src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                         alt="">
        </div>
        <div class="table-cell name"><%= tmp.getFirst().getFirstName()%> <%= tmp.getFirst().getLastName()%>
        </div>
        <div class="table-cell ssn"><%= tmp.getFirst().getSsn()%>
        </div>
        <div class="table-cell date">
            <c:set var="visit_date1" value="<%= visit_date %>"/>
            <fmt:formatDate type="date" dateStyle="long" value="${visit_date1}"/>
        </div>
        <div class="table-cell action">
            <button type="submit" class="btn btn-block btn-personal popup-opener"><% if (insert) {%>Insert<%} else {%>Edit<%}%>
                Report
            </button>
            <div class="popup-window">
                <div class="popup animate-in">
                    <form action="${pageContext.request.contextPath}/restricted/general_practitioner/visit_history"
                          id="set_visit" method="POST">
                        <h5><strong>Please enter the report in the form below, then click on submit to set it.</strong> </h5>
                        <% if (!insert) {%>
                        <h7><strong> Old report:</strong></h7>
                        <p> <%=tmp.getSecond().getReport()%></p>
                        <%}%>
                        <input type="hidden" value="<%= tmp.getSecond().getVisitID()%>" name="visit_id">
                        <textarea name="report_text" placeholder="Click here to start typing"></textarea>
                        <button class="btn btn-lg btn-block btn-personal" type="submit">
                            Submit report
                        </button>
                        <button class="btn btn-lg btn-block popup-closer btn-secondary" type="button">
                            Cancel
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%}%>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>