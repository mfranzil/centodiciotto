<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/vendor/select2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2-bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 7%;
            }

            .table-cell.name {
                width: 38%;
            }

            .table-cell.ssn {
                width: 35%;
            }

            .table-cell.action {
                width: 20%;
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
            const url = window.location.href;
            $(function () {
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
                                    requestType: "patientSearch"
                                }
                            },
                            url: url,
                            dataType: "json",
                        }
                    })
                    .val(null)
                    .trigger("change")
                    .on("select2:select", function (e) {
                        $("#main-table").children().not("first").remove();
                        renderPatientsRows(e.params.data.patientID);
                    })
                    .on("select2:unselect", function (e) {
                        $("#main-table").children().not("first").remove();
                        renderPatientsRows();
                    });
            });

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "ssn", type: "string", text: "SSN"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#main-table").createTableHeaders(tableHeaders);
            renderPatientsRows();

            function renderPatientsRows(patientID) {
                $("#main-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "patientList",
                        patientID: patientID
                    },
                    url: url,
                    success: function (json) {
                        $("#main-table").insertRows(tableHeaders, json, url);
                        $("#main-loading-container").slideUp();
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
        <h1>Patients</h1>
        <p class="lead mt-4 mx-4">
            Click on a patient to get more information, including past visits, exams and prescriptions.
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
                <div id="main-table"></div>
                <div class="justify-content-center loading" id="main-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading.."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>