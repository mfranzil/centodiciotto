$("document").ready(function () {
    $('#new-password, #new-password-confirm').on('keyup', function () {
        let message = $('#password-change-button');

        if ($('#new-password').val().length > 64 || $('#new-password-confirm').val().length > 64) {
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
});