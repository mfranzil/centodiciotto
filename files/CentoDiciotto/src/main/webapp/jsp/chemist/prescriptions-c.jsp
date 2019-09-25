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
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <input class="form-control mx-2" id="query" name="query" placeholder="Search..." required type="text">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
                <style>
                    .ls-search {
                        margin:auto; display: flex; justify-content: center
                    }

                    @media (min-width: 992px) {
                        .table-personal {
                            display: table;
                            padding: .5em 1em;
                        }

                        .table-cell {
                            display: table-cell;
                            vertical-align: middle;
                        }

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

                        .table-header {
                            font-weight: bold;
                        }

                        .table-header:hover {
                            background: none !important;
                        }

                    }

                    @media (max-width: 991.8px) {
                        .table-personal {
                            display: block;
                            padding: .5em 15%;
                        }

                        .table-cell {
                            padding: .1em 0;
                            text-align: center;
                        }

                        .table-cell > div {
                            text-align: left;
                        }

                        .table-header {
                            display: none;
                        }

                    }

                    .table-personal {
                        width: 100%;
                        margin: auto;
                    }

                    .table-personal:hover {
                        color: #212529;
                        background-color: rgba(0, 0, 0, .075);
                    }

                    hr {
                        display: block;
                        position: relative;
                        padding: 0;
                        height: 0;
                        margin: 0;
                        width: 100%;
                        max-height: 0;
                        font-size: 1px;
                        line-height: 0;
                        clear: both;
                        border: none;
                        border-bottom: 0.5px solid rgba(170, 170, 170, 0.5);
                        border-top: 0.5px solid rgba(170, 170, 170, 0.5);
                    }
                </style>
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
                                    <table class="table">
                                        <tr>
                                            <td>17/08/2019</td>
                                            <td>Tachipirina</td>
                                            <td><input
                                                    onclick='document.getElementById("myButton1").value="Delivered"; this.disabled=true;'
                                                    type="button" class="btn btn-block btn-personal"
                                                    value="Mark as delivered" id="myButton1"
                                                    style="width:250px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>17/08/2019</td>
                                            <td>Oki</td>
                                            <td>
                                                <input onclick='document.getElementById("myButton2").value="Delivered"; this.disabled=true;'
                                                       type="button" class="btn btn-block btn-personal"
                                                       value="Mark as delivered" id="myButton2"
                                                       style="width:250px">
                                            </td>
                                        </tr>
                                    </table>
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