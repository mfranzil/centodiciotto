<%@page contentType="text/html" pageEncoding="UTF-8" %>


<nav class="navbar sticky-top navbar-dark navbar-expand-lg bg-light justify-content-between nav-personal">
    <button class="navbar-brand white navbar-toggler" style="height: 100%; border: none"
            type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"
            id="nav-logo-container">
        <img class="navbar-logo" id="logo" src="${pageContext.request.contextPath}/img/logo_white.svg"
             style="height: 38px" alt="">
    </button>

    <div class="collapse navbar-collapse nav-item" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link nav-link-personal" style="font-weight: bold;"
                   href="${pageContext.request.contextPath}/">
                    Home
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="">
                    Esami e Visite
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="">
                    Ricette e Prescrizioni
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="">
                    Ticket
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="">
                    Non sei soddisfatto del tuo medico di base?
                </a>
            </li>
        </ul>
    </div>

    <div class="nav-item" id="navbarLogout" style="padding: 0">
        <a class="nav-link" href="${pageContext.request.contextPath}/restricted/logout_handler" style="padding-left: 0; color: white">
            Logout
            <img src="${pageContext.request.contextPath}/img/logout_white.png" style="height: 23px;" alt="">
        </a>
    </div>

    <script>
        $("#nav-logo-container").click(function () {
            $("#logo").toggleClass("navbar-logo-animate");
            $("#logo").one("webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend",
                function (event) {
                    //$("#logo").removeClass("navbar-logo-animate");
                });
        });
    </script>
</nav>