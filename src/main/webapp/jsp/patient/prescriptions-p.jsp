<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Prescriptions - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.pract {
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
    <h1>Prescriptions</h1>
    <p class="lead mt-4 mx-4">
        In this section you can download the prescriptions not yet provided.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <jsp:useBean id="drugPrescriptionDAO"
                             class="it.unitn.web.centodiciotto.beans.DrugPrescriptionDAOBean">
                    <jsp:setProperty name="drugPrescriptionDAO" property="patientID"
                                     value="${sessionScope.user.ID}"/>
                    <jsp:setProperty name="drugPrescriptionDAO" property="DAOFactory" value=""/>
                </jsp:useBean>
                <div class="table-personal table-header">
                    <div class="table-cell pract">Practitioner</div>
                    <div class="table-cell date">Date</div>
                    <div class="table-cell report-state">Availability</div>
                    <div class="table-cell action">Prescription</div>
                </div>
                <c:forEach items="${drugPrescriptionDAO.byPatient}" var="prescription">

                    <jsp:useBean id="generalPractitionerDAO"
                                 class="it.unitn.web.centodiciotto.beans.GeneralPractitionerDAOBean"/>
                    <jsp:setProperty name="generalPractitionerDAO" property="practitionerID"
                                     value="${prescription.practitionerID}"/>
                    <jsp:setProperty name="generalPractitionerDAO" property="DAOFactory" value=""/>

                    <jsp:useBean id="datePrescribed" class="java.util.Date"/>
                    <jsp:setProperty name="datePrescribed" property="time"
                                     value="${prescription.datePrescribed.time}"/>

                    <c:set var="practitioner" value="${generalPractitionerDAO.generalPractitioner}"/>
                    <c:set var="available" value="${empty prescription.dateSold or empty prescription.chemistID}"/>
                    <div class="table-personal">
                        <div class="table-cell pract">${practitioner.firstName}&nbsp;${practitioner.lastName}
                        </div>
                        <div class="table-cell date">
                            <fmt:formatDate type="date" dateStyle="long" value="${datePrescribed}"/>
                            <fmt:formatDate pattern="HH:mm" value="${datePrescribed}"/>
                        </div>
                        <div class="table-cell report-state">${available ? "Available" : "Not available"}</div>
                        <div class="table-cell action">
                            <c:if test="${available}">
                                <form action="${pageContext.request.contextPath}/restricted/patient/prescriptions"
                                      id="pdf" target="_blank" method="POST">
                                    <input type="hidden" name="patientID"
                                           value="${prescription.patientID}"/>
                                    <input type="hidden" name="practitionerID"
                                           value="${prescription.practitionerID}"/>
                                    <input type="hidden" name="prescriptionID"
                                           value="${prescription.ID}"/>
                                    <button type="submit" class="btn btn-block btn-personal">Download</button>
                                </form>
                            </c:if>
                            <c:if test="${!available}">
                                <button type="button" class="btn btn-block btn-personal disabled">Download</button>
                            </c:if>
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