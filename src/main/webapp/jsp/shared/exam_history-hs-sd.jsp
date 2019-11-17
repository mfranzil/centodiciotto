<%--suppress ELValidationInJSP --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Exam history - CentoDiciotto</title>
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

            .table-cell.exam {
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
            const url = window.href;

            let tableHeaders = [
                {field: "avt", type: "photo", text: "&nbsp;"},
                {field: "name", type: "string", text: "Name"},
                {field: "exam", type: "string", text: "Exam"},
                {field: "date", type: "string", text: "Date"},
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
                        requestType: "examList",
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

            $(document).ajaxSuccess(function () {
                activateForm();
            });

            function activateForm() {
                $(".submit-result").submit(function (e) {
                    e.preventDefault();

                    let form = $(this);
                    let button = form.find("button.submit-button");

                    button.prop("disabled", true).html("Sending..");

                    $.ajax({
                        type: "POST",
                        url: url,
                        cache: false,
                        data: form.serialize(),
                        success: function (data) {
                            button.html("Result updated");
                            setTimeout(function () {
                                button.prop("disabled", false).html("Submit result");
                            }, 2000);
                        }
                    });
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
        In this section you can see all the exams already done.
        You can add or modify each exam's result.
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