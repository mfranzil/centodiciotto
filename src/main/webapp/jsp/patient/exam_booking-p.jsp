<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your exam - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/search.js"></script>
    <script src="${pageContext.request.contextPath}/js/ajax.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/css/select2.min.css">
    <style>
        @media (min-width: 992px) {
            .table-cell.exam {
                width: 75%;
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
    <div class="form-group" style="display: flex; width: 100%; margin: auto">
        <select id="exam-search" name="examSearch" class="select2-allow-clear form-control mr-1"
                style="margin: 1em" autofocus>
        </select>
        <button id="message" class="btn btn-personal" type="submit">
            <i class="fa fa-search"></i>
        </button>
        <button id="my_filter" class="btn btn-personal ml-1" type="button">
            Available Exams
        </button>
    </div>

    <div class="table-personal table-header">
        <div class="table-cell exam">Exam</div>
        <div class="table-cell action"></div>
    </div>

    <div id="main-table">
        <!-- TODO change to more clean version to check if exam is prescrivable !-->
        <c:forEach items="${requestScope.examLists}" var="examList">
            <c:set var="active" value="${false}"/>
            <c:forEach items="${requestScope.examPrescriptions}" var="examPrescription">
                <c:if test="${examPrescription.examType eq examList.ID and !examPrescription.booked}">
                    <c:set var="active" value="${true}"/>
                </c:if>
            </c:forEach>
            <div class="table-personal" id="table-select">
                <div class="table-cell exam">${examList.description} </div>
                <div class="table-cell action">
                    <button type="button" ${active ? "" : "disabled" } class="btn btn-block btn-personal popup-opener">
                        Book Now
                    </button>
                    <div class="popup-window">
                        <div class="popup animate-in">
                            <div>
                                <h4>Prenota presso un medico specialista</h4>
                                <p>Io </p>
                            </div>
                            <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
        </c:forEach>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>