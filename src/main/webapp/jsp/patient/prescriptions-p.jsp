<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Prescriptions - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/vendor/select2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2-bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.pract {
                width: 30%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.state {
                width: 25%;
            }

            .table-cell.action {
                width: 25%;
            }
        }
    </style>
    <script>
        $("document").ready(() => {
            const url = window.location.href;

            let tableHeaders = [
                {field: "pract", type: "string", text: "Exam"},
                {field: "date", type: "string", text: "Date"},
                {field: "state", type: "string", text: "State"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#main-table").createTableHeaders(tableHeaders);
            renderPrescriptionRows();

            function renderPrescriptionRows() {
                $("#main-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: url,
                    data: {
                        requestType: "prescriptionList"
                    },
                    success: (data, textStatus, jqXHR) => {
                        let json = jqXHR.responseJSON;
                        $("#main-table").insertRows(tableHeaders, json, url);
                        $("#main-loading-container").slideUp();
                        enableDownload();
                    }
                });
            }

            function enableDownload() {
                $(".popup-window").remove();


                $(".popup-opener").off().click(function aw(e) {
                    e.preventDefault();
                    let label = $(this).html();

                    if (label === "Download") {
                        let form = $('<form />', {
                            action: url,
                            method: "POST",
                            style: "display: none;",
                            target: "_blank",
                            id: "pdf"
                        });
                        $('<input />', {
                            type: 'hidden',
                            name: "prescriptionID",
                            value: $(this).attr("id").split(/btn-([0-9]*)/)[1]
                        }).appendTo(form);
                        $('<input />', {
                            type: 'hidden',
                            name: "requestType",
                            value: "getPrescription"
                        }).appendTo(form);
                        form.appendTo(this).submit();
                    } else if (label === "Pay now") {
                        window.location = getContextPath() + "restricted/patient/tickets";
                    }
                });
            }
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron mt-4">
    <h1>Prescriptions</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all your prescriptions and download currently available ones.
    </p>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div id="main-table">
                </div>
                <div class="justify-content-center loading" id="main-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading..."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>