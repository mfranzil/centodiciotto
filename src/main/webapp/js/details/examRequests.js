/**
 * This JS document is injected by ExamRequestsServlet into /restricted/role/exam_requests,
 * where role can be health_service or specialized_doctor.
 *
 * It allows a user to choose a date and time for a specific exam in a popup.
 *
 * The third-party libraries "JQuery UI" and "JQuery Timepicker" are required and must be inserted and loaded
 * in the HTML before this JS is injected.
 */
$("document").ready(() => {
    const url = window.location.href;

    $(".set-exam").submit((e) => {
        e.preventDefault();

        let form = $(this);
        let button = form.find("button.submit");

        let data = form.serializeArray();
        data.push({name: "requestType", value: "requestBook"});

        button.prop("disabled", true).html("Confirming..");

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            data: data,
            success: () => {
                button.html("Confirmed");
            }
        });
    });

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