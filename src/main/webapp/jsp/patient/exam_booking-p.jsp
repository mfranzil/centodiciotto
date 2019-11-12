<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your exam - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/select2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2-bootstrap.min.css">
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
            let availableExamFilter = true;

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
                        $("#main-table").children().slice(1).remove();
                        renderExamsRows(e.params.data.id);
                    })
                    .on('select2:unselect', function (e) {
                        $("#main-table").children().slice(1).remove();
                        renderExamsRows();
                    });
            });

            let tableHeaders = [
                {field: "exam", type: "string", text: "Exam"},
                {field: "action", type: "button", text: "&nbsp;"}
            ];

            $("#main-table").createTableHeaders(tableHeaders);
            renderExamsRows();

            $(".table-header > .table-cell.action").html("<button id=\"exam-filter\" class=\"btn btn-personal btn-block\"" +
                " type=\"button\" style=\"background-color: rgb(var(--118-darkest))\">Show all exams</button>");

            function renderExamsRows(examID, onlyAvailable = true) {
                $("#main-loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "examType",
                        examID: examID,
                        onlyAvailable: onlyAvailable
                    },
                    url: url,
                    success: function (json) {
                        $("#main-table").insertRows(tableHeaders, json, url);
                        $("#main-loading-container").slideUp();
                        enablePopup();
                    }
                });
            }

            $("#exam-filter").click(() => {
                $("#main-table").children().slice(1).remove();
                renderExamsRows(undefined, !availableExamFilter);
                availableExamFilter = !availableExamFilter;

                if (availableExamFilter) {
                    $("#exam-filter").html("Show all exams");
                } else {
                    $("#exam-filter").html("Show available exams");
                }
            });

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
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="form-group" style="width: 100%; margin: auto">
                    <select id="exam-search" name="examSearch" class="select2-allow-clear form-control mr-1"
                            style="margin: 1em" autofocus>
                    </select>
                </div>
                <div id="main-table" class="mt-2"></div>
                <div class="justify-content-center loading mt-2" id="main-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${pageContext.request.contextPath}/img/logo_blue.svg" alt="Loading.."/>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>