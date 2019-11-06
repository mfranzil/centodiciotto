<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tickets - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            .table-cell.specialized-doctor {
                width: 25%;
            }

            .table-cell.exam {
                width: 25%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.action {
                width: 20%;
            }

            .table-cell.amount {
                width: 10%;
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


<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="table-personal table-header">
                    <div class="table-cell specialized-doctor">Doctor</div>
                    <div class="table-cell exam">Exam</div>
                    <div class="table-cell date">Date</div>
                    <div class="table-cell amount">Amount</div>
                    <div class="table-cell action">Ticket</div>
                </div>

                <jsp:useBean id="examDAOBean"
                             class="it.unitn.web.centodiciotto.beans.ExamDAOBean">
                    <jsp:setProperty name="examDAOBean" property="userID"
                                     value="${sessionScope.user.ID}"/>
                    <jsp:setProperty name="examDAOBean" property="DAOFactory" value=""/>
                </jsp:useBean>

                <c:forEach items="${examDAOBean.patientsNotPaid}" var="exam">
                    <jsp:useBean id="specialistDAOBean"
                                 class="it.unitn.web.centodiciotto.beans.SpecializedDoctorDAOBean">
                        <jsp:setProperty name="specialistDAOBean" property="specialistID"
                                         value="${exam.doctorID}"/>
                        <jsp:setProperty name="specialistDAOBean" property="DAOFactory"
                                         value=""/>
                    </jsp:useBean>
                    <c:set var="specialist" value="${specialistDAOBean.specializedDoctorByID}"/>

                    <jsp:useBean id="examDate" class="java.util.Date"/>
                    <jsp:setProperty name="examDate" property="time"
                                     value="${exam.date.time}"/>

                    <div class="table-personal">
                        <div class="table-cell specialized-doctor">${specialist.firstName} ${specialist.lastName}
                        </div>
                        <div class="table-cell exam">${exam.type.description}
                        </div>
                        <div class="table-cell date">
                            <fmt:formatDate type="date" dateStyle="long" value="${examDate}"/>
                        </div>
                        <div class="table-cell amount">$${exam.ticket}
                        </div>
                        <div class="table-cell action">
                            <form method="POST" class="pay"
                                  action="${pageContext.request.contextPath}/restricted/patient/tickets">
                                <input type="hidden" value="${exam.ID}" type="text" name="ID">
                                <input type="hidden" value="exam" type="text" name="type">
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

























