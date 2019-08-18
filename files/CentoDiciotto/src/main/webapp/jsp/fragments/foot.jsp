<%@page contentType="text/html" pageEncoding="UTF-8" %>
<style>
    footer {
        background-color: rgba(0, 0, 0, 0) !important;
        background-image: -webkit-gradient(linear, right bottom, left bottom, from(rgba(var(--118-medium-dark), 0.85)),
        to(rgba(var(--118-medium), 0.85)));
        background-image: -o-linear-gradient(right, rgba(var(--118-medium-dark), 0.85), rgba(var(--118-medium), 0.85));
        background-image: linear-gradient(to left, rgba(var(--118-medium-dark), 0.85), rgba(var(--118-medium), 0.85));
        color: white;
        text-align: center;
        margin-top: 3rem;
        flex-shrink: 0;
        width: 100%;
    }

    footer a {
        color: white;
        font-weight: bold;
    }

    body {
        display: flex;
        min-height: 100vh;
        flex-direction: column;
        justify-content: space-between
    }
</style>
<footer class="p-4 sticky-bottom">
    <div class="container">
        <div class="small px-4">
            Copyright &copy; 2019 CentoDiciotto - P.I. 81921980900
            <br>Francesca Annibaletti, Matteo Franzil, Alessia Marcolini, Simone Nascivera
            <br>
            <a href="${pageContext.request.contextPath}/privacy">Privacy</a>
            - <a href="${pageContext.request.contextPath}/cookies">Cookies</a>
            - <a href="${pageContext.request.contextPath}/pdfs/codice_comportamento.pdf">Code of Conduct</a>
        </div>
    </div>
</footer>