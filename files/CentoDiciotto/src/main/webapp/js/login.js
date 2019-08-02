function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
}

function closeForm() {
    // var form = document.getElementById('form');
    // form.classList.remove("animate-in");
    // form.classList.add("animate-out");
    document.getElementById('form_window').style.display = "none";
    return false;
}

function openMenu(id) {
    document.getElementById('form_image').src = getContextPath().toString() + "/images/classes/" + id + ".png";
    document.getElementById('form_name').innerHTML = "Logging in as " + getNameFromId(id);
    document.getElementById('form_window').style.display = 'block';
}

function setFocus(id) {
    unfocusAll();
    document.getElementById(id).classList.add("focused");
}

function unfocusAll() {
    document.getElementById("user").classList.remove("focused");
    document.getElementById("medic").classList.remove("focused");
    document.getElementById("specialized-medic").classList.remove("focused");
    document.getElementById("chemist").classList.remove("focused");
    document.getElementById("health-service").classList.remove("focused");
}

function getNameFromId(id) {
    switch (id) {
        case "user":
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