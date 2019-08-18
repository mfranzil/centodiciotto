<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>404 Not Found - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>404: Not Found</h1>
        <p class="lead">We're sorry.
                        The URL you requested was not found.
        </p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-default btn-lg text-center"><span
                class="green">Go to the Home Page</span></a>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md-6">
                <h2>What happened?</h2>
                <p class="lead">A 404 error status implies no resource corresponding to this address is present on the web server.</p>
            </div>
            <div class="col-md-6">
                <h2>What can I do?</h2>
                <p class="lead">Make sure the address was typed correctly, go back or head to the Home Page. If you came here from another page, please contact us immediately.</p>
            </div>
        </div>
    </div>
</div>
</body>
<%@ include file="/jsp/fragments/foot.jsp" %>
</html>