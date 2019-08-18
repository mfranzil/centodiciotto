<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script>
        $("document").ready(function () {
            $(".popup-opener").click(function () {
                $(this).next().show();
            });
            $(".popup-closer").click(function () {
                $(".popup_window").hide();
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>My patients</h1>
        <p class="lead mt-4 mx-4">
            Click on a patient to get more information, including past visits, exams and prescriptions.
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
                    <tr>
                        <td><img class="avatar-small" src="${pageContext.request.contextPath}/img/avatars/default.png"
                                 alt="">
                        </td>
                        <td>Matteo</td>
                        <td>Franzil</td>
                        <td>FRNMTT98E20I452H</td>
                        <td>
                            <button class="btn btn-personal popup-opener">
                                Patient data
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
                                        <h4>Last appointment</h4>
                                        <table class="table">
                                            <tr>
                                                <th>Date</th>
                                                <td>17/08/2019</td>
                                            </tr>
                                            <tr>
                                                <th>Prescripted drugs</th>
                                                <td>-</td>
                                            </tr>
                                            <tr>
                                                <th>Prescripted exams</th>
                                                <td>Something</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div>
                                        <h4>Past exams</h4>
                                        <table class="table">
                                            <tr>
                                                <td>17/08/2019</td>
                                                <td>Something</td>
                                                <td>I don't know</td>
                                            </tr>
                                            <tr>
                                                <td>11/08/2019</td>
                                                <td>Something else</td>
                                                <td>Assured death in 21 days</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div>
                                        <h4>Past drug prescriptions</h4>
                                        <table class="table">
                                            <tr>
                                                <td>17/08/2019</td>
                                                <td>Aspirina</td>
                                                <td>Taken (?)</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><img class="avatar-small" src="${pageContext.request.contextPath}/img/avatars/default.png"
                                 alt="">
                        </td>
                        <td>Alessia</td>
                        <td>Marcolini</td>
                        <td>MRCLSS98C65L781O</td>
                        <td>
                            <button class="btn btn-personal">
                                Patient data
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>