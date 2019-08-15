<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User_table - CentoDiciotto</title>
    <%@ include file="/jsp/head.jsp" %>
</head>
<body>
    <%@ include file="/jsp/nav.jsp" %>

<form class="example" action="action_page.php">
    <input type="text" placeholder="Search Exam..." name="search" style="padding-left: 5vh; padding-right: 5vh; position: relative; left: 30px; top: 30px">
    <button type="submit" style="position: relative; left: 45px; top: 30px"><i class="fa fa-search"></i></button>
</form>

<table class="table" style="position: relative; left: 30px; top: 50px">
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
            <button type="button" class="btn btn-lg btn-primary">Book Now</button>
        </td>
    </tr>
    <tr>
        <th scope="row">Luigi Verdi</th>
        <td>Endocrinology</td>
        <td>Ecography</td>
        <td><button type="button" class="btn btn-lg btn-primary">Book Now</button>
        </td>
    </tr>
    <tr>
        <th scope="row">Veronica Bianchi</th>
        <td>Neurology</td>
        <td>Neurophysiological examination</td>
        <td><button type="button" class="btn btn-lg btn-primary">Book Now</button>
        </td>
    </tr>
    </tbody>
</table>
</body>