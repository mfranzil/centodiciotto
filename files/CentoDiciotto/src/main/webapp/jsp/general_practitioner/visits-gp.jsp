<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visits - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.image {
                width: 10%;
            }

            .table-cell.patient {
                width: 30%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.action {
                width: 30%;
            }
        }
    </style>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Requests for visits</h1>
        <p class="lead mt-4 mx-4">
            For each pending visit, you can pick a date and time and confirm it.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell image">&nbsp;</div>
                    <div class="table-cell patient">Patient</div>
                    <div class="table-cell ssn">SSN</div>
                    <div class="table-cell action">Report</div>
                </div>
                <% List<Patient> patients = (List<Patient>) request.getAttribute("pending_patients");
                    for (Patient patient : patients) {%>
                <div class="table-personal">
                    <!--<div class="table-cell image"><img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                 alt="">
                    </div>!-->
                    <div class="table-cell patient"><%= patient.getFirstName()%> <%= patient.getLastName()%>
                    </div>
                    <div class="table-cell ssn"><%= patient.getSsn()%>
                    </div>
                    <div class="table-cell action">
                            <button class="btn btn-block btn-personal popup-opener">
                                Choose date and time
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    Insert a date and time for the appointment, then confirm.
                                    <input class="form-control my-4" type="datetime-local">
                                    <button class="btn btn-lg btn-block btn-personal" type="submit">
                                        Confirm the appointment</button>
                                    <button class="btn btn-lg btn-block popup-closer btn-secondary" type="button">
                                        Cancel</button>
                                </div>
                            </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>