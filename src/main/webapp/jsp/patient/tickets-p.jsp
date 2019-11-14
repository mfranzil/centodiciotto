<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tickets - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.action > button {
                margin: .5em;
            }


            /* Esami */
            .table-cell.specialized-doctor {
                width: 25%;
            }

            .table-cell.exam {
                width: 25%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.exam-action {
                width: 20%;
            }

            .table-cell.exam-amount {
                width: 10%;
            }

            /* Farmaci */
            .table-cell.practitioner {
                width: 15%;
            }

            .table-cell.chemist {
                width: 15%;
            }

            .table-cell.drug {
                width: 15%;
            }

            .table-cell.emission-date {
                width: 15%;
            }

            .table-cell.erogation-date {
                width: 15%;
            }

            .table-cell.drug-action {
                width: 15%;
            }

            .table-cell.drug-amount {
                width: 10%;
            }
        }

        @media (max-width: 991.8px) {
            .table-cell.action > button {
                margin-top: .5em;
            }
        }

    </style>
    <script>
        $("document").ready(function () {
            $("form").submit(function (e) {
                e.preventDefault();

                let form = $(this);
                let url = form.attr('action');
                let button = form.find("button");

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: form.serialize(),
                    success: function () {
                        button.prop("disabled", true).html("Paid");
                        alert("Ticket successfully paid.");
                    },
                    error: function () {
                        alert("Error while paying ticket (may already have been paid).");
                    }
                });
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron mt-4">
    <h1>Tickets</h1>
    <p class="lead mt-4 mx-4">
        From this menu you can pay for your tickets.
    </p>
</div>
<h3 class="my-4">Exams</h3>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell specialized-doctor">Doctor</div>
                    <div class="table-cell exam">Exam</div>
                    <div class="table-cell date">Date</div>
                    <div class="table-cell exam-amount">Amount</div>
                    <div class="table-cell exam-action">Ticket</div>
                </div>
                <jsp:useBean id="examDAO" class="it.unitn.web.centodiciotto.beans.ExamDAOBean"/>
                <jsp:setProperty name="examDAO" property="userID" value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="examDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="doctorDAO" class="it.unitn.web.centodiciotto.beans.SpecializedDoctorDAOBean"/>
                <jsp:setProperty name="doctorDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="examDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>

                <c:forEach items="${examDAO.patientsNotPaid}" var="exam">
                    <jsp:setProperty name="examDate" property="date" value="${exam.date.time}"/>
                    <jsp:setProperty name="doctorDAO" property="doctorID" value="${exam.doctorID}"/>

                    <c:set var="doctor" value="${doctorDAO.doctor}"/>
                    <div class="table-personal">
                        <div class="table-cell specialized-doctor">${doctor}</div>
                        <div class="table-cell exam">${exam.type.description}</div>
                        <div class="table-cell date">${examDate.formattedDateTime}</div>
                        <div class="table-cell exam-amount">$${exam.ticket}</div>
                        <div class="table-cell exam-action">
                            <form method="POST" class="pay"
                                  action="${pageContext.request.contextPath}/restricted/patient/tickets">
                                <input type="hidden" value="${exam.ID}" name="ID">
                                <input type="hidden" value="exam" name="type">
                                <button type="submit" id="btn-pay-e-${exam.ID}" class="btn btn-block btn-personal"
                                    ${exam.ticketPaid ? "disabled" : ""}> ${exam.ticketPaid ? "Paid" : "Pay"}
                                </button>
                            </form>
                        </div>
                    </div>
                    <hr>
                </c:forEach>


            </div>
        </div>
    </div>
</div>
<h3 class="my-4">Drug prescriptions</h3>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell practitioner">Doctor</div>
                    <div class="table-cell chemist">Chemist</div>
                    <div class="table-cell drug">Drug</div>
                    <div class="table-cell emission-date">Emission Date</div>
                    <div class="table-cell erogation-date">Erogation Date</div>
                    <div class="table-cell drug-amount">Amount</div>
                    <div class="table-cell drug-action">Ticket</div>
                </div>

                <jsp:useBean id="prescriptionDAO"
                             class="it.unitn.web.centodiciotto.beans.DrugPrescriptionDAOBean"/>
                <jsp:setProperty name="prescriptionDAO" property="patientID"
                                 value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="prescriptionDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="chemistDAO" class="it.unitn.web.centodiciotto.beans.ChemistDAOBean"/>
                <jsp:setProperty name="chemistDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="practitionerDAO"
                             class="it.unitn.web.centodiciotto.beans.GeneralPractitionerDAOBean"/>
                <jsp:setProperty name="practitionerDAO" property="DAOFactory" value=""/>

                <jsp:useBean id="drugEmissionDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>
                <jsp:useBean id="drugSoldDate" class="it.unitn.web.centodiciotto.beans.CustomDTFormatterBean"/>

                <c:forEach items="${prescriptionDAO.patientsNotPaid}" var="drugPrescription">
                    <jsp:setProperty name="practitionerDAO" property="practitionerID"
                                     value="${drugPrescription.practitionerID}"/>
                    <jsp:setProperty name="chemistDAO" property="chemistID" value="${drugPrescription.chemistID}"/>
                    <jsp:setProperty name="drugEmissionDate" property="date"
                                     value="${drugPrescription.datePrescribed.time}"/>
                    <jsp:setProperty name="drugSoldDate" property="date" value="${drugPrescription.dateSold.time}"/>

                    <c:set var="practitioner" value="${practitionerDAO.practitioner}"/>
                    <c:set var="chemist" value="${chemistDAO.chemist}"/>

                    <div class="table-personal">
                        <div class="table-cell practitioner">${practitioner}</div>
                        <div class="table-cell chemist">${chemist.name} </div>
                        <div class="table-cell drug">${drugPrescription.drugType.description} </div>
                        <div class="table-cell emission-date">${drugEmissionDate.formattedDate}</div>
                        <div class="table-cell erogation-date">${drugSoldDate.formattedDate}</div>
                        <div class="table-cell drug-amount">$${drugPrescription.ticket}</div>
                        <div class="table-cell drug-action">
                            <form method="POST" class="pay"
                                  action="${pageContext.request.contextPath}/restricted/patient/tickets">
                                <input type="hidden" value="${drugPrescription.ID}" name="ID">
                                <input type="hidden" value="drug" name="type">
                                <button type="submit" id="btn-pay-e-${drugPrescription.ID}"
                                        class="btn btn-block btn-personal"
                                    ${drugPrescription.ticketPaid ? "disabled" : ""}>
                                        ${drugPrescription.ticketPaid ? "Paid" : "Pay"}
                                </button>
                            </form>
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
























