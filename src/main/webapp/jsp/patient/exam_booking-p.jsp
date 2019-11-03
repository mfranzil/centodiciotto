<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your exam - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/ajax.js"></script>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/css/select2.min.css">
    <style>
        @media (min-width: 992px) {
            .table-cell.exam {
                width: 75%;
            }

            .table-cell.action {
                width: 25%;
            }

        }
    </style>
    <script>
        $("document").ready(function () {
            const url = getContextPath() + "/restricted/patient/exams";
            let onlyAvailable = true;

            $(function () {
                $("#exam-search")
                    .select2({
                        placeholder: "Choose an exam",
                        allowClear: true,
                        closeOnSelect: true,
                        ajax: {
                            type: "POST",
                            data: function (params) {
                                return {
                                    term: params.term,
                                    requestType: 'examSearch'
                                }
                            },
                            url: url,
                            dataType: "json",
                        }
                    })
                    .val(null)
                    .trigger("change")
                    .on('select2:select', function (e) {
                        $("#main-table").children().not('first').remove();
                        renderExamsRows(e.params.data.id);
                    })
                    .on('select2:unselect', function (e) {
                        $("#main-table").children().not('first').remove();
                        renderExamsRows();
                    });
            });

            let tableHeaders = [
                {field: "exam", type: "string", text: "Exam"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#main-table").createTableHeaders(tableHeaders);
            renderExamsRows();
            $("#main-loading-container").slideUp();

            function renderExamsRows(examID) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "examList",
                        examID: examID,
                        onlyAvailable: onlyAvailable
                    },
                    url: url,
                    success: function (json) {
                        $("#main-table").insertRows(tableHeaders, json, url);
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
    <h1>Book Your Exam</h1>
    <p class="lead mt-4 mx-4">
        You can search for the exam you need via the appropriate search menu.
        The exam date will be established by the specialist doctor.
    </p>
</div>

<div class="container">
    <div class="form-group" style="display: flex; width: 100%; margin: auto">
        <select id="exam-search" name="examSearch" class="select2-allow-clear form-control mr-1"
                style="margin: 1em" autofocus>
        </select>
        <button id="my_filter" class="btn btn-personal ml-1" type="button">
            Available Exams
        </button>
    </div>
    <div class="justify-content-center loading" id="main-loading-container" style="text-align: center;">
        <img class="rotating" role="status" style="width: 64px"
             src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading.."/>
    </div>
    <div id="main-table">
        <!--
        <div class="popup-window">
                        <div class="popup animate-in">
                            <div>
                                <h4>Prenota presso un medico specialista</h4>
                                <p>Io </p>
                            </div>
                            <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
             !-->
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>