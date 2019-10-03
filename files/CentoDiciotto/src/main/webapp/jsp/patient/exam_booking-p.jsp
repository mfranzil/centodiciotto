<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book your exam - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/search.js"></script>

    <!-- //TODO remove src and link here !-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/css/select2.min.css">
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Book Your Exam</h1>
    <p class="lead mt-4 mx-4">
        You can search for the exam you need via the appropriate search menu.
        The exam date will be established by the specialist doctor.
    </p>
</div>

<div class="container">
    <div class="form-group">
        <label for="exam-search">Tags:</label>
        <select id="exam-search" name="exam-search" class="form-control select2-allow-clear" autofocus>
        </select>
        <small class="form-text text-muted">Click the input text or space to start to digit.</small>
    </div>
</div>
    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Specialist</th>
            <th scope="col">Specialization</th>
            <th scope="col">Exam</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">Mario Rossi</th>
            <td>Cardiology</td>
            <td>ECG</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        <tr>
            <th scope="row">Luigi Verdi</th>
            <td>Endocrinology</td>
            <td>Ecography</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        <tr>
            <th scope="row">Veronica Bianchi</th>
            <td>Neurology</td>
            <td>Neuro examination</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>

</body>