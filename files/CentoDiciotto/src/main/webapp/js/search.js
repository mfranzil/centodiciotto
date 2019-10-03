$("document").ready(function () {
    $(function () {
        $("#exam-search").select2({
            placeholder: "Choose an exam",
            allowClear: true,
            closeOnSelect: true,
            ajax: {
                // TODO: change to relative path
                url: "http://localhost:8080/CentoDiciotto_war_exploded/restricted/patient/exams",
                dataType: "json"
            }

        });
        $("#exam-search").val(null).trigger("change");
    });
});