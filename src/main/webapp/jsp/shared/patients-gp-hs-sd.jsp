<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            $(function () {
                $("#patient-search").select2({
                    placeholder: "Select a patient",
                    allowClear: true,
                    closeOnSelect: true,
                    ajax: {
                        type: "POST",
                        data: function (params) {
                            return {
                                term: params.term,
                                request_type: 'patient_search'
                            }
                        },
                        url: getContextPath() + "/restricted/general_practitioner/patients",
                        dataType: "json",
                    }
                }).val(null).trigger("change");

                $('#patient-search').on('select2:select', function (e) {
                    $("#test-table").children().not('first').remove();
                    renderPatientsRows(e.params.data.patientID);
                });

                $('#patient-search').on('select2:unselect', function (e) {
                    $("#test-table").children().not('first').remove();
                    renderPatientsRows();
                });
            });

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "ssn", type: "string", text: "SSN"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#test-table").createTableHeaders(tableHeaders);
            renderPatientsRows();

            function renderPatientsRows(patientID) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        request_type: "patient_list",
                        patientID: patientID
                    },
                    url: getContextPath() + "/restricted/general_practitioner/patients",
                    success: function (json) {
                        console.log(json);
                        $("#test-table").insertRows(tableHeaders, json);
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
        <h1>My Patients</h1> <!-- TODO cambiare titolo a seconda della provenienza -->
        <p class="lead mt-4 mx-4">
            Click on a patient to get more information, including past visits, exams and prescriptions.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <!-- TODO SIMONE BARRA DI RICERCA: tutti i pazienti di un medico -->
                <div class="form-label-group my-4 mx-4 ls-search">
                    <select id="patient-search" name="patientSearch" class="select2-allow-clear form-control mr-1"
                            style="margin: 1em" autofocus>
                    </select>
                </div>
                <div id="test-table"></div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>