<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- TODO change Exam history to proper title for all jsp pages !-->
    <title>Visit calendar - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>

    <style>
        @media (min-width: 992px) {
            .table-cell.image {
                width: 10%;
            }

            .table-cell.patient {
                width: 30%;
            }

            .table-cell.date {
                width: 15%;
            }

            .table-cell.time {
                width: 15%;
            }

            .table-cell.action {
                width: 30%;
            }
        }
    </style>

</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Visit Calendar</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the visits to be completed.
        You can mark them as done and they will be moved in your visit history, where you may add a report.
    </p>
</div>

<div class="container">
    <div class="table-personal table-header">
        <div class="table-cell image">&nbsp;</div>
        <div class="table-cell patient">Patient</div>
        <div class="table-cell date">Date</div>
        <div class="table-cell time">Time</div>
        <div class="table-cell action"></div>
    </div>

    <c:forEach items="${requestScope.patient_visits}" var="pair">
        <c:set var="patient" value="${pair.first}"/>
        <c:set var="visit" value="${pair.second}"/>
        <jsp:useBean id="visit_date" class="java.util.Date"/>
        <jsp:setProperty name="visit_date" property="time" value="${visit.visitDate.time}"/>

        <div class="table-personal">
            <div class="table-cell image">
                <img class="avatar-small"
                     src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png" alt="">
            </div>
            <div class="table-cell patient">${patient.firstName} ${patient.lastName}
            </div>
            <div class="table-cell date">
                <fmt:formatDate type="date" dateStyle="long" value="${visit_date}"/>
            </div>
            <div class="table-cell time"><fmt:formatDate pattern="HH:mm" value="${visit_date}"/>
            </div>
            <div class="table-cell action">
                <form action="${pageContext.request.contextPath}/restricted/general_practitioner/visit_calendar"
                      id="mark_completed" method="POST">
                    <input type="hidden" value="${visit.ID}" name="visit_id">
                    <button type="submit" class="btn btn-block btn-personal ">Mark as completed</button>
                </form>
            </div>
        </div>
        <hr>
    </c:forEach>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>