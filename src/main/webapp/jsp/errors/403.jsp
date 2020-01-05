<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>403 Forbidden - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>403: Forbidden</h1>
        <p class="lead">We're sorry.
                        Access to the requested resource was denied.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-default btn-lg text-center"><span
                class="green">Go to the Home Page</span></a>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md-6">
                <h2>What happened?</h2>
                <p class="lead">A 403 error status implies the server understood the request, but refused to authorize
                                it.</p>
            </div>
            <div class="col-md-6">
                <h2>What can I do?</h2>
                <p class="lead">Make sure the address was typed correctly, go back or head to the Home Page. If you came
                                here from another page, please contact us immediately.</p>
            </div>
        </div>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>