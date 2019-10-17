<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.name {
                width: 35%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.action {
                width: 25%;
                padding-right: 2%;
            }

            .table-cell.action > button {
                margin: .5em;
            }
        }

        @media (max-width: 991.8px) {
            .table-cell.action > button {
                margin-top: .5em;
            }
        }
    </style>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>My Patients</h1> <!-- TODO cambiare titolo a seconda della provenienza -->
        <p class="lead mt-4 mx-4">
            Click on a patient to get more information, including past visits, exams and prescriptions.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <form action="search_patient" method="POST">
                    <!-- TODO SIMONE BARRA DI RICERCA: tutti i pazienti di un medico -->
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <input class="form-control mx-2" id="query" name="query"
                               placeholder="Search..." required type="text">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>

                <div class="table-personal table-header">
                    <div class="table-cell avt">&nbsp;</div>
                    <div class="table-cell name">Name</div>
                    <div class="table-cell ssn">SSN</div>
                    <div class="table-cell action">&nbsp;</div>
                </div>

                <c:forEach items="${requestScope.list}" var="list_item">
                    <c:set var="patient" value="${list_item[0]}"/>
                    <c:set var="province" value="${list_item[1]}"/>
                    <c:set var="patient_pr" value="${list_item[2]}"/>
                    <c:set var="photo" value="${list_item[3]}"/>
                    <c:set var="visit" value="${list_item[4]}"/>
                    <c:set var="visit_pr" value="${list_item[5]}"/>
                    <c:set var="exams" value="${list_item[6]}"/>

                    <div class="table-personal" id="table-select">
                        <div class="table-cell avt"><img class="avatar-small"
                                                         src="${pageContext.request.contextPath}${photo}"
                                                         alt="Profile photo"></div>
                        <div class="table-cell name">${patient.firstName} ${patient.lastName}</div>
                        <div class="table-cell ssn">${patient.ssn}</div>
                        <div class="table-cell action">
                            <button type="button" class="btn btn-block btn-personal popup-opener">
                                Patient data
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <div>
                                        <h4>Patient data</h4>
                                        <table class="table table-unresponsive">
                                            <tr>
                                                <th>Name</th>
                                                <td>${patient.firstName}</td>
                                            </tr>
                                            <tr>
                                                <th>Surname</th>
                                                <td>${patient.lastName}</td>
                                            </tr>
                                            <tr>
                                                <th>SSN</th>
                                                <td>${patient.ssn}</td>
                                            </tr>
                                            <tr>
                                                <th>Birthdate</th>
                                                <td>${patient.birthDate}</td>
                                            </tr>
                                            <tr>
                                                <th>Gender</th>
                                                <td>${patient.gender}</td>
                                            </tr>
                                            <tr>
                                                <th>Province</th>
                                                <td>${province}</td>
                                            </tr>
                                            <tr>
                                                <th>Practitioner</th>
                                                <td>${patient_pr}</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <c:if test="${!empty visit}">
                                        <div>
                                            <h4>Last visit</h4>
                                            <table class="table table-unresponsive">
                                                <tr>
                                                    <th>Date</th>
                                                    <td>${visit.date}</td>
                                                </tr>
                                                <tr>
                                                    <th>Practitioner</th>
                                                    <td>${visit_pr}</td>
                                                </tr>
                                                <tr>
                                                    <th>Report</th>
                                                    <td>${visit.reportAvailable ? visit.report : " - "}</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </c:if>
                                    <c:if test="${!empty exams}">
                                        <div>
                                            <h4>Last exams</h4>
                                            <table class="table table-unresponsive">
                                                <c:forEach items="${exams}" var="pair">
                                                    <c:set var="exam" value="${pair.first}"/>
                                                    <c:set var="description" value="${pair.second}"/>
                                                    <tr>
                                                        <td>${exam.date}</td>
                                                        <td>${description}</td>
                                                        <td>${exam.result}</td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </c:if>
                                    <div>
                                        <h4>Last prescriptions</h4>
                                        <table class="table table-unresponsive">
                                            <tr>
                                                <td>17/08/2019</td>
                                                <td>Aspirina</td>
                                                <td>Taken (?)</td>
                                            </tr>
                                        </table>
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