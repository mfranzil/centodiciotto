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
    document.getElementById('form_image').src = getContextPath().toString() + "/img/classes/" + id + ".png";
    document.getElementById('form_name').innerHTML = "Logging in as " + getNameFromId(id);
    document.getElementById('form_window').style.display = 'block';
}

function getNameFromId(id) {
    switch (id) {
        case "citizen":
            return "Citizen";
        case "medic":
            return "General practitioner";
        case "specialized-medic":
            return "Specialized doctor";
        case "chemist":
            return "Chemist's";
        case "health-service":
            return "Health Service";
        default:
            return "-";
    }
}

$("document").ready(function () {
    $('#form').on('submit', function () {
        if ($('#rememberMe').is(':checked')) {
            // save username and password
            localStorage.userName = $('#username').val();
            localStorage.password = $('#password').val();
            localStorage.checkBoxValidation = $('#rememberMe').val();
        } else {
            localStorage.userName = '';
            localStorage.password = '';
            localStorage.checkBoxValidation = '';
        }
    });
});