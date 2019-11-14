<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Visit history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.name {
                width: 25%;
            }

            .table-cell.ssn {
                width: 20%;
            }

            .table-cell.date {
                width: 25%;
            }

            .table-cell.action {
                width: 20%;
            }
        }
    </style>
    <script>
        $("document").ready(function () {
            const url = getContextPath() + "/restricted/general_practitioner/visit_history";

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "ssn", type: "string", text: "SSN"},
                {field: "date", type: "date", text: "Date"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#history-table").createTableHeaders(tableHeaders);
            renderPatientsRows();

            function renderPatientsRows() {
                $("#main-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "visitList",
                    },
                    url: url,
                    success: function (json) {
                        console.log(json);
                        $("#history-table").insertRows(tableHeaders, json, url);
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

<div class="jumbotron mt-4">
    <h1>Visit History</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the visits already done.
        You can add or modify a report.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div id="history-table"></div>
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