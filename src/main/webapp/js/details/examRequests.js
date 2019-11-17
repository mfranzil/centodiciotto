const url = window.href;

$(".set-exam").submit(function (e) {
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
        success: function (data) {
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

$('input.timepicker').timepicker({
    timeFormat: 'HH:mm',
    interval: 15,
    minTime: '8:30',
    maxTime: '19:00',
    defaultTime: '8:30',
    startTime: '8:30',
    dropdown: true,
    scrollbar: true
});