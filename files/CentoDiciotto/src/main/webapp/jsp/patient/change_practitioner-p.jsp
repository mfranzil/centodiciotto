<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% List<GeneralPractitioner> available_practitioners = (List<GeneralPractitioner>) request.getAttribute("available_practitioners");
    GeneralPractitioner mypractitioner = (GeneralPractitioner) session.getAttribute("practitioner"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Unhappy with your practitioner? - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
    <script>
        $("document").ready(function () {
            $('#table-select div').click(function () {
                $(this).find('input[type=radio]').prop('checked', true);
                $('#submit').removeAttr("disabled");
            });


            $("#practitioner").submit(function (e) {
                e.preventDefault();
                $('#submit').prop('disabled', true).html("Requesting change...");

                let form = $(this);
                let url = form.attr('action');
                let pract = $("input[name='practitioner_email']:checked");

                $.ajax({
                    type: "POST",
                    url: url,
                    cache: false,
                    data: form.serialize(),
                    success: function (data) {
                        $("#current-practitioner").removeClass("chosen-practitioner");
                        $("#check").html("");
                        pract.parent().html("✔").parent().addClass("chosen-practitioner");
                        $('#message').html("Your practitioner change request has been receieved. " +
                            "You will receive a confirmation email soon.");
                        $('#submit,#current-practitioner,#available').slideUp();

                    }
                });
            });
        });
    </script>
    <style>
        @media (min-width: 992px) {
            /* Tabella principale */
            .table-cell.name {
                width: 50%;
            }

            .table-cell.province {
                width: 25%;
            }

            .table-cell.action {
                width: 25%;
            }
        }
    </style>
</head>
<body>
<%@ include file="/jsp/fragments/nav.jsp" %>
<div class="container">
    <div class="jumbotron mt-4">
        <h1>Unhappy with your practitioner?</h1>
        <p class="lead mt-4 mx-4">
            No worries. You can change it, as many times as you want, as long as it's employed in the same province.
            You can find your current practitioner first in the list, followed by all the available ones listed in
            alphabetical order.
        </p>
    </div>
</div>
<div class="container">
    <div class="body-content">
        <div class="row">
            <div class="col-md">
                <h3 class="my-4">
                    Your general practitioner
                </h3>
                <div id="current-practitioner" class="table-personal chosen-practitioner">
                    <div class="table-cell name"><%= mypractitioner.getFirstName() %>&nbsp;<%= mypractitioner.getLastName() %>
                    </div>
                    <div class="table-cell province"><%= mypractitioner.getWorkingProvince() %>
                    </div>
                    <div id="check" class="table-cell action">✔</div>
                </div>

                <h3 id="available" class="my-4">
                    Available practitioners
                </h3>
                <p id="message" class="lead my-4">
                    To choose a practitioner, select the corresponding name and then confirm your changes clicking
                    on the "I want to change my practitioner" button.
                </p>
                <form action="${pageContext.request.contextPath}/restricted/patient/change_practitioner"
                      id="practitioner" method="POST">
                    <div style="margin: auto; text-align: center">
                        <button id="submit" class="btn mb-4 btn-personal" disabled type="submit">
                            I want to change my practitioner
                        </button>
                    </div>
                    <div id="table-select">
                        <% for (GeneralPractitioner available_practitioner : available_practitioners) {
                            if (available_practitioner.getEmail().compareTo(mypractitioner.getEmail()) != 0) {%>
                        <div id="<%=available_practitioner.getEmail()%>" class="table-personal">
                            <div class="table-cell name">
                                <%= available_practitioner.getFirstName() %>&nbsp;<%= available_practitioner.getLastName() %>
                            </div>
                            <div class="table-cell province"><%= available_practitioner.getWorkingProvince() %>
                            </div>
                            <div class="table-cell action">
                                <input type="radio" name="practitioner_email"
                                       value="<%=available_practitioner.getEmail()%>">
                            </div>
                        </div>
                        <hr>
                        <% }
                        }%>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>