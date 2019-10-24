<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <style>
        @media (min-width: 992px) {
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
                padding-right: 2%;
            }

            .table-cell.action > button {
                margin: .5em;
            }
        }

        @media (max-width: 991.8px) {
            .table-cell.action > button {
                margin-top: .5em;
            }
        }
    </style>
    <script>
        $("document").ready(function () {
            $('#table-select tr').click(function () {
                $(this).find('input[type=radio]').prop('checked', true);
                $('#submit').removeAttr("disabled");
            });
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Prescription</h1>
        <p class="lead mt-4 mx-4">
            For each patient, you can assign exams and drugs.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <form action="search_patient" method="POST">
                    <!--TODO SIMONE BARRA DI RICERCA: tutti i pazienti di un medico -->
                    <div class="form-label-group my-4 mx-4 ls-search">
                        <input class="form-control mx-2" id="query" name="query"
                               placeholder="Search..." required type="text">
                        <button id="message" class="btn btn-personal" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>
                <div class="table-personal table-header">
                    <div class="table-cell avt">&nbsp;</div>
                    <div class="table-cell name">Name</div>
                    <div class="table-cell ssn">SSN</div>
                    <div class="table-cell action">&nbsp;</div>
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
                        <button class="btn btn-block btn-personal popup-opener">
                            Exam prescription
                        </button>
                        <div class="popup-window">
                            <div class="popup animate-in">
                                <form action="" id="form1" method="POST">
                                    <div>
                                        <h4>Choose a prescription...</h4>
                                        <table class="table">
                                            <tr>
                                                <td>Esame1</td>
                                                <td><label>
                                                    <input type="radio" name="form1"
                                                           value="VALOREDAMETTERE1">
                                                </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Esame2</td>
                                                <td><label>
                                                    <input type="radio" name="form1"
                                                           value="VALOREDAMETTERE2">
                                                </label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </form>
                                <button class="btn btn-lg btn-block btn-personal" type="submit">
                                    Confirm
                                </button>
                                <button class="btn btn-lg btn-block popup-closer btn-secondary" type="button">
                                    Cancel
                                </button>
                            </div>
                        </div>
                        <button class="btn btn-block btn-personal popup-opener">
                            Drug prescription
                        </button>
                        <div class="popup-window">
                            <div class="popup animate-in">asdfghjk</div></div>
                    </div>
                </div>
                <hr>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>