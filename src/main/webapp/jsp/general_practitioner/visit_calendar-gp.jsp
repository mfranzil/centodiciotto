<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visit calendar - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 7%;
            }

            .table-cell.patient {
                width: 38%;
            }

            .table-cell.date {
                width: 35%;
            }

            .table-cell.action {
                width: 20%;
            }
        }
    </style>
    <script>
        $("document").ready(() => {
            const url = window.location.href;
            $(".mark-completed").submit(function (e) {
                e.preventDefault();

                let form = $(this);
                let button = form.find("button");

                button.prop("disabled", true).html("Completing...");

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: form.serialize(),
                    success: () => {
                        button.html("Completed");
                    },
                    error: () => {
                        button.prop("disabled", false).html("Mark as completed");
                    }
                });
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Visit Calendar</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the visits to be completed.<br>
        You can mark them as done and they will be moved in your visit history, where you may add a report.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell avt">&nbsp;</div>
                    <div class="table-cell patient">Patient</div>
                    <div class="table-cell date">Date and time</div>
                    <div class="table-cell action"></div>
                </div>

                <jsp:useBean id="practitionerID"
                             class="it.unitn.web.centodiciotto.beans.entities.GeneralPractitionerDAOBean"/>
                <jsp:setProperty name="practitionerID" property="practitionerID"
                                 value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="practitionerID" property="init" value=""/>

                <jsp:useBean id="patientDAO" class="it.unitn.web.centodiciotto.beans.entities.PatientDAOBean"/>
                <jsp:setProperty name="patientDAO" property="init" value=""/>

                <jsp:useBean id="visitDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>

                <jsp:useBean id="currentDate" class="java.util.Date"/>

                <c:forEach items="${practitionerID.notDoneVisits}" var="visit">
                    <jsp:setProperty name="patientDAO" property="patientID" value="${visit.patientID}"/>
                    <c:set var="patient" value="${patientDAO.patient}"/>

                    <jsp:setProperty name="visitDate" property="date" value="${visit.date.time}"/>
                    <div class="table-personal">
                        <div class="table-cell avt">
                            <img class="avatar-small" src="${pageContext.request.contextPath}/${patientDAO.photoPath}"
                                 alt="">
                        </div>
                        <div class="table-cell patient">${patient}
                        </div>
                        <div class="table-cell date">${visitDate.formattedDateTime}</div>
                        <div class="table-cell action">
                            <form class="mark-completed" method="POST">
                                <input type="hidden" value="${visit.ID}" name="visitID">
                                <c:if test="${visit.date.time le currentDate.time}">
                                    <button type="submit" class="btn btn-block btn-personal">Mark as completed</button>
                                </c:if>
                                <c:if test="${visit.date.time gt currentDate.time}">
                                    <button type="button"
                                            class="btn btn-block btn-personal disabled">Visit not completed yet
                                    </button>
                                </c:if>
                            </form>
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