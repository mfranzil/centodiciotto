<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
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
            let tableHeaders = [
                {field: "avt", type : "photo", text: "&nbsp;"},
                {field: "name",  type : "string", text: "Name"},
                {field: "ssn",  type : "string", text: "SSN"},
                {field: "action",  type : "button", text: "&nbsp;"}
            ];

            $.ajax({
                type: "POST",
                dataType: "json",
                url: getContextPath() + "/restricted/general_practitioner/patient_list",
                success: function (json) {
                    console.log(json);
                    $("#test-table").createTableHeaders(tableHeaders).insertRows(tableHeaders, json);
                    enablePopup();
                }
            });
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
                <form action="search_patient" method="POST">
                    <!-- TODO SIMONE BARRA DI RICERCA: tutti i pazienti di un medico -->
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <input class="form-control mx-2" id="query" name="query"
                               placeholder="Search..." required type="text">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
                <div id="test-table"></div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>