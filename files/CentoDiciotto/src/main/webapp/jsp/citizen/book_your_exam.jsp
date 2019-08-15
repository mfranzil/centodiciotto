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
        <h1>Book Your Exam</h1>
        <p class="lead mt-4 mx-4">
            You can search for the exam you need via the appropriate search menu.
            The exam date will be established by the specialist doctor.
        </p>
    </div>

<form class="example" action="action_page.php">
    <input type="text" placeholder="Search Exam..." name="search" style="padding-left: 5vh; padding-right: 5vh; position: relative; left: 70px">
    <button type="submit" style="position: relative; left: 80px; top: 0px"><i class="fa fa-search"></i></button>
</form>

    <div class="col-md-10" style="margin-left:auto; margin-right:auto; top: 30px">
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
            <button type="button" class="btn btn-block mt-4 btn-personal">Book Now</button>
        </td>
    </tr>
    <tr>
        <th scope="row">Luigi Verdi</th>
        <td>Endocrinology</td>
        <td>Ecography</td>
        <td><button type="button" class="btn btn-block mt-4 btn-personal">Book Now</button>
        </td>
    </tr>
    <tr>
        <th scope="row">Veronica Bianchi</th>
        <td>Neurology</td>
        <td>Neuro examination</td>
        <td><button type="button" class="btn btn-block mt-4 btn-personal">Book Now</button>
        </td>
    </tr>
    </tbody>
</table>
</body>