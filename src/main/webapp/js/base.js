$("document").ready(function () {
    enablePopup();

    $(window).on('resize', function () {
        var win = $(this);
        if (win.width() >= 992) {
            $("#log-menu-closed").show();
            $("#nav-log").detach().appendTo('#log-menu-closed');
        } else {
            $("#nav-log").detach().appendTo('#log-menu-open');
            $("#log-menu-closed").hide();
        }
    });

    $("#nav-logo-container").click(function () {
        if ($("#nav-logo-container").attr("aria-expanded") === "false") {
            $("#nav-log").detach().appendTo('#log-menu-open');
            $("#log-menu-closed").hide();
        }
        $("#logo").toggleClass("navbar-logo-animate");
    });

    $(function(){
        $('a').each(function() {
            if ($(this).prop('href') === window.location.href) {
                $(this).addClass('current');
            }
        });
    });
});

function enablePopup() {
    $(".popup-opener").click(function () {
        $(this).next().fadeIn();
    });
    $(".popup-closer").click(function (e) {
        e.preventDefault();
        $(".popup-window").fadeOut();
    });
    $(".popup-window").click(function (e) {
        if ($(this).is(e.target)) {
            $(this).fadeOut();
        }
    });
}

function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2)).toString();
}

function getNameFromID(ID) {
    switch (ID) {
        case "patient":
            return "Patient";
        case "general_practitioner":
            return "General practitioner";
        case "specialized_doctor":
            return "Specialized doctor";
        case "chemist":
            return "Chemist's";
        case "health_service":
            return "Health Service";
        default:
            return "-";
    }
}