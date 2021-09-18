/**
 * JS document used in the user page.
 *
 * Handles AJAX requests for avatar changes (patients only).
 */

$("document").ready(() => {
    $("#upload-avatar").prop("disabled", true);

    $("#password-change").submit(function (e) {
        e.preventDefault();
        let form = $(this);
        let url = form.attr("action");
        let oldPassword = $("#old-password");

        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            data: form.serialize(),
            success: () => {
                $("#old-password,#new-password-confirm,#new-password").val("");
                alert("Password cambiata con successo.");
            },
            error: () => {
                oldPassword.css("background", "rgba(255, 0, 0, 0.2)").css("border-color", "red").val("");
                setTimeout(() => {
                    oldPassword.css("background", "").css("border-color", "");
                }, 2000);
            }
        });
    });

    $("#avatar-select").on("change", function () {
        const filename = $("#avatar-select").val();
        /*
        if (filename === "" || typeof filename === "undefined") {
            alert("Please upload a photo in PNG or JPG format.");
            return;
        }
        */
        let extension = filename.replace(/^.*\./, "").toLowerCase();
        /*
        if (extension === filename || extension !== 'jpg' || extension !== 'png') {
            $("#upload-avatar").prop("disabled", true);
            alert("Please upload a photo in PNG or JPG format.");
            return;
        } else {
            $("#upload-avatar").prop("disabled", false);
        }
        */
        if(filename != null && filename != ""){
            $("#upload-avatar").prop("disabled", false);
        }
        $("#extension").attr("value", extension);
        $(this).next(".custom-file-label").html(filename.replace("C:\\fakepath\\", ""));
    });

    $("#avatar").submit(function (e) {
        e.preventDefault();
        let form = $(this);
        let url = form.attr("action");


        $.ajax({
            type: "POST",
            url: url,
            cache: false,
            processData: false,
            contentType: false,
            enctype: "multipart/form-data",
            data: new FormData(form[0]),
            success: () => {
                alert("Profile photo uploaded successfully.");
                window.location.reload();
            }
        });
    });
});
