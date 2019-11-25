$("document").ready(function () {
    const url = window.location.href;

    $("#user-id-login").val(localStorage.userID);
    $("#password-login").val(localStorage.password);
    $("#remember-me").prop("checked", localStorage.checkBoxValidation);

    $("#loading-container").hide();

    $(".hover-button").click(function () {
        let id = this.id;
        let role = getNameFromID(id);
        $("#form-image").attr("src", getContextPath() + "img/classes/" + id + ".png");
        $("#form-name").html("Log in as " + role);
        $("#form-window").show();
        $("#role").val(id);
    });

    $("#login").submit(function (e) {
        e.preventDefault();

        $("#login").slideUp();
        $("#loading-container").slideDown();

        if ($("#remember-me").is(":checked")) {
            localStorage.userID = $("#user-id-login").val();
            localStorage.password = $("#password-login").val();
            localStorage.checkBoxValidation = true;
        } else {
            localStorage.userID = "";
            localStorage.password = "";
            localStorage.checkBoxValidation = false;
        }

        let form = $(this);
        let oldButtonName = $("#form-name").html();

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            data: form.serialize(),
            success: function (data, textStatus, jqXHR) {
                let json = jqXHR.responseJSON;
                $(".hover-button").prop("disabled", "true");
                $("#form-window").fadeOut();
                window.location = json.url;
            },
            error: function () {
                $(".mini-icon").css("border", "2px solid rgba(135, 0, 0, 0.75) !important");
                $("#form-name").html("Incorrect email or password.").css("color", "rgba(135, 0, 0, 1)")
                    .css("background-color", "rgba(255, 55, 55, 0.6)");
                $("#user-id-login,#password-login").css("background", "rgba(255, 0, 0, 0.2)")
                    .css("border-color", "red");

                setTimeout(function () {
                    $(".mini-icon").css("border", "");
                    $("#user-id-login,#password-login").css("background", "").css("border-color", "");
                    $("#form-name").html(oldButtonName).css("color", "")
                        .css("background-color", "");
                }, 4000);

                $("#login").slideDown();
                $("#loading-container").slideUp();
            }
        });
    });

    $("#recovery").submit(function (e) {
        e.preventDefault();

        $("#recovery").slideUp();
        $("#loading-container").slideDown();

        $("#submit-recovery").prop("disabled", true);
        let form = $(this);

        $.ajax({
            type: "POST",
            url: form.attr("action"),
            cache: false,
            data: form.serialize(),
            success: function (data) {
                $("#recovery").slideDown();
                $("#loading-container").slideUp();
                $("#submit-recovery").slideUp();

                $("#message").html("If " + $("#user-id-recovery").val() + " corresponds to a valid email," +
                    " you'll receive instructions for resetting your password in your inbox. <br>" +
                    "The link is valid for 24 hours.");
                $("#user-id-recovery").css("background", "rgba(0, 255, 0, 0.2)")
                    .css("border-color", "green").prop("disabled", true);
            }
        });
    });

    $("#to-recovery").click(function (e) {
        e.preventDefault();
        $("#recovery").slideDown();
        $("#login").slideUp();
    });

    $("#to-login").click(function () {
        $("#recovery").slideUp();
        $("#login").slideDown();
    });

    $("#close-form").click(function () {
        $("#form-window").fadeOut();
    });
});