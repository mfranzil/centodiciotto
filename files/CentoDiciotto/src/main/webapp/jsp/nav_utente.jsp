<%@page contentType="text/html" pageEncoding="UTF-8" %>
<nav class="navbar sticky-top navbar-light navbar-expand-lg bg-light nav-personal">
    <a class="navbar-brand white" style="height: 100%;" href="${pageContext.request.contextPath}/">
        <img class="navbar-logo" src="${pageContext.request.contextPath}/img/logo_white.svg" style="height: 44px;" alt="">
    </a>

    <div class="nav-item">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="" style="color: white">
                    Home
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="" style="color: white">
                    Esami e Visite
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="" style="color: white">
                    Ricette e Prescrizioni
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="" style="color: white">
                    Ticket
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="" style="color: white">
                    Non sei soddisfatto del tuo medico di base?
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/restricted/logout_handler" style="color: white">
                    Logout
                    <img src="${pageContext.request.contextPath}/img/logout_white.png" style="height: 23px;" alt="">
                </a>
            </li>
        </ul>
    </div>
</nav>