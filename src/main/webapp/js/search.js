$("document").ready(function () {
    $(function () {
        $("#exam-search").select2({
            placeholder: "Choose an exam",
            allowClear: true,
            closeOnSelect: true,
            ajax: {
                // TODO: change to relative path
                url: getContextPath() + "/restricted/patient/exams",
                dataType: "json"
            }

        }).val(null).trigger("change");
    });
});