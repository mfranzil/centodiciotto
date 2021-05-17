<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam requests - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.avt {
                width: 7%;
            }

            .table-cell.patient {
                width: 43%;
            }

            .table-cell.exam {
                width: 35%;
            }

            .table-cell.action {
                width: 20%;
            }
        }
    </style>
    <script>
        $("document").ready(() => {
            const url = window.location.href;

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "patient", type: "string", text: "Patient"},
                {field: "exam", type: "string", text: "Exam"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#requests-table").createTableHeaders(tableHeaders);
            renderRequestRows();

            function renderRequestRows() {
                $("#main-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "requestList"
                    },
                    url: url,
                    success: (data, textStatus, jqXHR) => {
                        let json = jqXHR.responseJSON;
                        $("#requests-table").insertRows(tableHeaders, json, url);
                        $("#main-loading-container").slideUp();
                        enablePopup();
                    }
                });
            }

            $(".datepicker").datepicker({
                dateFormat: "dd/mm/yy",
                beforeShowDay: $.datepicker.noWeekends,
                defaultDate: +1,
                firstDay: 1,
                minDate: 1,
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
            });

            $("input.timepicker").timepicker({
                timeFormat: "HH:mm",
                interval: 15,
                minTime: "8:30",
                maxTime: "19:00",
                defaultTime: "8:30",
                startTime: "8:30",
                dropdown: true,
                scrollbar: true
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Requests for exams</h1>
        <p class="lead mt-4 mx-4">
            For each pending exam, you can pick a date and time and confirm it.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div id="requests-table">
                </div>
                <div class="justify-content-center loading" id="main-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${initParam['image-server']}/logo_blue.svg" alt="Loading..."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>