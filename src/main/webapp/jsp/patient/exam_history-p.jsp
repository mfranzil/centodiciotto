<%--suppress ELValidationInJSP --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.exam {
                width: 40%;
            }

            .table-cell.date {
                width: 20%;
            }

            .table-cell.reportstate {
                width: 15%;
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
                {field: "exam", type: "string", text: "Exam"},
                {field: "date", type: "string", text: "Date"},
                {field: "reportstate", type: "bool", text: "Report state"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#main-table").createTableHeaders(tableHeaders);
            renderExamsRows();

            function renderExamsRows() {
                $("#main-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: url,
                    data: {
                        requestType: "historyList"
                    },
                    success: (data, textStatus, jqXHR) => {
                        let json = jqXHR.responseJSON;
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

<div class="jumbotron mt-4">
    <h1>Exam History</h1>
    <p class="lead mt-4 mx-4">
        In this section you can see all the exams you have ever done.
        It will be possible to view the report when available.
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
                         src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>