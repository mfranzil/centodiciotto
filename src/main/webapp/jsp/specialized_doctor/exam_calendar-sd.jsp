<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam calendar - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.patient {
                width: 25%;
            }

            .table-cell.exam {
                width: 25%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.action {
                width: 20%;
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
    <h1>Exam Calendar</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the exams to be completed.
        You can mark them as done and they will be moved in your exam history, where you may add a report.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell avt">&nbsp;</div>
                    <div class="table-cell patient">Patient</div>
                    <div class="table-cell exam">Exam</div>
                    <div class="table-cell date">Date and time</div>
                    <div class="table-cell action"></div>
                </div>

                <jsp:useBean id="specialistDoctorDAO"
                             class="it.unitn.web.centodiciotto.beans.SpecializedDoctorDAOBean"/>
                <jsp:setProperty name="specialistDoctorDAO" property="specialistID"
                                 value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="specialistDoctorDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="patientDAO" class="it.unitn.web.centodiciotto.beans.PatientDAOBean"/>
                <jsp:setProperty name="patientDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="examDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>

                <c:forEach items="${specialistDoctorDAO.bookedExams}" var="exam">
                    <jsp:setProperty name="patientDAO" property="patientID" value="${exam.patientID}"/>
                    <c:set var="patient" value="${patientDAO.patient}"/>

                    <jsp:setProperty name="examDate" property="date" value="${exam.date}"/>
                    <div class="table-personal">
                        <div class="table-cell avt">
                            <img class="avatar-small" src="${pageContext.request.contextPath}/${patientDAO.photoPath}"
                                 alt="">
                        </div>
                        <div class="table-cell patient">${patient}</div>
                        <div class="table-cell patient">${exam.type.description}</div>
                        <div class="table-cell date">${examDate.formattedDateTime}</div>
                        <div class="table-cell action">
                            <form action="${pageContext.request.contextPath}/restricted/specialized_doctor/exam_calendar"
                                  class="mark-completed" method="POST">
                                <input type="hidden" value="${exam.ID}" name="examID">
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