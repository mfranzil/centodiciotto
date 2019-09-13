<%@ page import="it.unitn.web.centodiciotto.persistence.entities.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String role = null;
    String displayName = null;
    User user = null;
    GeneralPractitioner patient_practitioner = null;

    boolean isLoggedIn = request.getSession(false) != null && session.getAttribute("user") != null;
    if (isLoggedIn) {
        user = (User) session.getAttribute("user");
        //TODO: add all classes
        if(user instanceof Patient){
            role = "patient";
            patient_practitioner = (GeneralPractitioner) session.getAttribute("practitioner");
            displayName = ((Patient) user).getFirstName();
        }else if(user instanceof GeneralPractitioner){
            role = "general_practitioner";
            displayName = ((GeneralPractitioner) user).getFirstName();
        }else if(user instanceof SpecializedDoctor){
            role = "specialized_doctor";
            displayName = ((SpecializedDoctor) user).getFirstName();
        }else if(user instanceof Chemist){
            role = "chemist";
            displayName = ((Chemist) user).getName();
        }else if(user instanceof HealthService){
            role = "health_service";
            displayName = ((HealthService) user).getOperatingProvince() + " Health Service";
        }
    }
%>
<script src="${pageContext.request.contextPath}/js/nav.js"></script>
<nav class="navbar fixed-top navbar-dark navbar-expand-lg bg-light justify-content-between nav-personal">
    <button id="nav-logo-container" type="button"
            class="navbar-brand white navbar-toggler navbar-button-personal"
            data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <img id="logo" class="navbar-logo" src="${pageContext.request.contextPath}/img/logo_white.svg" alt="">
    </button>

    <a href="${pageContext.request.contextPath}/">
        <img class="landscape-logo" src="${pageContext.request.contextPath}/img/logo_white.svg" alt="">
    </a>

    <div id="log-menu-open">
    </div>

    <% if (isLoggedIn) { %>
    <div class="collapse navbar-collapse nav-item" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/">
                    Home
                </a>
            </li>
            <% switch (role) {
                case "patient": {
            %>
            <li class="nav-item dropdown">
                <a class="nav-link nav-link-personal dropdown-toggle"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Exams
                </a>
                <div class="dropdown-menu nav-personal">
                    <a class="dropdown-item nav-link-personal"
                       href="${pageContext.request.contextPath}/restricted/patient/exam_history">Exam History</a>
                    <a class="dropdown-item nav-link-personal"
                       href="${pageContext.request.contextPath}/restricted/patient/book_your_exam">Book your Exam</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal"
                   href="${pageContext.request.contextPath}/restricted/patient/visits">Visits</a>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal"
                   href="${pageContext.request.contextPath}/restricted/patient/prescriptions">
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
                   href="${pageContext.request.contextPath}/restricted/patient/unhappy_practitioner">
                    Unhappy with your practitioner?
                </a>
            </li>
            <%      };
                    break;
                case "general_practitioner": { %>
            <li class="nav-item">
                <a class="nav-link nav-link-personal"
                   href="${pageContext.request.contextPath}/restricted/general_practitioner/patients">
                    My patients
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link nav-link-personal dropdown-toggle"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Visits and Request
                </a>
                <div class="dropdown-menu nav-personal">
                    <a class="dropdown-item nav-link-personal"
                       href="${pageContext.request.contextPath}/restricted/general_practitioner/visits">Requests</a>
                    <a class="dropdown-item nav-link-personal"
                       href="${pageContext.request.contextPath}/restricted/general_practitioner/visit_calendar">Calendar</a>
                    <a class="dropdown-item nav-link-personal"
                       href="${pageContext.request.contextPath}/restricted/general_practitioner/visit_history">History</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link nav-link-personal"
                   href="${pageContext.request.contextPath}/restricted/general_practitioner/prescriptions">
                    Prescriptions
                </a>
            </li>
            <%      };
                    break;
                default:
                    break;
            } %>
        </ul>
    </div>
    <div id="log-menu-closed">
        <div id="nav-log" class="nav-item" style="display: flex; align-items: center;">
            <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/restricted/user">
                Hi <%= displayName %>!
            </a>
            <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/restricted/logout_handler">
                Logout
                <img src="${pageContext.request.contextPath}/img/logout_white.png" style="height: 20px;" alt="">
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
        <div id="nav-log" class="nav-item">
            <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/login">
                Login
                <img src="${pageContext.request.contextPath}/img/login_white.png" style="height: 20px;" alt="">
            </a>
        </div>
    </div>
    <% } %>
</nav>
