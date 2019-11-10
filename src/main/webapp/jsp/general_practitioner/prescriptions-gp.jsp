<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/css/select2.min.css">
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.name {
                width: 35%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.action {
                width: 25%;
                padding-right: 2%;
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
            const url = getContextPath() + "/restricted/general_practitioner/prescriptions";

            $("#patient-search")
                .select2({
                    placeholder: "Select a patient",
                    allowClear: true,
                    closeOnSelect: true,
                    ajax: {
                        type: "POST",
                        data: function (params) {
                            return {
                                term: params.term,
                                requestType: 'patientSearch'
                            }
                        },
                        url: getContextPath() + "/restricted/general_practitioner/patients",
                        dataType: "json",
                    }
                })
                .val(null)
                .trigger("change")
                .on('select2:select', function (e) {
                    $("#patient_table").children().not('first').remove();
                    renderPatientsRows(e.params.data.patientID);
                })
                .on('select2:unselect', function (e) {
                    $("#patient_table").children().not('first').remove();
                    renderPatientsRows();
                });

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "ssn", type: "string", text: "SSN"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#patient_table").createTableHeaders(tableHeaders);
            renderPatientsRows();

            //$("#main-loading-container").slideUp();

            function renderPatientsRows(patientID) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "patientList",
                        patientID: patientID
                    },
                    url: url,
                    success: function (json) {
                        console.log(json);
                        $("#patient_table").insertRows(tableHeaders, json, url);
                        enablePopup();
                    }
                });
            }
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Prescription</h1>
        <p class="lead mt-4 mx-4">
            For each patient, you can assign exams and drugs.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <form action="search_patient" method="POST">
                    <!--TODO SIMONE BARRA DI RICERCA: tutti i pazienti di un medico -->
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <select id="patient-search" name="patientSearch" class="select2-allow-clear form-control"
                                autofocus>
                        </select>
                    </div>
                </form>
                <div id="patient_table">
                    <div class="table-personal" id="table-select">
                        <!--
                        <div class="table-cell avt">
                            <img class="avatar-small"
                                 src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                 alt="">
                        </div>
                        <div class="table-cell name">Matteo Franzil</div>
                        <div class="table-cell ssn">FRNMTT98E20I452H</div>
                        <div class="table-cell action">
                            <button class="btn btn-block btn-personal popup-opener">
                                Exam prescription
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">
                                    <form action="" id="form1" method="POST">
                                        <div>
                                            <h4>Choose a prescription...</h4>
                                        </div>
                                    </form>
                                    <button class="btn btn-lg btn-block btn-personal" type="submit">
                                        Confirm
                                    </button>
                                    <button class="btn btn-lg btn-block popup-closer btn-secondary" type="button">
                                        Cancel
                                    </button>
                                </div>
                            </div>
                            <button class="btn btn-block btn-personal popup-opener">
                                Drug prescription
                            </button>
                            <div class="popup-window">
                                <div class="popup animate-in">...</div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    !-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>