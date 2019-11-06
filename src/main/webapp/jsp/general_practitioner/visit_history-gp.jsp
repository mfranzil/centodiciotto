<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visit history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
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
        }
    </style>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <script>
        $("document").ready(function () {
            const url = getContextPath() + "/restricted/general_practitioner/visit_history";

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "ssn", type: "string", text: "SSN"},
                {field: "date", type: "string", text: "Date"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#history_table").createTableHeaders(tableHeaders);
            renderPatientsRows();

            function renderPatientsRows() {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "patientList",
                    },
                    url: url,
                    success: function (json) {
                        console.log(json);
                        $("#history_table").insertRows(tableHeaders, json, url);
                        enablePopup();
                    }
                });
            }
        });
    </script>
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

    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div id="history_table">

                    <c:forEach items="${requestScope.patient_visits_report}" var="pair">
                        <c:set var="patient" value="${pair.first}"/>
                        <c:set var="visit" value="${pair.second}"/>
                        <c:set var="insert" value="${empty visit.report}"/>
                        <jsp:useBean id="visitDate" class="java.util.Date"/>
                        <jsp:setProperty name="visitDate" property="time" value="${visit.date.time}"/>

                        <div class="table-personal">
                            <div class="table-cell avt"><img class="avatar-small"
                                                             src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                                             alt="">
                            </div>
                            <div class="table-cell name">${patient.firstName} ${patient.lastName}
                            </div>
                            <div class="table-cell ssn">${patient.SSN}
                            </div>
                            <div class="table-cell date">
                                <fmt:formatDate type="date" dateStyle="long" value="${visitDate}"/>
                            </div>
                            <div class="table-cell action">
                                <button type="submit"
                                        class="btn btn-block btn-personal popup-opener">${insert ? "Insert" : "Edit"}
                                    Report
                                </button>
                                <div class="popup-window">
                                    <div class="popup animate-in">
                                        <form action="${pageContext.request.contextPath}/restricted/general_practitioner/visit_history"
                                              id="set_visit" method="POST">
                                            <h5><strong>Please enter the report in the form below, then click on submit
                                                to
                                                set it.</strong></h5>
                                            <c:if test="${!insert}">
                                                <h7><strong> Old report:</strong></h7>
                                                <p>${visit.report}</p>
                                            </c:if>
                                            <input type="hidden" value="${visit.ID}" name="visitID">
                                            <textarea name="reportText"
                                                      placeholder="Click here to start typing"></textarea>
                                            <button class="btn btn-lg btn-block btn-personal" type="submit">
                                                Submit report
                                            </button>
                                            <button class="btn btn-lg btn-block popup-closer btn-secondary"
                                                    type="button">
                                                Cancel
                                            </button>
                                        </form>
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
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>