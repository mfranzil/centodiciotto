<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam requests - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.patient {
                width: 30%;
            }

            .table-cell.exam {
                width: 30%;
            }

            .table-cell.action {
                width: 30%;
            }
        }
    </style>
    <script>
        $("document").ready(function () {
            const url = window.location.href;

            $(".set-exam").submit(function (e) {
                e.preventDefault();

                let form = $(this);
                let button = form.find("button.submit");
                let data = form.serialize();

                button.prop("disabled", true).html("Confirming..");

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: data,
                    success: function (data) {
                        button.html("Confirmed");
                    }
                });
            });

            $(".datepicker").datepicker({
                dateFormat: "dd/mm/yy",
                beforeShowDay: $.datepicker.noWeekends,
                defaultDate: +1,
                firstDay: 1,
                minDate: 1,
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
            });

            $('input.timepicker').timepicker({
                timeFormat: 'HH:mm',
                interval: 15,
                minTime: '8:30',
                maxTime: '19:00',
                defaultTime: '8:30',
                startTime: '8:30',
                dropdown: true,
                scrollbar: true
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Requests for exams</h1>
        <p class="lead mt-4 mx-4">
            For each pending exam, you can pick a date and time and confirm it.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell avt">&nbsp;</div>
                    <div class="table-cell patient">Patient</div>
                    <div class="table-cell exam">SSN</div>
                    <div class="table-cell action">&nbsp;</div>
                </div>

                <jsp:useBean id="patientDAO"
                             class="it.unitn.web.centodiciotto.beans.entities.PatientDAOBean"/>
                <jsp:setProperty name="patientDAO" property="DAOFactory" value=""/>

                <c:choose>
                    <c:when test="${sessionScope.role eq 'specialized_doctor'}">
                        <jsp:useBean id="doctorDAO" class="it.unitn.web.centodiciotto.beans.entities.SpecializedDoctorDAOBean"/>
                        <jsp:setProperty name="doctorDAO" property="doctorID" value="${sessionScope.user.ID}"/>
                        <jsp:setProperty name="doctorDAO" property="DAOFactory" value=""/>
                    </c:when>
                    <c:when test="${sessionScope.role eq 'health_service'}">
                        <jsp:useBean id="healthServiceDAO" class="it.unitn.web.centodiciotto.beans.entities.HealthServiceDAOBean"/>
                        <jsp:setProperty name="healthServiceDAO" property="healthServiceID" value="${sessionScope.user.ID}"/>
                        <jsp:setProperty name="healthServiceDAO" property="DAOFactory" value=""/>
                    </c:when>
                </c:choose>

                <c:choose>
                    <c:when test="${sessionScope.role eq 'specialized_doctor'}">
                        <c:set var="chosenDAO" value="${doctorDAO}"/>
                    </c:when>
                    <c:when test="${sessionScope.role eq 'health_service'}">
                        <c:set var="chosenDAO" value="${healthServiceDAO}"/>
                    </c:when>
                </c:choose>

                <c:forEach items="${chosenDAO.pendingExams}" var="exam">
                    <jsp:setProperty name="patientDAO" property="patientID" value="${exam.patientID}"/>
                    <c:set var="patient" value="${patientDAO.patient}"/>
                    <div class="table-personal">
                        <div class="table-cell avt">
                            <img class="avatar-small" alt=""
                                 src="${pageContext.request.contextPath}/${patientDAO.photoPath}">
                        </div>
                        <div class="table-cell patient">${patient.firstName} ${patient.lastName}</div>
                        <div class="table-cell exam">${exam.type.description}</div>
                        <div class="table-cell action">
                            <button class="btn btn-block btn-personal popup-opener">
                                Choose date and time
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <form class="set-exam" method="POST">
                                        Insert a date and time for the appointment, then confirm.
                                        <div style="display: flex; width: 100%;">
                                            <label style="flex: 50%" class="my-2 mr-1">
                                                <input class="form-control datepicker exam-date" autocomplete="off"
                                                       type="text" name="examDate">
                                            </label>
                                            <label style="flex: 50%" class="my-2 ml-1">
                                                <input class="form-control timepicker exam-time" autocomplete="off"
                                                       type="text" name="examTime">
                                            </label>
                                        </div>
                                        <input type="hidden" value="${patient.ID}" name="patientID">
                                        <input type="hidden" value="${exam.type.ID}" name="examID">
                                        <button class="btn btn-lg btn-block btn-personal submit" type="submit">
                                            Confirm the appointment
                                        </button>
                                        <button class="btn btn-lg btn-block popup-closer btn-secondary" type="button">
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
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>