<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Recalls - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/vendor/select2.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/select2-bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/table.js"></script>
    <style>
        @media (min-width: 992px) {
            .table-cell.exam {
                width: 40%;
            }

            .table-cell.date {
                width: 25%;
            }

            .table-cell.age {
                width: 15%;
            }

            .table-cell.action {
                width: 20%;
            }

        }
    </style>
    <script>
        $("document").ready(() => {
            const url = window.location.href;
            $("#main-table,#main-loading-container,#history-loading-container,#send-recall-div").hide();

            let tableHeaders = [
                {field: "exam", type: "string", text: "Exam"},
                {field: "date", type: "string", text: "Recall date"},
                {field: "age", type: "string", text: "Recall age"},
            ];

            $("#history-table").createTableHeaders(tableHeaders);
            renderHistory();

            $("#new-recall").click(() => $("#send-recall-div").slideDown());

            $("#exam-search")
                .select2({
                    placeholder: "Choose an exam",
                    allowClear: true,
                    closeOnSelect: true,
                    minimumInputLength: 3,
                    ajax: {
                        type: "POST",
                        data: params => ({
                            term: params.term,
                            requestType: "examSearch"
                        }),
                        url: url,
                        dataType: "json",
                    }
                })
                .val(null)
                .trigger("change")
                .on("select2:select", e => {
                    renderExam(e.params.data.id);
                })
                .on("select2:unselect", () => {
                    renderExam();
                    $("#main-table").slideUp();
                });

            $("#send-recall").submit(function (e) {
                e.preventDefault();

                let maxAge = parseInt($("#max-age").val());
                let minAge = parseInt($("#min.age").val());

                if ($("#max-age").val() === "" || $("#min-age").val() === "" ||
                    typeof maxAge !== "number" || typeof minAge !== "number" ||
                    minAge < 0 || maxAge > 130 || minAge >= maxAge) {
                    $("#max-age,#min-age").css("background", "rgba(255, 0, 0, 0.2)").css("outline", "none");

                    setTimeout(() => {
                        $("#max-age,#min-age").css("background", "").css("outline", "");
                    }, 2000);

                    return;
                }

                let form = $(this);
                let data = form.serialize();

                $("#main-loading-container").slideDown();
                $("#submit-recall").prop("disabled", true);
                $("#main-table").slideUp();
                $("#min-age,#max-age").prop("disabled", true);

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: data,
                    success: () => {
                        $("#submit-recall").html("Recall inviato con successo.");
                        setTimeout(() => {
                            renderExam();
                            renderHistory();
                        }, 2000);
                    },
                    error: () => {
                        location.reload();
                    }
                });
            });

            function renderExam(examID) {
                $("main-loading-container").slideDown();
                $("#main-table").slideDown();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "examRow",
                        examID: examID,
                    },
                    url: url,
                    success: (data, textStatus, jqXHR) => {
                        let json = jqXHR.responseJSON;
                        if (!examID) {
                            $("#exam-id").val("");
                            $("#main-table,#main-loading-container,#send-recall-div").slideUp();
                        } else {
                            $(".table-cell.content.exam").html(json[0].exam);
                            $(".table-cell.content.date").html(json[0].date);
                            $(".table-cell.content.age").html(json[0].age);
                            $("#exam-id").val(examID);
                            $("main-loading-container,#send-recall-div").slideUp();
                        }
                    }
                });
            }

            function renderHistory() {
                $("#history-loading-container").slideDown();
                $("#history-table").children().not(".table-header").remove();

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data: {
                        requestType: "recallHistory",
                    },
                    url: url,
                    success: (data, textStatus, jqXHR) => {
                        let json = jqXHR.responseJSON;
                        $("#history-table").insertRows(tableHeaders, json, url);
                        $("#history-loading-container").slideUp();
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
        <h1>Recalls</h1>
        <p class="lead mt-4 mx-4">
            To make a recall select the exam, and confirm it.
        </p>
    </div>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="form-group" style="display: flex; width: 100%; margin: auto">
                    <select id="exam-search" name="examSearch" class="select2-allow-clear form-control"
                            style="margin: 1em" autofocus>
                    </select>
                </div>
                <div class="justify-content-center loading mt-2" id="main-loading-container"
                     style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                </div>
                <div id="main-table" class="mt-4">
                    <div class="table-personal table-header">
                        <div class="table-cell exam">Exam</div>
                        <div class="table-cell date">Last recall date</div>
                        <div class="table-cell age">Last recall age</div>
                        <div class="table-cell action">&nbsp;</div>
                    </div>
                    <div class="table-personal">
                        <div class="table-cell content exam"></div>
                        <div class="table-cell content date"></div>
                        <div class="table-cell content age"></div>
                        <div class="table-cell content action">
                            <button type="button" id="new-recall" class="btn btn-block btn-personal">New recall</button>
                        </div>
                    </div>
                    <hr>
                </div>
                <form id="send-recall" method="POST">
                    <div class="form-group mt-3 mx-3" id="send-recall-div"
                         style="display: flex; justify-content: center; flex-wrap: wrap">
                        <div>
                            <label class="mr-2" for="min-age">Minimum age</label>
                            <input class="mr-2" type="text" id="min-age" name="minAge"/>
                        </div>
                        <div>
                            <label class="mr-2" for="max-age">Maximum age</label>
                            <input class="mr-2" type="text" id="max-age" name="maxAge"/>
                        </div>
                        <input class="mr-2" type="hidden" name="requestType" value="newRecall"/>
                        <input class="mr-2" type="hidden" id="exam-id" name="examID" value=""/>
                        <br>
                        <button type="submit" class="btn btn-block btn-personal mt-2"
                                id="submit-recall" style="width: 50%">Start new recall
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="jumbotron mt-4">
        <h1>Recalls History</h1>
        <p class="lead mt-4 mx-4">
            This is the history of all the recalls.
        </p>
    </div>
</div>

<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <div class="justify-content-center loading" id="history-loading-container" style="text-align: center;">
                    <img class="rotating" role="status" style="width: 64px"
                         src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                </div>
                <div id="history-table">
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/jsp/fragments/foot.jsp" %>
</body>