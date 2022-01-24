<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reports - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script>
        $("document").ready(() => {
            const url = window.location.href;

            let dots = 0;
            let datepicker = $(".datepicker");

            $("#include,#generate-new,#download,#loading-container").hide();

            datepicker.datepicker({
                dateFormat: "dd/mm/yy",
                maxDate: 0,
                firstDay: 1,
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                onClose: dateText => {
                    if (dateText !== "") {
                        $("#include,#submit").slideDown();
                        $("#choose-date").slideUp();
                    } else {
                        $("#include,#submit").slideUp();
                        $("#choose-date").slideDown();
                    }
                }
            });

            $("#generate").submit(function (e) {
                e.preventDefault();

                if ($("#date").val() === "") {
                    alert("Insert a valid date.");
                    return;
                }

                let form = $(this);
                let data = form.serialize();

                $("#submit").prop("disabled", true).html("Requesting").startEllipsis();
                $("input").prop("disabled", true);
                $("#loading-container").slideDown();

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: data,
                    success: function (data, textStatus, jqXHR) {
                        let json = jqXHR.responseJSON;
                        $("#submit,#loading-container").slideUp();
                        $("#generate-new,#download").slideDown();
                        $(".datepicker").prop("disabled", true);
                        $("#download").click(() => {
                            e.preventDefault();
                            let downloadButton = $("#download");
                            downloadButton.html("Download started").startEllipsis();
                            window.location.href = json.path;
                        });
                    },
                    error: () => restart()
                });
            });

            $("#generate-new").click(() => restart());

            function restart() {
                $("#include,#generate-new,#download,#loading-container").slideUp();
                $("#choose-date").slideDown();
                $("#submit").prop("disabled", false).html("Generate report").stopEllipsis();
                $("#download").prop("disabled", false).html("Download report").stopEllipsis();
                datepicker.val("");
                $("input,.datepicker").prop("disabled", false);
            }
        });
    </script>
    <style>
        .col-md {
            text-align: center;
            margin: auto 10vmin;
        }

        @media (min-width: 992px) {
            .col-md {
                margin: auto 20vmax;
            }

        }
    </style>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Reports</h1>
        <p class="lead mt-4 mx-4">
            To generate a recall, choose a date and what it will appear in it.
        </p>
    </div>
</div>

<div class="container" style="overflow-y: hidden">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <form method="POST" id="generate"
                      target="${pageContext.request.contextPath}/restricted/health_service/reports">
                    <p class="lead" id="choose-date">Choose a date.</p>
                    <input class="form-control datepicker mt-2"
                           type="text" id="date" name="date" autocomplete="off">
                    <div id="include" class="mt-2" style="display: block">
                        <label><input type="checkbox" id="include-visits"
                                      name="includeVisits">
                            Include visits
                        </label><br>
                        <label><input type="checkbox" id="include-doctor-exams"
                                      name="includeDoctorExams">
                            Include exams made by Specialized Doctors
                        </label><br>
                        <label><input type="checkbox" id="include-health-service-exams"
                                      name="includeHealthServiceExams">
                            Include exams made by this Health Service
                        </label><br>
                        <label><input type="checkbox" id="include-recalls"
                                      name="includeRecalls">
                            Include recalls made by this Health Service
                        </label><br>
                        <label><input type="checkbox" id="include-prescriptions"
                                      name="includePrescriptions">
                            Include drug prescriptions
                        </label>
                        <button type="submit" id="submit" class="btn btn-block btn-personal">Generate report</button>
                        <div class="justify-content-center loading mt-2" id="loading-container"
                             style="text-align: center;">
                            <img class="rotating" role="status" style="width: 64px"
                                 src="${applicationScope['imageServer']}/logo_blue.svg" alt="Loading..."/>
                        </div>
                    </div>
                    <button type="button" id="download" class="btn btn-block btn-personal mt-2">
                        Download report
                    </button>
                    <button type="button" id="generate-new" class="btn btn-block btn-personal mt-2">
                        Generate new report
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>