<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Unhappy with your practitioner? - CentoDiciotto</title>
    <%@ include file="/jsp/fragments/head.jsp" %>
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
                <table class="table" style="background-color: rgba(120,255,120,0.3)">
                    <% GeneralPractitioner mypractitioner = (GeneralPractitioner) session.getAttribute("practitioner"); %>
                    <tr>
                        <td><%= mypractitioner.getFirstName() %></td>
                        <td><%= mypractitioner.getLastName() %></td>
                        <td><%= mypractitioner.getWorkingProvince() %></td>
                        <td>✔</td>
                    </tr>
                </table>
                <h3 class="my-4">
                    Available practitioners
                    <p class="lead mt-4">
                        To choose a practitioner, select the corresponding name and then confirm your changes clicking
                        on the "I want to change my practitioner" button.
                    </p>
                </h3>
                <form action="change_practitioner_handler" id="practitioner" method="POST">
                    <div style="margin: auto; text-align: center">
                        <button id="submit" class="btn mb-4 btn-personal" disabled type="submit">
                            I want to change my practitioner
                        </button>
                    </div>
                    <table class="table table-hover" id="table-select">
                        <% List<GeneralPractitioner> available_practitioners = (List<GeneralPractitioner>) session.getAttribute("available_practitioners"); %>
                        <%
                            for(int i=0; i<available_practitioners.size();i++){
                                if(((GeneralPractitioner)available_practitioners.get(i)).getEmail().compareTo(mypractitioner.getEmail()) != 0){%>
                        <tr>
                            <td><%= ((GeneralPractitioner)available_practitioners.get(i)).getFirstName() %></td>
                            <td><%= ((GeneralPractitioner)available_practitioners.get(i)).getLastName() %></td>
                            <td><%= ((GeneralPractitioner)available_practitioners.get(i)).getWorkingProvince() %></td>
                            <td><input type="radio" name="practitioner" value="VALOREDAMETTERE2"></td>
                        </tr>
                        <%  }
                            }%>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/jsp/fragments/foot.jsp" %>
</body>