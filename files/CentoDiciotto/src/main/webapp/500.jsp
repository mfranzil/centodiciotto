<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>500 Internal Server Error - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
    <script type="text/javascript">
        function loadDomain() {
            var display = document.getElementById("display-domain");
            display.innerHTML = document.domain;
        }
    </script>
</head>
<body onload="loadDomain();">
<%@ include file="/jsp/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>500: Internal Server Error</h1>
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
                    if (exception != null && exception.getCause() != null) {
                %>
                <p style="background: rgba(var(--118-darkest), 1); padding: 1rem; margin-right: 1rem;
                color: white; font-family: monospace;">
                    <%=exception.getCause()%>
                </p>
                <%
                    }
                %>
            </div>
            <div class="col-md-6">
                <h2>What can I do?</h2>
                <p class="lead">Nothing you can do at the moment. If you need immediate assistance, please contact us
                                immediately. We apologize for any inconvenience.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>