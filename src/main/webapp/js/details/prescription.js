$("document").ready(function () {
    $(".exam-search").select2({
        placeholder: "Select an exam",
        allowClear: true,
        closeOnSelect: true,
        minimumInputSize: 6,
        ajax: {
            type: "POST",
            data: function (params) {
                return {
                    term: params.term,
                    requestType: "examSearch"
                }
            },
            url: getContextPath() + "restricted/general_practitioner/prescriptions",
            dataType: "json",
        },
    }).val(null);

    $(".drug-search").select2({
        placeholder: "Select a drug",
        allowClear: true,
        closeOnSelect: true,
        minimumInputSize: 6,
        ajax: {
            type: "POST",
            data: function (params) {
                return {
                    term: params.term,
                    requestType: "drugSearch"
                }
            },
            url: getContextPath() + "restricted/general_practitioner/prescriptions",
            dataType: "json",
        },
    }).val(null);

    $(".exam-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr("action");

        let exam = form.find(".exam-search");
        let label = form.find(".exam-prescribe-label");

        if (exam.val() == null) {
            label.text("Please select an exam");
        } else {
            label.text("");

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: form.serialize(),
                success: function () {
                    label.text("Exam prescribed successfully.")
                }
            });
        }
    });

    $(".drug-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr("action");

        let drug = form.find(".drug-search");
        let label = form.find(".drug-prescribe-label");

        if (drug.val() == null) {
            label.text("Please select a drug.");
        } else {
            label.text("");

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: form.serialize(),
                success: function () {
                    label.text("Drug prescribed successfully.");
                },
                error: function () {
                    label.text("Error while prescribing drug.");
                }
            });
        }
    });
});