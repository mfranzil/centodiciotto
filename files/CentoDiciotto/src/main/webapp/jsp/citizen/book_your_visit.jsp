<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your visit - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Book Your Visit</h1>
    <p class="lead mt-4 mx-4">
        In this section you can book a visit to your practitioner.
    </p>
</div>

<div class="container">

    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Practitioner</th>
            <th scope="col"></th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">Gino</th>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book now</button>
            </td>
        </tr>
        </tbody>
    </table>

</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>