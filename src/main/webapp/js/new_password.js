$("document").ready(function () {
    $('#new-password, #new-password-confirm').on('keyup', function () {
        let message = $('#password-change-button');
        let newPassword = $('#new-password');
        let newPasswordConfirm = $('#new-password-confirm');

        if (newPassword.val().length > 64 || newPasswordConfirm.val().length > 64) {
            message.html("Password is too long!").css('background-color', 'red').prop('disabled', true);
            return;
        }

        if ((newPassword.val() !== newPasswordConfirm.val()) ||
            newPassword.val() === "" || newPasswordConfirm.val() === "") {
            message.html('Passwords do not match.').css('background-color', 'red').prop('disabled', true);
            return;
        }

        message.html('Passwords match!').css('background-color', 'green').removeAttr("disabled");

        setTimeout(function () {
            message.html('Change your password').css('background-color', '');
        }, 2000);
    });
});