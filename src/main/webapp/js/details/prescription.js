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
                    requestType: 'examSearch'
                }
            },
            url: getContextPath() + "/restricted/general_practitioner/prescriptions",
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
                    requestType: 'drugSearch'
                }
            },
            url: getContextPath() + "/restricted/general_practitioner/prescriptions",
            dataType: "json",
        },
    }).val(null);

    $(".exam-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr('action');

        let exam = form.find(".exam-search");
        let label = form.find(".exam-prescribe-label");

        if (exam.val() == null) {
            label.text('Please select an exam');
        } else {
            label.text('');

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: form.serialize(),
                success: function () {
                    label.text("Exam prescribed successfully")
                },
                error: function () {
                    label.text("Error while prescribing exam")
                }
            });
        }
    });

    $(".drug-form").submit(function (e) {
        e.preventDefault();

        let form = $(this);
        let url = form.attr('action');

        let drug = form.find(".drug-search");
        let label = form.find(".drug-prescribe-label");

        if (drug.val() == null) {
            label.text('Please select an exam');
        } else {
            label.text('');

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                data: form.serialize(),
                success: function () {
                    label.text("Drug prescribed successfully")
                },
                error: function () {
                    label.text("Error while prescribing drug")
                }
            });
        }
    });
    /*
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
                    requestType: 'drugSearch'
                }
            },
            url: getContextPath() + "/restricted/general_practitioner/prescriptions",
            dataType: "json",
        },
    }).val(null);

    $(".prescribe-exam").click(function () {
        let examID = $(".exam-search").val();

        if(examID == null){
            $(".exam-prescribe-label").text('Please select an exam');
        }
        else{
            $(".exam-prescribe-label").text('');
            $.ajax({
                url: getContextPath() + "/restricted/general_practitioner/prescriptions",
                type: "POST",
                data: {
                    examID : $(".exam-search").val(),
                    patientID : $(".patientID").val(),
                    requestType : "addExam"
                },
                success:function(){
                    alert("worked");
                }
            });
        }
    });

    $(".prescribe-drug").click(function () {
        let drugID = $(".drug-search").val();

        if(drugID == null){
            $('.drug-prescribe-label').text('Please select a drug');
        }
        else{
            $(".drug-prescribe-label").text('');
            $.ajax({
                url: getContextPath() + "/restricted/general_practitioner/prescriptions",
                type: "POST",
                data:$('#myForm').serialize(),
                success:function(){
                    alert("worked");
                }
            });
        }
    });
     */
});