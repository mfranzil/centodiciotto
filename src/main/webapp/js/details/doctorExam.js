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
            url: getContextPath() + "/restricted/patient/exam_booking",
            dataType: "json",
        },
    }).val(null);

    $(".doctor-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr('action');

        let doctor = form.find(".doctor-search");
        let label = form.find(".doctor-label");

        let d = doctor.select2("data")[0].healthService;
        console.log(d);

        if (doctor.val() == null) {
            label.text('Please select an exam');
        } else {
            label.text('');

            let data = $(this).serializeArray();
            data.push({name: "isHealthService", value: doctor.select2("data")[0].healthService});

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: data,
                success: function () {
                    label.text("Exam booked successfully");
                    setTimeout(() => window.location.reload(), 750);
                },
                error: function () {
                    label.text("Error while booking exam. Patient may already have a pending exam");
                }
            });
        }
    });
});