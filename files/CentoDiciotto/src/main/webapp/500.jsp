<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Internal Server Error</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/errorpage.css">
    <script type="text/javascript">
        function loadDomain() {
            var display = document.getElementById("display-domain");
            display.innerHTML = document.domain;
        }
    </script>
</head>
<body onload="loadDomain();">
<%@ include file="/nav.jsp" %>
<!-- Error Page Content -->
<div class="container">
    <!-- Jumbotron -->
    <div class="jumbotron mt-4">
        <h1><span class="glyphicon glyphicon-fire red"></span> 500: Internal Server Error</h1>
        <p class="lead">The web server is returning an internal error for <em><span id="display-domain"></span></em>.
        </p>
        <a href="javascript:document.location.reload(true);" class="btn btn-default btn-lg text-center"><span
                class="green">Try This Page Again</span></a>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md-6">
                <h2>What happened?</h2>
                <p class="lead">A 500 error status implies there is a problem with the web server's software causing it
                    to malfunction.</p>
                <%
                    if (exception != null) {
                %>
                <p class="lead">Server returned: <%=exception.getCause() != null ? exception.getCause() : exception%>
                    : <%=exception.getMessage()%>
                </p>
                <%
                    if (exception.getCause() != null) {
                %>
                <p>Cause: <%=exception.getCause()%>
                </p>
                <%
                    }
                %>
                <%
                    }
                %>
            </div>
            <div class="col-md-6">
                <h2>What can I do?</h2>
                <p class="lead">Nothing you can do at the moment. If you need immediate assistance, please contact us immediately. We apologize for any inconvenience.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>