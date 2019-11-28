<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Unhappy with your practitioner? - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.name {
                width: 40%;
            }

            .table-cell.city {
                width: 25%;
            }

            .table-cell.province {
                width: 15%;
            }

            .table-cell.action {
                width: 20%;
            }
        }
    </style>
    <script>
        $("document").ready(() => {
            const url = window.location.href;
            $("#table-select div").click(() => {
                $(this).find("input[type=radio]").prop("checked", true);
                $("#submit").removeAttr("disabled");
            });

            $("#practitioner").submit(e => {
                e.preventDefault();
                $("#submit").prop("disabled", true).html("Requesting change...");

                let form = $(this);
                let pract = $(".practitioner-id:checked");
                let data = form.serialize();

                $("input").prop("disabled", true);

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: data,
                    success: () => {
                        $("#current-practitioner").removeClass("chosen-practitioner");
                        $("#check").html("");
                        pract.parent().html("✔").parent().addClass("chosen-practitioner");
                        $("#title").html("Your practitioner change request has been receieved. " +
                            "You will receive a confirmation email soon.");
                        $("#message,#subtitle").slideUp();
                        $("#submit").html("Practitioner changed.")
                    }
                });
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron mt-4">
    <h1>Unhappy with your practitioner?</h1>
    <p class="lead mt-4 mx-4" id="title">
        No worries. You can change it, as many times as you want, as long as it's employed in the same province.
    <p class="lead mx-4" id="subtitle">
        You can find your current practitioner first in the list, followed by all the available ones listed in
        alphabetical order.
    <p class="lead mx-4" id="message">
        To choose a practitioner, select the corresponding name and then confirm your changes clicking
        on the "I want to change my practitioner" button.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <jsp:useBean id="patientDAO" class="it.unitn.web.centodiciotto.beans.entities.PatientDAOBean"/>
                <jsp:setProperty name="patientDAO" property="patientID" value="${sessionScope.user.ID}"/>
                <jsp:setProperty name="patientDAO" property="init" value=""/>
                <c:set var="practitioner" value="${patientDAO.practitioner}"/>

                <div id="table-select">
                    <div class="table-personal table-header">
                        <div class="table-cell name">Name</div>
                        <div class="table-cell city">City</div>
                        <div class="table-cell province">Province</div>
                        <div class="table-cell action">&nbsp;</div>
                    </div>
                    <div id="current-practitioner" class="table-personal chosen-practitioner">
                        <div class="table-cell name">${practitioner}</div>
                        <div class="table-cell city">${practitioner.workingPlace}</div>
                        <div class="table-cell province">${practitioner.workingProvince}</div>
                        <div id="check" class="table-cell action">✔</div>
                    </div>
                    <hr>
                    <form id="practitioner" method="POST">
                        <c:forEach items="${patientDAO.availablePractitioners}" var="availablePractitioner">
                            <div class="table-personal available">
                                <div class="table-cell name">${availablePractitioner}</div>
                                <div class="table-cell city">${availablePractitioner.workingPlace}</div>
                                <div class="table-cell province">${availablePractitioner.workingProvince}</div>
                                <div class="table-cell action">
                                    <input class="practitioner-id" type="radio" name="practitionerID"
                                           value="${availablePractitioner.ID}">
                                </div>
                            </div>
                            <hr>
                        </c:forEach>
                        <button id="submit" class="btn btn-personal btn-block text-center mt-4"
                                disabled type="submit">
                            I want to change my practitioner
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>