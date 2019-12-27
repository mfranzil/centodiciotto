/**
 * This JS document is injected by ExamBookingServlet.java into /restricted/patient/exam_booking.
 * It enables a popup that lets the user choose a Specialized Doctor (or the local HS) in order to do an exam.
 */
$("document").ready(() => {
    $(".doctor-search").select2({
        placeholder: "Select a Specialized Doctor",
        allowClear: true,
        closeOnSelect: true,
        minimumInputLength: 5,
        ajax: {
            type: "POST",
            data: function (params) {
                return ({
                    term: params.term,
                    examID: this.parent().find("input[name='examID']").val(),
                    requestType: "doctorSearch"
                });
            },
            url: getContextPath() + "restricted/patient/exam_booking",
            dataType: "json",
        },
    }).val(null);

    $(".doctor-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr("action");

        let doctor = form.find(".doctor-search");
        let label = form.find(".doctor-label");

        if (doctor.val() == null) {
            label.text("Please select an exam");
        } else {
            label.text("");

            let data = $(this).serializeArray();
            data.push(
                {
                    name: "isHealthService",
                    value: doctor.select2("data")[0].healthService
                }
            );

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: data,
                success: () => {
                    label.text("Exam booked successfully.");
                    setTimeout(() => window.location.reload(), 750);
                }
            });
        }
    });
});