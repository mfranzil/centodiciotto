<%@page contentType="text/html" pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">

<%-- Favicon --%>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.png" type="image.png">

<%-- Librerie esterne --%>
<link href="${pageContext.request.contextPath}/vendor/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendor/jquery.timepicker.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendor/jquery-ui.min.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/vendor/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/jquery-ui.min.js"></script>

<%-- CSS e JS personali --%>
<link href="${pageContext.request.contextPath}/css/base.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/base.js"></script>
<script>
    const resourceServer = "${applicationScope['resourceServer']}";
    const imageServer = "${applicationScope['imageServer']}";
</script>