<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Photo Gallery - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script>
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="jumbotron mt-4">
    <h1>Select an image from Gallery</h1>
    <p class="lead mt-4 mx-4">
        If you want to change your profile picture with an already uploaded image you can select it from this gallery.
    </p>
</div>
<div class="container flex-wrap">
    <c:forEach items="${requestScope.photos}" var="pair">
        <c:set var="photo" value="${pair.first}"/>
        <c:set var="id" value="${pair.second}"/>
        <figure class="col-md">
            <img alt="picture" class="avatar img-fluid popup-opener" src="${pageContext.request.contextPath}/${photo}">
            <div class="popup-window">
                <div class="popup animate-in">
                    <form action="${pageContext.request.contextPath}/restricted/patient/photo_gallery"
                          class="photo-changer" method="POST">
                        <div id="message" class="mb-2 center-100">
                            Do you want to swap your profile photo with this?
                        </div>
                        <img class="avatar mb-2" src="${pageContext.request.contextPath}/${photo}" alt="${photo}">
                        <label>
                            <input type="text" hidden name="photoID" value="${id}">
                        </label>
                        <button class="btn btn-lg btn-block btn-personal mb-2" type="submit" id="submit">Change photo
                        </button>
                    </form>
                    <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                </div>
            </div>
        </figure>
    </c:forEach>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>