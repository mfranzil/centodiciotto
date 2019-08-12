<%@page contentType="text/html" pageEncoding="UTF-8" %>
<nav class="navbar sticky-top navbar-light justify-content-between nav-personal">
    <a class="navbar-brand white" style="height: 100%;" href="${pageContext.request.contextPath}/">
        <img class="navbar-logo" src="${pageContext.request.contextPath}/img/logo_white.svg" style="height: 44px;" alt="">
    </a>
    <div class="nav-item">
        <% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
            <a class="nav-link" href="${pageContext.request.contextPath}/restricted/logout_handler" style="color: white">
            Logout
            <img src="${pageContext.request.contextPath}/img/logout_white.png" style="height: 24px;" alt="">
        <% } else { %>
            <a class="nav-link white"
               <% if (request.getRequestURI().equals(request.getContextPath() + "/login")) {%>
               style="font-weight: bolder"
               <% } else { %>
               href="${pageContext.request.contextPath}/login"
               <% } %>>
                 Login
            <img src="${pageContext.request.contextPath}/img/login_white.png" style="height: 24px;" alt="">
        <% } %>
        </a>
    </div>
</nav>