<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Prescriptions - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.doctor {
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
                <div class="table-personal table-header">
                    <div class="table-cell doctor">Doctor</div>
                    <div class="table-cell date">Date</div>
                    <div class="table-cell report-state">Report State</div>
                    <div class="table-cell action">Report</div>
                </div>

                <c:forEach items="${requestScope.prescriptions}" var="pair">
                    <c:set var="prescription" value="${pair.first}"/>
                    <c:set var="available" value="${pair.second}"/>
                    <div class="table-personal">
                        <div class="table-cell doctor">{prescription.firstName}&nbsp;{prescription.lastName}
                        </div>
                        <div class="table-cell date">${prescription.date}
                        </div>
                        <div class="table-cell report-state">${available ? "Available" : "Not available"}</div>
                        <div class="table-cell action">
                            <c:if test="${available}">
                                <form target="_blank"
                                      action="${pageContext.request.contextPath}/restricted/patient/prescriptions"
                                      id="pdf"
                                      method="POST">
                                    <input type="hidden" name="practitioner_id"
                                           value="${prescription.practitioner}"/>
                                    <input type="hidden" name="patient_ssn" value="${sessionScope.user.ssn}"/>
                                    <input type="hidden" name="prescription_date"
                                           value="${prescription.date}"/>
                                    <input type="hidden" name="prescription_id"
                                           value="${prescription.ID}"/>
                                    <input type="hidden" name="prescription_description"
                                           value="${prescription.description}"/>
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