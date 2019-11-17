<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/vendor/select2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2-bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.pract {
                width: 40%;
            }

            .table-cell.drug {
                width: 20%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.action {
                width: 20%;
            }
        }
    </style>
    <script>
        $("document").ready(function () {
            const url = window.href;
            let tableHeaders = [
                {field: "pract", type: "string", text: "Practitioner"},
                {field: "drug", type: "string", text: "Drug"},
                {field: "date", type: "string", text: "Date"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#patient-info,#main-loading-container").hide();

            $("#patient-search")
                .select2({
                    placeholder: "Select a patient",
                    allowClear: true,
                    closeOnSelect: true,
                    minimumInputSize: 6,
                    ajax: {
                        type: "POST",
                        data: function (params) {
                            return {
                                term: params.term,
                                requestType: 'patientSearch'
                            }
                        },
                        url: url,
                        dataType: "json",
                    }
                })
                .val("")
                .trigger("change")
                .on('select2:select', function (e) {
                    $("#main-loading-container").slideDown();
                    $("#main-table").children().not('first').remove();
                    $("#patient-name").html(e.params.data.fullName);
                    $("#patient-ssn").html(e.params.data.SSN);
                    $("#patient-avatar").prop("src", getContextPath() + e.params.data.photoPath);
                    $("#patient-info").slideDown();
                    renderPrescriptions(e.params.data.patientID);
                })
                .on('select2:unselect', function (e) {
                    $("#main-loading-container").slideUp();
                    $("#patient-info").slideUp();
                    $("#main-table").children().not('first').remove();
                    renderPrescriptions();
                });

            function renderPrescriptions(patientID) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "prescriptions",
                        patientID: patientID
                    },
                    url: url,
                    success: function (json) {
                        $("#main-table").createTableHeaders(tableHeaders);
                        $("#main-table").insertRows(tableHeaders, json, url);
                        enablePopup();
                        $("#main-loading-container").slideUp();

                        if (action === "qr") {
                            $("#btn-${requestScope.prescription.ID}").click();
                        }
                    }
                });
            }

            $(document).ajaxSuccess(function () {
                activateForm();
            });

            function activateForm() {
                $(".serve-prescription").submit(function (e) {
                    e.preventDefault();

                    $('#submit-serve').prop('disabled', true);

                    let form = $(this);
                    let url = form.attr('action');

                    $.ajax({
                        type: "POST",
                        url: url,
                        cache: false,
                        data: form.serialize(),
                        success: function (data) {
                            $(".submit-serve").css("background", "rgba(0, 55, 0, 0.8)").html("Submitted");
                            data = JSON.parse(data);

                            setTimeout(function () {
                                $(".popup-window").hide();
                                $("#main-loading-container").slideDown();
                                $("#main-table").children().not('first').remove();
                            }, 750);

                            setTimeout(function () {
                                renderPrescriptions(data.patientID);
                            }, 1500);
                        },
                        error: function (data) {
                            alert("Error. Prescription already served.");
                            $(".popup-window").hide();
                            $("#main-loading-container").slideDown();
                            $("#main-table").children().not('first').remove();
                            renderPrescriptions();
                        }
                    });
                });
            }

            let action = "${requestScope.action}";

            if (action === "qr") {
                $("#main-loading-container").slideDown();
                $("#main-table").children().not('first').remove();
                $("#patient-name").html("${requestScope.patient}");
                $("#patient-ssn").html("${requestScope.patient.SSN}");
                $("#patient-avatar").prop("src", getContextPath() + "${requestScope.patientPhoto}");
                $("#patient-info").slideDown();
                renderPrescriptions("${requestScope.patient.ID}");
            }
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Prescriptions</h1>
        <p class="lead mt-4 mx-4">
            To check all the available prescriptions, search a patient using his SSN, then choose a prescription.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="form-label-group my-4 mx-4 ls-search">
                    <select id="patient-search" name="patientSearch" class="select2-allow-clear form-control"
                            autofocus>
                    </select>
                </div>
                <div class="patient-info" id="patient-info" style="text-align: center">
                    <img id="patient-avatar" class="avatar-medium" src="" alt="">
                    <div id="patient-name" class="mt-2"></div>
                    <div id="patient-ssn" class="mb-2"></div>
                </div>
                <div class="justify-content-center loading mt-2" id="main-loading-container"
                     style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading.."/>
                </div>
                <div id="main-table"></div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>