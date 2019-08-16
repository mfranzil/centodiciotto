<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>CentoDiciotto - Home</title>
    <%@ include file="/jsp/head.jsp" %>
    <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
    <!-- Plugin CSS e JS, presi dal template -->
    <link href="${pageContext.request.contextPath}/vendor/magnific-popup/magnific-popup.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
</head>
<body id="page-top" style="padding-top: 0"> <!-- COZZA CON LA NAVBAR! Non toccare a meno che non sistemiate la nav -->
<%@ include file="/jsp/nav.jsp" %>
<!-- Masthead -->
<header class="masthead">
    <div class="container h-100">
        <div class="row h-100 align-items-center justify-content-center text-center">
            <div class="col-lg-10 align-self-end">
                <h1 class="text-uppercase text-white font-weight-bold">CentoDiciotto</h1>
            </div>
            <div class="col-lg-8 align-self-baseline">
                <img class="my-4" src="${pageContext.request.contextPath}/img/logo_white.svg" style="width: 150px"
                     alt="Picture of an hospital.">
                <p class="my-4 white">
                    An all-inclusive platform where your local health service meets citizens, doctors and chemists,
                    providing complete control over visits, exams, prescriptions and costs.
                </p>
            </div>
        </div>
    </div>
</header>

<!-- About Section -->
<section class="page-section bg-118-medium-dark" id="about">
    <div class="container">
        <div class="row justify-content-center mx-4">
            <div class="col-lg-8 text-center">
                <h2 class="text-white mt-0">We've got what you need!</h2>
                <hr class="divider light my-4">
                <p class="my-4 white">
                    As a citizen, you can contact your general practitioner or any specialized doctor, see your past and
                    pending exams and visits, check your prescriptions and keep costs under control.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Portfolio Section -->
<section id="portfolio">
    <div class="container-fluid p-0">
        <div class="row no-gutters">
            <div class="col-lg-4 col-sm-6">
                <a class="portfolio-box">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/img/portfolio/1.jpg" alt="">
                    <div class="portfolio-box-caption">
                        <div class="project-category">
                            Citizens
                        </div>
                        <div class="project-name">
                            Find all you need for your health, in one place.
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-sm-6">
                <a class="portfolio-box">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/img/portfolio/2.jpg" alt="">
                    <div class="portfolio-box-caption">
                        <div class="project-category">
                            General practitioner
                        </div>
                        <div class="project-name">
                            Organize your daily work and keep in touch with your patients.
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-sm-6">
                <a class="portfolio-box">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/img/portfolio/3.jpg" alt="">
                    <div class="portfolio-box-caption">
                        <div class="project-category">
                            Specialized doctor
                        </div>
                        <div class="project-name">
                            Keep a list of your patients and prescriptions.
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-sm-6">
                <a class="portfolio-box">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/img/portfolio/4.jpg" alt="">
                    <div class="portfolio-box-caption">
                        <div class="project-category">
                            Local Health Service
                        </div>
                        <div class="project-name">
                            Manage your expenses and mandatory exams.
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-sm-6">
                <a class="portfolio-box">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/img/portfolio/5.jpg" alt="">
                    <div class="portfolio-box-caption">
                        <div class="project-category">
                            Chemist's
                        </div>
                        <div class="project-name">
                            Check your customers' prescriptions and keep in touch with your local HS.
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-sm-6">
                <a class="portfolio-box">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/img/portfolio/6.jpg" alt="">
                    <div class="portfolio-box-caption p-3">
                        <div class="project-category">
                            National Health Service
                        </div>
                        <div class="project-name">
                            All of this - offered to you by the NHS.
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section class="page-section bg-118-medium-dark text-white">
    <div class="container text-center">
        <% if (request.getSession(false) != null && session.getAttribute("user") != null) { %>
        <h2 class="mb-4 mx-4">Visit your profile now.</h2>
        <a class="btn btn-light btn-xl" href="${pageContext.request.contextPath}/restricted/user">Go to my profile</a>
        <% } else { %>
        <h2 class="mb-4 mx-4">Already a member? Get started now.</h2>
        <a class="btn btn-light btn-xl" href="${pageContext.request.contextPath}/login">Login</a>
        <% }%>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="small text-center text-muted pl-4 pr-4">Copyright &copy; 2019 - Francesca Annibaletti, Matteo
                                                            Franzil, Alessia Marcolini, Simone Nascivera
        </div>
    </div>
</footer>
</body>
</html>