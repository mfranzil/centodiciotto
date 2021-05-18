<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        $("document").ready(() => {
            const url = window.location.href;
            const SET_LIMIT = 20;

            let limit = SET_LIMIT;
            let offset = 0;
            let order = "asc";
            let currentRequest = undefined;

            $("#patient-search")
                .select2({
                    placeholder: "Select a patient",
                    allowClear: true,
                    closeOnSelect: true,
                    minimumInputLength: 5,
                    ajax: {
                        type: "POST",
                        data: params => ({
                            term: params.term,
                            requestType: "patientSearch"
                        }),
                        url: url,
                        dataType: "json",
                    }
                })
                .val(null)
                .trigger("change")
                .on("select2:select", e => {
                    renderPatientsRows(e.params.data.patientID);
                })
                .on("select2:unselect", () => {
                    limit = SET_LIMIT;
                    offset = 0;
                    renderPatientsRows(undefined, limit, offset, order);
                });

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "ssn", type: "string", text: "SSN"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#main-table").createTableHeaders(tableHeaders);

            $(".table-header > .table-cell.name").html(
                'Name&nbsp;<span class="dropdown-toggle" id="alphabetical-order"></span>'
            );

            $("#alphabetical-order").click(function () {
                if (order === "asc") {
                    order = "desc";
                    $(this).attr("aria-expanded", "true");
                    limit = SET_LIMIT;
                    offset = 0;
                    if (typeof currentRequest !== "undefined") {
                        currentRequest.abort();
                    }
                    renderPatientsRows(undefined, limit, offset, order);
                } else {
                    order = "asc";
                    $(this).attr("aria-expanded", "false");
                    limit = SET_LIMIT;
                    offset = 0;
                    if (typeof currentRequest !== "undefined") {
                        currentRequest.abort();
                    }
                    renderPatientsRows(undefined, limit, offset, order);
                }
            });

            renderPatientsRows(undefined, limit, offset, order);

            $(window).scroll(function () {
                if ($(window).scrollTop() === $(document).height() - $(window).height()
                    && typeof currentRequest === "undefined") {
                    if (offset + limit <= ${requestScope.total}) {
                        offset += limit;
                        renderPatientsRows(undefined, limit, offset, order);
                    }
                }
            });

            function renderPatientsRows(patientID, limit, offset, order) {
                $("#main-loading-container").slideDown();
                if (offset === 0 || typeof offset === "undefined") {
                    $("#main-table").children().not(".table-header").remove();
                }

                currentRequest = $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "patientList",
                        patientID: patientID,
                        limit: limit,
                        offset: offset,
                        order: order
                    },
                    url: url,
                    success: (data, textStatus, jqXHR) => {
                        let json = jqXHR.responseJSON;
                        $("#main-table").insertRows(tableHeaders, json, url);
                        $("#main-loading-container").slideUp();
                        enablePopup();
                        currentRequest = undefined;
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
                <div class="justify-content-center loading my-2" id="main-loading-container"
                     style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>