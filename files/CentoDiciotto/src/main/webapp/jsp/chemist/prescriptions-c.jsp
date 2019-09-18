<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Prescriptions</h1>
        <p class="lead mt-4 mx-4">
            To provide a drug to a person you have to search him (by name or SSD) and select him.
            You will see all the prescriptions still valid.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <form action="search_patient" method="POST">
                    <div class="form-label-group my-4" style="display: flex; justify-content: flex-end">
                        <input class="form-control mx-2" id="query" name="query"
                               placeholder="Search..." required type="text" style="width: auto">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
                <table class="table table-hover" id="table-select">
                    <thead>
                    <tr>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">Patient</th>
                        <th scope="col">SSN</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <img class="avatar-small" src="${pageContext.request.contextPath}/img/avatars/default.png"
                                 alt="">
                        </td>
                        <th scope="row">Matteo Franzil</th>
                        <td>FRNMTT98E20I452H</td>
                        <td>
                            <button type="button" class="btn btn-block btn-personal popup-opener">
                                See Valid Prescriptions
                            </button>
                            <div class="popup_window">
                                <div class="popup animate-in" style="overflow-y: auto">
                                    <div>
                                        <h4>Patient data</h4>
                                        <table class="table">
                                            <tr>
                                                <th>Name</th>
                                                <td>Matteo</td>
                                            </tr>
                                            <tr>
                                                <th>Surname</th>
                                                <td>Franzil</td>
                                            </tr>
                                            <tr>
                                                <th>SSN</th>
                                                <td>FRNMTT98E20I452H</td>
                                            </tr>
                                            <tr>
                                                <th>Birthdate</th>
                                                <td>May 20, 1998</td> <!--USARE CLASSE DATA JSTL-->
                                            </tr>
                                            <tr>
                                                <th>Gender</th>
                                                <td>Male</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div>

                                    </div>
                                    <div>
                                        <h4>Valid Prescriptions</h4>
                                        <table class="table">
                                            <tr>
                                                <td>17/08/2019</td>
                                                <td>Tachipirina</td>
                                                <td><input onclick='document.getElementById("myButton1").value="Delivered"; this.disabled=true;' type="button" class="btn btn-block btn-personal" value="Mark as delivered" id="myButton1"
                                                           style="width:250px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>17/08/2019</td>
                                                <td>Oki</td>
                                                <td>
                                                    <input onclick='document.getElementById("myButton2").value="Delivered"; this.disabled=true;' type="button" class="btn btn-block btn-personal" value="Mark as delivered" id="myButton2"
                                                           style="width:250px">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img class="avatar-small" src="${pageContext.request.contextPath}/img/avatars/default.png"
                                 alt="">
                        </td>
                        <th scope="row">Alessia Marcolini</th>
                        <td>MRCLSS98C65L781O</td>
                        <td>
                            <button type="button" class="btn btn-block btn-personal popup-opener">
                                See Valid Prescriptions
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>