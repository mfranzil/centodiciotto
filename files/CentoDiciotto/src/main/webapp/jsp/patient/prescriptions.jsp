<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
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
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Doctor</th>
            <th scope="col">Date</th>
            <th scope="col">State</th>
            <th scope="col">Prescription</th>
        </tr>
        </thead>
        <tbody>
        <% List<Prescription> prescriptions = (List<Prescription>) request.getAttribute("prescriptions"); %>
        <% for (Prescription prescription : prescriptions) {%>
        <tr>
            <th scope="row"><%=prescription.getPractitionerFirstName()%> <%=prescription.getPractitionerLastName()%></th>
            <td><%=prescription.getPrescriptionDate()%></td>
            <td><%  Calendar now = Calendar.getInstance();

                    Calendar prescriptionDate = Calendar.getInstance();
                    prescriptionDate.setTime(prescription.getPrescriptionDate());
                    prescriptionDate.add(Calendar.MONTH, 1);

                    if(prescriptionDate.getTime().after(now.getTime())){%>
                Available
            <td>
            <form target="_blank" action="${pageContext.request.contextPath}/restricted/patient/prescriptions" id="pdf" method="POST">
                <input type="hidden" name="practitioner_id" value="<%= prescription.getPrescriptionPractitioner() %>" />
                <input type="hidden" name="patient_ssn" value="<%= ((Patient) user).getSsn() %>" />
                <input type="hidden" name="prescription_date" value="<%= prescription.getPrescriptionDate() %>" />
                <input type="hidden" name="prescription_id" value="<%= prescription.getPrescriptionID() %>" />
                <input type="hidden" name="prescription_description" value="<%= prescription.getDrugDescription() %>" />
                <button type="submit" class="btn btn-block btn-personal">Download</button>
            </form>
            </td>
                <% } else { %>
            Not Available
            <td>
                <button type="button" class="btn btn-block btn-personal disabled">Download</button>
            </td>
                <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>