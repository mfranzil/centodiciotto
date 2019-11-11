$("document").ready(function () {
    $(".doctor-search").select2({
        placeholder: "Select a Specialized Doctor",
        allowClear: true,
        closeOnSelect: true,
        minimumInputSize: 6,
        ajax: {
            type: "POST",
            data: function (params) {
                return {
                    term: params.term,
                    examID: this.parent().find('input[name="examID"]').val(),
                    requestType: 'doctorSearch'
                }
            },
            url: getContextPath() + "/restricted/patient/doctors",
            dataType: "json",
        },
    }).val(null);

    $(".doctor-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr('action');

        let doctor = form.find(".doctor-search");
        let label = form.find(".doctor-label");

        if (doctor.val() == null) {
            label.text('Please select an exam');
        } else {
            label.text('');

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: form.serialize(),
                success: function () {
                    label.text("Exam booked successfully")
                },
                error: function () {
                    label.text("Error while booking exam")
                }
            });
        }
    });
});