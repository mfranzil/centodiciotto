function closeForm() {
    // var form = document.getElementById('form');
    // form.classList.remove("animate-in");
    // form.classList.add("animate-out");
    document.getElementById('form_window').style.display = "none";
    return false;
}

function openMenu(id) {
    document.getElementById('form_image').src = "images/classes/" + id + ".png";
    document.getElementById('form_name').innerHTML = "Accesso come " + getNameFromId(id);
    document.getElementById('form_window').style.display = 'block';
}

function setFocus(id) {
    unfocusAll();
    document.getElementById(id).classList.add("focused");
}

function unfocusAll() {
    document.getElementById("user").classList.remove("focused");
    document.getElementById("medic").classList.remove("focused");
    document.getElementById("medicsp").classList.remove("focused");
    document.getElementById("chemist").classList.remove("focused");
    document.getElementById("ssp").classList.remove("focused");
}

function getNameFromId(id) {
    switch (id) {
        case "user":
            return "Utente";
        case "medic":
            return "Medico di base";
        case "medicsp":
            return "Medico specialista";
        case "chemist":
            return "Farmacia";
        case "ssp":
            return "Servizio sanitario";
        default:
            return "-";
    }
}