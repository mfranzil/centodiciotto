<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script src="${pageContext.request.contextPath}/js/popup.js"></script>
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
            For each patient, you can assign exams and drugs.<br> QUESTA PAGINA E' DA FINIRE; DIPENDE SE LA SINGOLA
            PRESCRIZIONE DIPENDE DALLA VISITA OPPURE E' INDIPENDENTE (forse la seconda)
            - LA SCELTA E' PER ORA SU INDIPENDENTE, e la pagina di conseguenza
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
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
                            <img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                 alt="">
                        </td>
                        <th scope="row">Matteo Franzil</th>
                        <td>FRNMTT98E20I452H</td>
                        <td>
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
                        </td>
                        <td>
                            <button class="btn btn-block btn-personal popup-opener">
                                Drug prescription
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td><img class="avatar-small" src="${pageContext.request.contextPath}/${initParam['avatar-folder']}/default.png"
                                 alt="">
                        </td>
                        <th scope="row">Alessia Marcolini</th>
                        <td>MRCLSS98C65L781O</td>
                        <td>
                            <button class="btn btn-block btn-personal popup-opener">
                                Exam prescription
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-block btn-personal popup-opener">
                                Drug prescription
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