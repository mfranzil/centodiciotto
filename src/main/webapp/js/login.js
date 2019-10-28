$("document").ready(function () {
    $('#user-id-login').val(localStorage.userID);
    $('#password-login').val(localStorage.password);
    $('#remember-me').prop("checked", localStorage.checkBoxValidation);

    $('#loading-container').hide();

    $(".hover-button").click(function () {
        let id = this.id;
        let role = getNameFromID(id);
        $('#form-image').attr('src', getContextPath() + "/img/classes/" + id + ".png");
        $('#form-name').html("Logging in as " + role);
        $('#form-window').show();
        $('#role').val(id);
    });

    $("#login").submit(function (e) {
        e.preventDefault();

        $("#login").slideUp();
        $("#loading-container").slideDown();

        if ($('#remember-me').is(':checked')) {
            localStorage.userID = $('#user-id-login').val();
            localStorage.password = $('#password-login').val();
            localStorage.checkBoxValidation = true;
        } else {
            localStorage.userID = '';
            localStorage.password = '';
            localStorage.checkBoxValidation = false;
        }

        let form = $(this);
        let url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            data: form.serialize(),
            success: function (result) {
                result = JSON.parse(result);
                $("#form-window").fadeOut();
                window.location = result.url;
            },
            error: function (data) {
                alert("Nome utente o password non corretti.");
                $('#user-id-login,#password-login').css("background", "rgba(255, 0, 0, 0.2)")
                    .css("border-color", "red");
                setTimeout(function () {
                    $('#user-id-login,#password-login').css("background", "").css("border-color", "");
                }, 2000);
                $("#login").slideDown();
                $("#loading-container").slideUp();
            }
        });
    });

    $("#recovery").submit(function (e) {
        e.preventDefault();
        $('#submit-recovery').prop('disabled', true);
        let form = $(this);
        let url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            data: form.serialize(),
            success: function (data) {
                $('#message').html("If " + $('#user-id-recovery').val() + " corresponds to a valid email," +
                    " you'll receive instructions for resetting your password in your inbox. <br>" +
                    "The link is valid for 24 hours.");
                $('#user-id-recovery').css("background", "rgba(0, 255, 0, 0.2)")
                    .css("border-color", "green").val("").prop('disabled', true);
            }
        });
    });

    $('#to-recovery').click(function (e) {
        e.preventDefault();
        $('#recovery').slideDown();
        $('#login').slideUp();
    });

    $('#to-login').click(function () {
        $('#recovery').slideUp();
        $('#login').slideDown();
    });

    $('#close-form').click(function () {
        $('#form-window').fadeOut();
    });
});