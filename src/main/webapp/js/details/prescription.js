/**
 * This JS document is injected by PrescriptionServlet into /restricted/general_practitioner/prescriptions.
 *
 * Its role is to send AJAX POST requests to the servlet, containing exam and drug prescriptions requests.
 */
$("document").ready(() => {
    $(".exam-search").select2({
        placeholder: "Select an exam",
        allowClear: true,
        closeOnSelect: true,
        minimumInputLength: 6,
        ajax: {
            type: "POST",
            data: params => ({
                term: params.term,
                requestType: "examSearch"
            }),
            url: getContextPath() + "restricted/general_practitioner/prescriptions",
            dataType: "json",
        },
    }).val(null);

    $(".drug-search").select2({
        placeholder: "Select a drug",
        allowClear: true,
        closeOnSelect: true,
        minimumInputLength: 6,
        ajax: {
            type: "POST",
            data: params => ({
                term: params.term,
                requestType: "drugSearch"
            }),
            url: getContextPath() + "restricted/general_practitioner/prescriptions",
            dataType: "json",
        },
    }).val(null);

    $(".exam-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = getContextPath() + "restricted/general_practitioner/prescriptions";

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
                success: () => label.text("Exam prescribed successfully.")
            });
        }
    });

    $(".drug-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = getContextPath() + "restricted/general_practitioner/prescriptions";

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
                success: () => label.text("Drug prescribed successfully."),
                error: () => label.text("Error while prescribing drug.")
            });
        }
    });
});