<%@ page import="it.unitn.web.utils.Pair" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<% List<Pair<Prescription, Boolean>> prescriptions = (List<Pair<Prescription, Boolean>>) request.getAttribute("prescriptions"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
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

                <% for (Pair<Prescription, Boolean> pair : prescriptions) {
                    Prescription prescription = pair.getFirst();
                    Boolean available = pair.getSecond();
                %>
                <div class="table-personal">
                    <div class="table-cell doctor"><%=prescription.getPractitionerFirstName()%>&nbsp;<%=prescription.getPractitionerLastName()%>
                    </div>
                    <div class="table-cell date"><%=prescription.getPrescriptionDate()%>
                    </div>
                    <div class="table-cell report-state">
                        <% if (available) {%>
                        Available
                        <% } else { %>
                        Not available <% } %>
                    </div>
                    <div class="table-cell action">
                        <% if (available) {%>
                        <form target="_blank"
                              action="${pageContext.request.contextPath}/restricted/patient/prescriptions" id="pdf"
                              method="POST">
                            <input type="hidden" name="practitioner_id"
                                   value="<%= prescription.getPrescriptionPractitioner() %>"/>
                            <input type="hidden" name="patient_ssn" value="<%= ((Patient) user).getSsn() %>"/>
                            <input type="hidden" name="prescription_date"
                                   value="<%= prescription.getPrescriptionDate() %>"/>
                            <input type="hidden" name="prescription_id"
                                   value="<%= prescription.getPrescriptionID() %>"/>
                            <input type="hidden" name="prescription_description"
                                   value="<%= prescription.getDrugDescription() %>"/>
                            <button type="submit" class="btn btn-block btn-personal">Download</button>
                        </form>
                        <% } else { %>
                        <button type="button" class="btn btn-block btn-personal disabled">Download</button>
                        <% } %>
                    </div>
                </div>
                <hr>
                <% } %>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>