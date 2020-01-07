/**
 * JS document for handling new password requests.
 *
 * Used on password reset and user pages.
 */
$("document").ready(() => {
    $("#new-password, #new-password-confirm").on("keyup", () => {
        let message = $("#password-change-button");
        let newPassword = $("#new-password").val();
        let newPasswordConfirm = $("#new-password-confirm").val();

        if (newPassword.length > 64 || newPasswordConfirm.length > 64 ||
            newPassword.length < 8 || newPasswordConfirm.length < 8) {
            message.html("Password must be 8 to 64 characters long.")
                .css("background-color", "red").prop("disabled", true);
            return;
        }

        if (newPassword !== newPasswordConfirm || newPassword === "" || newPasswordConfirm === "") {
            message.html("Passwords do not match.")
                .css("background-color", "red").prop("disabled", true);
            return;
        }

        message.html("Passwords match!").css("background-color", "green").removeAttr("disabled");

        setTimeout(() => {
            message.html("Change your password").css("background-color", "");
        }, 500);
    });
});