<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My patients - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script>
        $(document).ready(function () {
            $("#e1").select2();
        });
    </script>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Recalls</h1>
        <p class="lead mt-4 mx-4">
            To make a recall select the exam, and confirm it.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <label>
                    <select class="form-control mb-2">
                        <!--TO DO SIMONE BARRA DI RICERCA:
                        Tutti gli esami esattamente come la ricerca del paziente
                         -->
                        <option selected="selected">Select an exam</option>
                        <option>Agobiopsia ecoguidata transtracheale o transbronchiale di linfonodi ilo mediastinici
                        </option>
                        <option>Biopsia a cielo aperto del polmone</option>
                        <option>Biopsia a cielo aperto delle ghiandole surrenali</option>
                        <option>Biopsia delle strutture articolari della caviglia</option>
                    </select>
                </label>

                <button type="button" class="btn btn-block btn-personal popup-opener">
                    Confirm
                </button>

                <div class="container">
                    <div class="jumbotron mt-4">
                        <h1>Recalls History</h1>
                        <p class="lead mt-4 mx-4">
                            This is the history of all the recalls.
                        </p>
                    </div>
                </div>

                <table class="table table-hover" id="table-select">
                    <thead>
                    <tr>
                        <th scope="col">Exam</th>
                        <th scope="col">Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">Clostridium difficile da coltura identificazione biochimica</th>
                        <td>27/07/2012</td>
                    </tr>
                    <tr>
                        <th scope="row">Analisi citogenetica per patologia da fragilità cromosomica</th>
                        <td>1/10/2016</td>
                    </tr>
                    <tr>
                        <th scope="row">Biopsia a cielo aperto dei nervi cranici o periferici o dei gangli</th>
                        <td>16/09/2019</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>