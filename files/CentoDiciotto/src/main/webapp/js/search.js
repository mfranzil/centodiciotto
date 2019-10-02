$("document").ready(function () {
    $(function () {
        let data = [
            {
                id: 1,
                text: 'bug'
            },
            {
                id: 2,
                text: 'duplicate'
            },
            {
                id: 3,
                text: 'invalid'
            },
            {
                id: 4,
                text: 'wontfix'
            }
        ];

        $("#autocomplete-1").select2({
            placeholder: "Choose a language",
            allowClear: true,
            data: data
        });
        $("#autocomplete-1").val(null).trigger("change");


        $("#autocomplete-2").select2({
            placeholder: "Choose a language",
            allowClear: true,
            closeOnSelect: true,
            ajax: {
                url: "http://localhost:8080/CentoDiciotto_war_exploded/restricted/patient/exams",
                dataType: "json"
            }
        });
        $("#autocomplete-2").val(null).trigger("change");
    });
});