<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Autenticazione richiesta</title>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="css/base.css" rel="stylesheet" type="text/css">
    <link href="css/login.css" rel="stylesheet" type="text/css">
    <script src="js/login.js"></script>
</head>
<body>
<%@ include file="/nav.jsp" %>
<div class="text-center mb-4 mt-4">
    <h3 class="h3 mb-1 font-weight-normal">Effettua il login come...</h3>
</div>
<div style="text-align: center; display: flex; overflow: fragments; flex-wrap: wrap; padding-left: 10vh; padding-right: 10vh">
    <div class="hover-button" id="user" onclick="openMenu(this.id)" onmouseout="unfocusAll()" onmouseover="setFocus(this.id)">
        <img alt="Paziente" class="mb-2" src="images/classes/user.png" style="width: 128px">
        <br>Paziente
    </div>
    <div class="hover-button" id="medic" onclick="openMenu(this.id)" onmouseout="unfocusAll()" onmouseover="setFocus(this.id)">
        <img alt="Medico di base" class="mb-2" src="images/classes/medic.png" style="width: 128px;">
        <br>Medico di base
    </div>
    <div class="hover-button" id="medicsp" onclick="openMenu(this.id)" onmouseout="unfocusAll()" onmouseover="setFocus(this.id)">
        <img alt="Medico Specialista" class="mb-2" src="images/classes/medicsp.png" style="width: 128px;">
        <br>Medico specialista
    </div>
    <div class="hover-button" id="chemist" onclick="openMenu(this.id)" onmouseout="unfocusAll()" onmouseover="setFocus(this.id)">
        <img alt="Farmacia" class="mb-2" src="images/classes/chemist.png" style="width: 128px;">
        <br>Farmacia
    </div>
    <div class="hover-button" id="ssp" onclick="openMenu(this.id)" onmouseout="unfocusAll()" onmouseover="setFocus(this.id)">
        <img alt="Servizio Sanitario" class="mb-2" src="images/classes/ssp.png" style="width: 128px;">
        <br>Servizio Sanitario
    </div>
</div>

<div class="login_modal" id="form_window">
    <form action="login.handler" class="login animate-in" id="form" method="POST">
        <div style="width: 100%; text-align:center;">
            <img id="form_image" style="width: 32px" src="" alt="...">
        </div>
        <div class="mb-2" id="form_name" style="width: 100%; text-align: center">
            Accesso come...
        </div>
        <div class="form-label-group">
            <input autofocus class="form-control" id="username" name="username" placeholder="Username" required type="email">
            <label for="username">
                Username
            </label>
        </div>
        <div class="form-label-group">
            <input class="form-control" id="password" name="password" placeholder="Password" required type="password">
            <label for="password">Password</label>
        </div>
        <div style="display: flex">
            <div class="checkbox mb-3" style="flex: 30%;">
                <label>
                    <input name="rememberMe" type="checkbox" value="true"> Ricordami
                </label>
            </div>
            <div style="text-align: right; flex: 70%">
                <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">Hai dimenticato la password?</a>
            </div>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Entra</button>
        <button class="btn btn-lg btn-secondary btn-block" type="button" onclick="closeForm()">Indietro</button>
    </form>
</div>
</body>

</html>