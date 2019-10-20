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
                <!-- TODO fix here !-->

                <jsp:useBean id="generalPractitionerDAO"
                             class="it.unitn.web.centodiciotto.beans.GeneralPractitionerDAOBean">
                    <jsp:setProperty name="generalPractitionerDAO" property="practitionerID"
                                     value="${sessionScope.user.ID}"/>
                    <jsp:setProperty name="generalPractitionerDAO" property="DAOFactory" value=""/>
                </jsp:useBean>

                <c:forEach items="${generalPractitionerDAO.patientsList}" var="current_patient">
                    <jsp:useBean id="patientDaoBean" class="it.unitn.web.centodiciotto.beans.PatientDAOBean">
                        <jsp:setProperty name="patientDaoBean" property="patientID" value="${current_patient}"/>
                        <jsp:setProperty name="patientDaoBean" property="DAOFactory" value=""/>
                    </jsp:useBean>

                    <div class="table-personal" id="table-select">
                        <div class="table-cell avt"><img class="avatar-small"
                                                         src="${pageContext.request.contextPath}${patientDaoBean.getPhotoPath(current_patient)}"
                                                         alt="Profile photo"></div>
                        <div class="table-cell name">${current_patient.firstName} ${current_patient.lastName}</div>
                        <div class="table-cell ssn">${current_patient.ssn}</div>
                        <div class="table-cell action">
                            <button type="button" class="btn btn-block btn-personal popup-opener">
                                Patient data
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <div>
                                        <h4>Patient data</h4>

                                    </div>
                                    <c:if test="${!empty patientDaoBean.getLastVisit(current_patient)}">
                                        <div>
                                            <h4>Last visit</h4>
                                            <table class="table table-unresponsive">
                                                <tr>
                                                    <th>Date</th>
                                                    <td>${patientDaoBean.getLastVisit(current_patient).date}</td>
                                                </tr>
                                                <tr>
                                                    <th>Practitioner</th>
                                                    <td>${generalPractitionerDAO.getFirstName(generalPractitionerDAO.getGeneralPractitionerByID(patientDaoBean.getLastVisit(current_patient).practitionerID))}
                                                            ${generalPractitionerDAO.getLastName(generalPractitionerDAO.getGeneralPractitionerByID(patientDaoBean.getLastVisit(current_patient).practitionerID))}</td>
                                                </tr>
                                                <tr>
                                                    <th>Report</th>
                                                    <td>${patientDaoBean.getLastVisit(current_patient).reportAvailable ? patientDaoBean.getLastVisit(current_patient).report : " - "}</td>
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