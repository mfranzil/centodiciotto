<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="logged_in" value="${!empty sessionScope.user}"/>

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

    <c:if test="${logged_in}">
        <div class="collapse navbar-collapse nav-item" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/">
                        Home
                    </a>
                </li>
                <c:choose>
                    <c:when test="${sessionScope.role eq 'patient'}">
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-link-personal dropdown-toggle"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Exams
                            </a>
                            <div class="dropdown-menu nav-personal">
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/patient/exam_history">Exam
                                                                                                             History</a>
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/patient/exam_booking">Book your
                                                                                                             Exam</a>
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
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/patient/tickets">
                                Tickets
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/patient/change_practitioner">
                                Unhappy with your practitioner?
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.role eq 'general_practitioner'}">
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/general_practitioner/patients">
                                My patients
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-link-personal dropdown-toggle"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Visits and Requests
                            </a>
                            <div class="dropdown-menu nav-personal">
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/general_practitioner/visit_requests">Requests</a>
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
                    </c:when>
                    <c:when test="${sessionScope.role eq 'specialized_doctor'}">
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/specialized_doctor/patients">
                                My patients
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-link-personal dropdown-toggle"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Exams
                            </a>
                            <div class="dropdown-menu nav-personal">
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/specialized_doctor/exam_requests">Requests</a>
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/specialized_doctor/exam_calendar">Calendar</a>
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/specialized_doctor/exam_history">History</a>
                            </div>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.role eq 'health_service'}">
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/health_service/patients">
                                Patients
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-link-personal dropdown-toggle"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Exams
                            </a>
                            <div class="dropdown-menu nav-personal">
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/health_service/exam_requests">Requests</a>
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/health_service/exam_calendar">Calendar</a>
                                <a class="dropdown-item nav-link-personal"
                                   href="${pageContext.request.contextPath}/restricted/health_service/exam_history">History</a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/health_service/recalls">
                                Recalls
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/health_service/reports">
                                Reports
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.role eq 'chemist'}">
                        <li class="nav-item">
                            <a class="nav-link nav-link-personal"
                               href="${pageContext.request.contextPath}/restricted/chemist/prescriptions">
                                Prescriptions
                            </a>
                        </li>
                    </c:when>
                </c:choose>
            </ul>
        </div>
        <div id="log-menu-closed">
                <%--suppress XmlDuplicatedId --%>
            <div id="nav-log" class="nav-item" style="display: flex; align-items: center;">
                <a class="nav-link nav-link-personal " href="${pageContext.request.contextPath}/restricted/user">
                    Hi ${sessionScope.displayName}!
                </a>
                <a class="nav-link nav-link-personal"
                   href="${pageContext.request.contextPath}/restricted/logout_handler">
                    Logout
                    <img src="${pageContext.request.contextPath}/img/logout_white.png" class="nav-icon" alt="Logout">
                </a>
            </div>
        </div>
    </c:if>
    <c:if test="${!logged_in}">
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
                <%--suppress XmlDuplicatedId --%>
            <div id="nav-log" class="nav-item">
                <a class="nav-link nav-link-personal" href="${pageContext.request.contextPath}/login">
                    Login
                    <img src="${pageContext.request.contextPath}/img/login_white.png" class="nav-icon" alt="Login">
                </a>
            </div>
        </div>
    </c:if>
</nav>