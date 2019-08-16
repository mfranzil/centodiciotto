<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User_table - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
</head>
<body>
<%@ include file="/jsp/nav.jsp" %>

<div class="jumbotron mt-4">
    <h1>Book Your Visit</h1>
    <p class="lead mt-4 mx-4">
        In this section you can book a visit to your practitioner..
    </p>
</div>

<div class="container">

    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Practitioner</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">Gino</th>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        </tbody>
    </table>

    <p class="lead mt-4 mx-4" style="text-align: center">
            ..or to a specialist using the "Search Menu" to choose the specialization.
    </p>

    <form action="search_specialization" method="POST">
        <div class="form-label-group my-4" style="display: flex; justify-content: flex-end">
            <input class="form-control mx-2" id="query" name="query"
                   placeholder="Search specialization..." required type="text" style="width: auto">
            <button id="message" class="btn btn-personal" type="submit">
                <i class="fa fa-search"></i>
            </button>
        </div>
    </form>

    <table class="table table-hover" style="margin: auto; overflow-wrap: break-word">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Specialization</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">Mario Rossi</th>
            <td>Cardiology</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        <tr>
            <th scope="row">Luigi Verdi</th>
            <td>Endocrinology</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        <tr>
            <th scope="row">Veronica Bianchi</th>
            <td>Neurology</td>
            <td>
                <button type="button" class="btn btn-block btn-personal">Book Now</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>