<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    List<String> photos = (List<String>) request.getAttribute("photos");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Photo Gallery - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron mt-4">
    <h1>Select an image from Gallery</h1>
    <p class="lead mt-4 mx-4">
        If you want to change your profile picture with an already uploaded image you can select it from this gallery.
    </p>
</div>
<div class="container" style="display: flex; flex-flow: wrap; text-align: center">
    <% for (String photo : photos) { %>
    <figure class="col-md-3">
        <a href="${pageContext.request.contextPath}/<%= photo %>">
            <img alt="picture" class="avatar img-fluid" src="${pageContext.request.contextPath}/<%= photo %>">
        </a>
    </figure>
    <%}%>

</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>