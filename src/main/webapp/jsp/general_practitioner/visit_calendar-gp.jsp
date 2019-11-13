<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
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
                width: 30%;
            }

            .table-cell.action {
                width: 30%;
            }
        }
    </style>
    <script>
        $("document").ready(function () {
            $(".mark-completed").submit(function (e) {
                e.preventDefault();

                let form = $(this);
                let url = form.attr('action');
                let button = form.find("button");

                button.prop("disabled", true).html("Sending..");

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: form.serialize(),
                    success: function (data) {
                        button.html("Completed");
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
        In this section you can see all the visits to be completed.
        You can mark them as done and they will be moved in your visit history, where you may add a report.
    </p>
</div>


<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell image">&nbsp;</div>
                    <div class="table-cell patient">Patient</div>
                    <div class="table-cell date">Date and time</div>
                    <div class="table-cell action"></div>
                </div>

                <jsp:useBean id="generalPractitionerDAO"
                             class="it.unitn.web.centodiciotto.beans.GeneralPractitionerDAOBean"/>
                <jsp:setProperty name="generalPractitionerDAO" property="practitionerID"
                                 value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="generalPractitionerDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="patientDAO" class="it.unitn.web.centodiciotto.beans.PatientDAOBean"/>
                <jsp:setProperty name="patientDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="visitDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>

                <c:forEach items="${generalPractitionerDAO.bookedVisits}" var="visit">
                    <jsp:setProperty name="patientDAO" property="patientID" value="${visit.patientID}"/>
                    <c:set var="patient" value="${patientDAO.patient}"/>

                    <jsp:setProperty name="visitDate" property="date" value="${visit.date}"/>
                    <div class="table-personal">
                        <div class="table-cell image">
                            <img class="avatar-small" src="${pageContext.request.contextPath}/${patientDAO.photoPath}"
                                 alt="">
                        </div>
                        <div class="table-cell patient">${patient}
                        </div>
                        <div class="table-cell date">${visitDate.formattedDateTime}</div>
                        <div class="table-cell action">
                            <form action="${pageContext.request.contextPath}/restricted/general_practitioner/visit_calendar"
                                  class="mark-completed" method="POST">
                                <input type="hidden" value="${visit.ID}" name="visitID">
                                <button type="submit" class="btn btn-block btn-personal">Mark as completed</button>
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