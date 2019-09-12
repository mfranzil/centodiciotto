$("document").ready(function () {
    $("#password-change").submit(function (e) {
        e.preventDefault();
        var form = $(this);
        var url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
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

    $('#new-password, #new-password-confirm').on('keyup', function () {
        let message = $('#password-change-button');

        if ($('#new-password').val().length > 16 || $('#new-password-confirm').val().length > 16) {
            message.html("Password is too long!").css('background-color', 'red').prop('disabled', true);
            return;
        }

        if (($('#new-password').val() !== $('#new-password-confirm').val()) ||
            $('#new-password').val() === "" || $('#new-password-confirm').val() === "") {
            message.html('Passwords do not match.').css('background-color', 'red').prop('disabled', true);
            return;
        }

        message.html('Passwords match!')
            .css('background-color', 'green')
            .removeAttr("disabled");
        setTimeout(function () {
            message.html('Change your password').css('background-color', '');
        }, 2000);
    });

    $('#avatar-select').on('change', function () {
        var fileName = $(this).val();
        $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', ""));
    })
});
