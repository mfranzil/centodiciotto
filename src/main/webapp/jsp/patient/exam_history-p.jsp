<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.exam {
                width: 40%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.report-state {
                width: 15%;
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
    <h1>Exam History</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the exams you have ever done.
        It will be possible to view the report when available.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell exam">Exam</div>
                    <div class="table-cell date">Date</div>
                    <div class="table-cell report-state">Report State</div>
                    <div class="table-cell action">Report</div>
                </div>
                <c:forEach items="${requestScope.exams}" var="pair">
                    <c:set var="exam" value="${pair.first}"/>
                    <c:set var="description" value="${pair.second}"/>

                    <jsp:useBean id="date" class="java.util.Date"/>
                    <jsp:setProperty name="date" property="time"
                                     value="${exam.date.time}"/>
                    <div class="table-personal">
                        <div class="table-cell exam">${description}</div>
                        <div class="table-cell date">
                            <fmt:formatDate type="date" dateStyle="long" value="${date}"/>
                            <fmt:formatDate pattern="HH:mm" value="${date}"/>
                        </div>
                        <div class="table-cell report-state">${exam.done ? "Available" : "Not available"}</div>
                        <div class="table-cell action">
                            <button type="button" ${exam.done ? "" : "disabled"}
                                    class="btn btn-block btn-personal popup-opener">
                                See Report
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <div>
                                        <h4>Report</h4>
                                        <br>
                                        <p>${exam.result}</p>
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
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>