function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
}

function closeForm() {
    // var form = document.getElementById('form');
    // form.classList.remove("animate-in");
    // form.classList.add("animate-out");
    document.getElementById('form_window').style.display = "none";
    return false;
}

function openMenu(id) {
    let role = getNameFromId(id);
    document.getElementById('form_image').src = getContextPath().toString() + "/img/classes/" + id + ".png";
    document.getElementById('form_name').innerHTML = "Logging in as " + role;
    document.getElementById('form_window').style.display = 'block';
    document.getElementById('role').value = id;
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
    $("#login").submit(function (e) {
        e.preventDefault();
        if ($('#rememberMe').is(':checked')) {
            // save username and password
            localStorage.userName = $('#username').val();
            localStorage.password = $('#password').val();
            localStorage.checkBoxValidation = true;
        } else {
            localStorage.userName = '';
            localStorage.password = '';
            localStorage.checkBoxValidation = false;
        }

        let form = $(this);
        let url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
            data: form.serialize(),
            success: function(__data) {
                __data = JSON.parse(__data);
                window.location = __data.url;
            },
            error: function (data) {
                alert("Nome utente o password non corretti.");
                $('#username,#password').css("background", "rgba(255, 0, 0, 0.2)").css("border-color", "red");
                setTimeout(function () {
                    $('#username,#password').css("background", "").css("border-color", "");
                }, 2000);
            }
        });
    });

    if (localStorage.checkBoxValidation) {
        $('#username').val(localStorage.userName);
        $('#password').val(localStorage.password);
        $('#rememberMe').prop("checked", true);
    }
});