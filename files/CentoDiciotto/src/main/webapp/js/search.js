$("document").ready(function () {
    function getContextPath() {
        return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
    }

    $(function () {
        $("#exam-search").select2({
            placeholder: "Choose an exam",
            allowClear: true,
            closeOnSelect: true,
            ajax: {
                // TODO: change to relative path
                url: getContextPath().toString() + "/restricted/patient/exams",
                dataType: "json"
            }

        });
        $("#exam-search").val(null).trigger("change");
    });
});