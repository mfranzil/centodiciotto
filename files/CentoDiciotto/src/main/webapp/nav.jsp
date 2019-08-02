<%@page contentType="text/html" pageEncoding="UTF-8" %>
<nav class="navbar sticky-top navbar-light justify-content-between"
     style="top: 0; color: white; background-color: rgba(0, 0, 0, 0) !important;
     background-image: linear-gradient(to right, rgba(0, 153, 230, 1), rgba(51, 187, 255, 1));
     box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.2);">
    <a class="navbar-brand" style="height: 100%; color: white;" href="${pageContext.request.contextPath}/">
        <img class="navbar-logo" src="${pageContext.request.contextPath}/images/logo_white.svg" style="height: 44px;" alt="">
    </a>

    <div class="nav-item">
        <% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
            <a class="nav-link" href="${pageContext.request.contextPath}/restricted/logout.handler" style="color: white">
            Logout
            <img src="${pageContext.request.contextPath}/images/logout_white.png" style="height: 24px;" alt="">
        <% } else { %>
            <a class="nav-link"
               <% if (request.getRequestURI().equals(request.getContextPath() + "/login")) {%>
               style="color: white; font-weight: bolder"
               <% } else { %>
               href="${pageContext.request.contextPath}/login" style="color: white"
               <% } %>>
                 Login
            <img src="${pageContext.request.contextPath}/images/login_white.png" style="height: 24px;" alt="">
        <% } %>
        </a>
    </div>
</nav>