$("document").ready(function () {
    enablePopup();

    $(window).on("resize", function () {
        var win = $(this);
        if (win.width() >= 992) {
            $("#log-menu-closed").show();
            $("#nav-log").detach().appendTo("#log-menu-closed");
        } else {
            $("#nav-log").detach().appendTo("#log-menu-open");
            $("#log-menu-closed").hide();
        }
    });

    $("#nav-logo-container").click(function () {
        if ($("#nav-logo-container").attr("aria-expanded") === "false") {
            $("#nav-log").detach().appendTo("#log-menu-open");
            $("#log-menu-closed").hide();
        }
        $("#logo").toggleClass("navbar-logo-animate");
    });

    $("a").each(function () {
        if ($(this).prop("href") === window.location.href) {
            $(this).addClass("current");
        }
    });

    $(document).ajaxError(function (event, jqXHR, settings, thrownError) {
        let status = jqXHR.status;

        if (status >= 400 && status < 500) {
            // Backend must supply a "error" parameter in the JSON in case of bad requests
            try {
                let json = jqXHR.responseJSON;
                alert(json.error);
            } catch (error) {
                console.log("Failed to show proper popup to the user: " + error);
            }
        } else if (status >= 500 && status < 600) {
            alert("Internal server error. Please contact the site owner.");
        }
    });

    $(document).ajaxComplete((event, jqXHR, ajaxOptions) => console.log(jqXHR));
    $(document).ajaxSend((event, jqXHR, ajaxOptions) => console.log(jqXHR));
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
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2)).toString() + "/";
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