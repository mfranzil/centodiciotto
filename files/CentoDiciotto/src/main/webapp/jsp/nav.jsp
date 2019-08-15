<%@page contentType="text/html" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath}/js/nav.js"></script>
<nav class="navbar sticky-top navbar-dark navbar-expand-lg bg-light justify-content-between nav-personal">
    <button id="nav-logo-container" type="button"
            class="navbar-brand white navbar-toggler navbar-button-personal"
            data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <img id="logo" class="navbar-logo" src="${pageContext.request.contextPath}/img/logo_white.svg" alt="">
    </button>

    <img class="landscape-logo" src="${pageContext.request.contextPath}/img/logo_white.svg" alt="">

    <div id="log-menu-open">
    </div>

    <% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
    <div class="collapse navbar-collapse nav-item" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/">
                    Home
                </a>
            </li>
            <li class="nav-item dropdown" >
                <a class="nav-link nav-link-personal dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Exams
                </a>
                <div class="dropdown-menu nav-personal">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/restricted/citizen/exam_history">Exam History</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/restricted/citizen/book_your_exam">Book your Exam</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/restricted/citizen/booking_noticing_board">Booking Notice Board</a>
                </div>
            </li>
            
            <li class="nav-item">
                <a class="nav-link nav-link-personal">
                    Prescriptions
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal">
                    Tickets
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal"
                   href="${pageContext.request.contextPath}/restricted/citizen/unhappy_practitioner">
                    Unhappy with your practitioner?
                </a>
            </li>
        </ul>
    </div>

    <div id="log-menu-closed">
        <div id="nav-log" class="nav-item" style="padding: 0; display: flex;">
            <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/restricted/user">
                Hi user!
            </a>
            <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/restricted/logout_handler">
                Logout
                <img src="${pageContext.request.contextPath}/img/logout_white.png" style="height: 24px;" alt="">
            </a>
        </div>
    </div>
    <% } else { %>
    <div class="collapse navbar-collapse nav-item" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/">
                    Home
                </a>
            </li>
        </ul>
    </div>

    <div id="log-menu-closed">
        <div id="nav-log" class="nav-item" style="padding: 0">
            <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/login">
                Login
                <img src="${pageContext.request.contextPath}/img/login_white.png" style="height: 24px;" alt="">
            </a>
        </div>
    </div>
    <% } %>
</nav>
