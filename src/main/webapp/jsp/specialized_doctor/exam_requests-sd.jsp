<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visits - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.image {
                width: 10%;
            }

            .table-cell.patient {
                width: 30%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.action {
                width: 30%;
            }
        }
    </style>
    <script>
        $("document").ready(function () {
            $(".set-visit").submit(function (e) {
                e.preventDefault();

                let form = $(this);
                let url = form.attr('action');
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
                defaultTime: '14:00',
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
        <h1>Requests for visits</h1>
        <p class="lead mt-4 mx-4">
            For each pending visit, you can pick a date and time and confirm it.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell image">&nbsp;</div>
                    <div class="table-cell patient">Patient</div>
                    <div class="table-cell ssn">SSN</div>
                    <div class="table-cell action">&nbsp;</div>
                </div>
                <jsp:useBean id="specialistDAOBean"
                             class="it.unitn.web.centodiciotto.beans.SpecializedDoctorDAOBean"/>
                <jsp:setProperty name="specialistDAOBean" property="specialistID"
                                 value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="specialistDAOBean" property="DAOFactory" value=""/>

                <jsp:useBean id="patientDAO"
                             class="it.unitn.web.centodiciotto.beans.PatientDAOBean"/>
                <jsp:setProperty name="patientDAO" property="DAOFactory" value=""/>


                <c:forEach items="${specialistDAOBean.pendingExams}" var="exam">
                    <jsp:setProperty name="patientDAO" property="patientID" value="${exam.patientID}"/>
                    <c:set var="patient" value="${patientDAO.patient}"/>
                    <div class="table-personal">
                        <div class="table-cell image">
                            <img class="avatar-small" alt=""
                                 src="${pageContext.request.contextPath}/${patientDAO.photoPath}">
                        </div>
                        <div class="table-cell patient">${patient.firstName} ${patient.lastName}</div>
                        <div class="table-cell ssn">${patient.SSN}</div>
                        <div class="table-cell action">
                            <button class="btn btn-block btn-personal popup-opener">
                                Choose date and time
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <form action="${pageContext.request.contextPath}/restricted/specialized_doctor/exam_requests"
                                          class="set-visit" method="POST">
                                        Insert a date and time for the appointment, then confirm.
                                        <div style="display: flex; width: 100%;">
                                            <label style="flex: 50%" class="my-2 mr-1">
                                                <input class="form-control datepicker visit-date" autocomplete="off"
                                                       type="text" name="examDate">
                                            </label>
                                            <label style="flex: 50%" class="my-2 ml-1">
                                                <input class="form-control timepicker visit-time" autocomplete="off"
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