<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.avt {
                width: 10%;
            }

            .table-cell.name {
                width: 35%;
            }

            .table-cell.ssn {
                width: 30%;
            }

            .table-cell.action {
                width: 25%;
            }
            /* Tabella sotto */
            .table-cell.date {
                width: 25%;
            }

            .table-cell.medicine {
                width: 50%;
            }

            .table-cell.deliver {
                width: 25%;
            }

        }
    </style>
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
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <input class="form-control mx-2" id="query" name="query" placeholder="Search..." required
                               type="text">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
                <div class="table-personal table-header">
                    <div class="table-cell avt"></div>
                    <div class="table-cell name">Name</div>
                    <div class="table-cell ssn">SSN</div>
                    <div class="table-cell action"></div>
                </div>
                <div class="table-personal" id="table-select">
                    <div class="table-cell avt">
                        <img class="avatar-small"
                             src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                             alt="">
                    </div>
                    <div class="table-cell name">Matteo Franzil</div>
                    <div class="table-cell ssn">FRNMTT98E20I452H</div>
                    <div class="table-cell action">
                        <button type="button" class="btn btn-block btn-personal popup-opener">
                            See Valid Prescriptions
                        </button>
                        <div class="popup-window">
                            <div class="popup animate-in">
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
                                    <div>
                                        <div class="table-personal">
                                            <div class="table-cell date">17/08/2019</div>
                                            <div class="table-cell medicine">Tachipirina</div>
                                            <div class="table-cell deliver"><input
                                                    onclick='document.getElementById("myButton1").value="Delivered"; this.disabled=true;'
                                                    type="button" class="btn btn-block btn-personal"
                                                    value="Mark as delivered" id="myButton1"
                                                    style="width:250px">
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="table-personal">
                                            <div class="table-cell date">17/08/2019</div>
                                            <div class="table-cell medicine">Oki</div>
                                            <div class="table-cell deliver">
                                                <input onclick='document.getElementById("myButton2").value="Delivered"; this.disabled=true;'
                                                       type="button" class="btn btn-block btn-personal"
                                                       value="Mark as delivered" id="myButton2"
                                                       style="width:250px">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>