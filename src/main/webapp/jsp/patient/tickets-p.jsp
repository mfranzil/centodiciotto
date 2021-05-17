<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tickets - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/vendor/select2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2-bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.action > button {
                margin: .5em;
            }

            /* Exams */
            .table-cell.doctor {
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

            /* Prescriptions */
            .table-cell.chemist {
                width: 25%;
            }

            .table-cell.drug {
                width: 20%;
            }

            .table-cell.prescription {
                width: 15%;
            }

            .table-cell.sale {
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
        $("document").ready(() => {
            const url = window.location.href;

            let examTableHeaders = [
                {field: "doctor", type: "string", text: "Dispatcher"},
                {field: "exam", type: "string", text: "Exam"},
                {field: "date", type: "string", text: "Date"},
                {field: "amount", type: "string", text: "Amount"},
                {field: "action", type: "button", text: "Ticket"}
            ];

            let prescriptionTableHeaders = [
                {field: "chemist", type: "string", text: "Chemist"},
                {field: "drug", type: "string", text: "Drug"},
                {field: "prescription", type: "string", text: "Prescription date"},
                {field: "sale", type: "string", text: "Sale date"},
                {field: "amount", type: "string", text: "Amount"},
                {field: "action", type: "button", text: "Ticket"}
            ];

            $("#exam-table").createTableHeaders(examTableHeaders);
            $("#prescription-table").createTableHeaders(prescriptionTableHeaders);
            renderAllRows();

            function renderAllRows() {
                $("#exam-loading-container,#prescription-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "examTicketList"
                    },
                    url: url,
                    success: function (data, textStatus, jqXHR) {
                        let json = jqXHR.responseJSON;
                        $("#exam-table").insertRows(examTableHeaders, json, url);
                        $("#exam-loading-container").slideUp();
                        enableButtonPress();
                    }
                });
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "prescriptionTicketList"
                    },
                    url: url,
                    success: function (data, textStatus, jqXHR) {
                        let json = jqXHR.responseJSON;
                        $("#prescription-table").insertRows(prescriptionTableHeaders, json, url);
                        $("#prescription-loading-container").slideUp();
                        enableButtonPress();
                    }
                });
            }

            function enableButtonPress() {
                $(".btn").removeClass("popup-opener").click(function () {
                    let ID = $(this).attr('id').replace("btn-", "");
                    let button = $(this);

                    if (ID.includes("e")) {
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            data: {
                                requestType: "ticketPay",
                                type: "exam",
                                ID: ID.replace("e", "")
                            },
                            url: url,
                            success: () => {
                                button.prop("disabled", true).html("Paid");
                                alert("Ticket successfully paid.");
                            }
                        });
                    } else {
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            data: {
                                requestType: "ticketPay",
                                type: "drug",
                                ID: ID.replace("p", "")
                            },
                            url: url,
                            success: () => {
                                button.prop("disabled", true).html("Paid");
                                alert("Ticket successfully paid.");
                            }
                        });
                    }
                })
            }
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
<div class="container" id="exams">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div id="exam-table"></div>
                <div class="justify-content-center loading" id="exam-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                </div>
            </div>
        </div>
    </div>
</div>
<h3 class="my-4">Drug prescriptions</h3>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div id="prescription-table"></div>
                <div class="justify-content-center loading" id="prescription-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>