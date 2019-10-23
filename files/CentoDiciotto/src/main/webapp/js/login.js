function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
}

function getNameFromId(id) {
    switch (id) {
        case "patient":
            return "Patient";
        case "general_practitioner":
            return "General practitioner";
        case "specialized_doctor":
            return "Specialized doctor";
        case "chemist":
            return "Chemist's";
        case "health_service":
            return "Health Service";
        default:
            return "-";
    }
}

$("document").ready(function () {
    $('#userid-login').val(localStorage.userID);
    $('#password-login').val(localStorage.password);
    $('#remember-me').prop("checked", localStorage.checkBoxValidation);

    $(".hover-button").click(function () {
        let id = this.id;
        let role = getNameFromId(id);
        $('#form-image').attr('src', getContextPath().toString() + "/img/classes/" + id + ".png");
        $('#form-name').html("Logging in as " + role);
        $('#form-window').show();
        $('#role').val(id);
    });

    $("#login").submit(function (e) {
        e.preventDefault();

        if ($('#remember-me').is(':checked')) {
            localStorage.userID = $('#userid-login').val();
            localStorage.password = $('#password-login').val();
            localStorage.checkBoxValidation = true;
        } else {
            localStorage.userid = '';
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
            success: function (__data) {
                __data = JSON.parse(__data);
                window.location = __data.url;
            },
            error: function (data) {
                alert("Nome utente o password non corretti.");
                $('#userid-login,#password-login').css("background", "rgba(255, 0, 0, 0.2)")
                    .css("border-color", "red");
                setTimeout(function () {
                    $('#userid-login,#password-login').css("background", "").css("border-color", "");
                }, 2000);
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
                $('#message').html("If " + $('#userid-recovery').val() + " corresponds to a valid email," +
                    " you'll receive instructions for resetting your password in your inbox. <br>" +
                    "The link is valid for 24 hours.");
                $('#userid-recovery').css("background", "rgba(0, 255, 0, 0.2)")
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