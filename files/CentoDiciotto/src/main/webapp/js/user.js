$("document").ready(function () {
    $('#new-password, #new-password-confirm').on('keyup', function () {
        let message = $('#message');
        if ($('#new-password').val() === $('#new-password-confirm').val()
            && $('#new-password').val() != ""
            && $('#new-password-confirm').val() != "") {
            message.html('Passwords match!')
                .css('background-color', 'green')
                .removeAttr("disabled");
            setTimeout(function () {
                message.html('Change your password').css('background-color', '');
            }, 2000);
        } else {
            message.html('Passwords do not match.')
                .css('background-color', 'red')
                .prop('disabled', true);
        }
    });

    $('#avatar-select').on('change', function () {
        var fileName = $(this).val();
        $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', ""));
    })
});
