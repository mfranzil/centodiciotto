<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your exam - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/search.js"></script>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/css/select2.min.css">

    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.specialist {
                width: 20%;
            }

            .table-cell.specialization {
                width: 15%;
            }

            .table-cell.exam {
                width: 40%;
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
    <h1>Book Your Exam</h1>
    <p class="lead mt-4 mx-4">
        You can search for the exam you need via the appropriate search menu.
        The exam date will be established by the specialist doctor.
    </p>
</div>

<div class="container">
    <div class="form-group">
        <form action="${pageContext.request.contextPath}/restricted/patient/exam_booking" id="exam_booking"
              method="GET">
            <select id="exam-search" name="exam-search" class="form-control select2-allow-clear" autofocus
                    style="width: 95%">
            </select>
            <button id="message" class="btn btn-personal" type="submit">
                <i class="fa fa-search"></i>
            </button>
        </form>
    </div>

    <div class="table-personal table-header">
        <div class="table-cell specialist">Specialist</div>
        <div class="table-cell specialization">Specialization</div>
        <div class="table-cell exam">Exam</div>
        <div class="table-cell action"></div>
    </div>
    <!-- TODO change to more clean version to check if exam is prescrivable !-->
    <% List<ExamList> examLists = (List<ExamList>) request.getAttribute("exam_list");
        List<ExamPrescription> examPrescriptions = (List<ExamPrescription>) request.getAttribute("exam_prescription"); %>
    <% for (ExamList examList : examLists) {
        boolean active = false;
        for (ExamPrescription examPrescription : examPrescriptions) {
            if (examPrescription.getExamType() == examList.getExamID() && !examPrescription.getExamBooked()) {
                active = true;
            }
        } %>
    <div class="table-personal" id="table-select">
        <div class="table-cell specialist">Mario Rossi</div>
        <div class="table-cell specialization">Qualcosa</div>
        <div class="table-cell exam"><%= examList.getExamDescription() %>
        </div>
        <div class="table-cell action">
            <button type="button" <% if (!active) { %> disabled <%}%>  class="btn btn-block btn-personal popup-opener">
                Book
                Now
            </button>
            <div class="popup-window">
                <div class="popup animate-in">
                    <div>
                        <h4>Prenota presso un medico specialista</h4>
                        <p>Io
                        </p>
                    </div>
                    <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                </div>
            </div>
        </div>
    </div>
    <% } %>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>