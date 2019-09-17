$("document").ready(function () {
    $("#password-change").submit(function (e) {
        e.preventDefault();
        var form = $(this);
        var url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            data: form.serialize(),
            success: function (data) {
                $('#old-password,#new-password-confirm,#new-password').val("");
                alert("Password cambiata con successo.");
            },
            error: function (data) {
                alert("Errore nell'inserimento della password corrente.");
                $('#old-password').css("background", "rgba(255, 0, 0, 0.2)").css("border-color", "red").val("");
                setTimeout(function () {
                    $('#old-password').css("background", "").css("border-color", "");
                }, 2000);
            }
        });
    });

    $('#avatar-select').on('change', function () {
        const filename = $("#avatar-select").val();
        let extension = filename.replace(/^.*\./, '');

        if (extension === filename) {
            extension = '';
        } else {
            extension = extension.toLowerCase();
        }

        $('#extension').attr('value', extension);
        $(this).next('.custom-file-label').html(filename.replace('C:\\fakepath\\', ""));
    });

    $("#avatar").submit(function (e) {
        e.preventDefault();
        var form = $(this);
        var url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            processData: false,
            contentType: false,
            enctype: 'multipart/form-data',
            data: new FormData(form[0]),
            success: function (data) {
                alert("Profile photo uploaded successfully.");
                location.reload();
            },
            error: function (data) {
                alert("Error in profile photo upload");
            }
        });
    });

});
