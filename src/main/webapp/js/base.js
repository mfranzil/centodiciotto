/**
 * Base JS document used in all JSPs.
 */

/**
 * Enables popup button openers once the page has been loaded up.
 */
function enablePopup() {
    $(this).on();
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

/**
 * Returns the current Tomcat context path (same behavior as Java HttpServletRequest#getContextPath()).
 *
 * @returns {string} the current Tomcat context path
 */
function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2)).toString() + "/";
}

/**
 * Returns the current User's display name for navbar visualization.
 * @param role the role of the user
 * @returns {string} the displayed name
 */
function getNameFromID(role) {
    switch (role) {
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

/**
 * Animates a three-dot ellipsis "..." every 600 milliseconds
 */
$.fn.startEllipsis = function () {
    let jqItem = $(this);
    jqItem.attr("dots", 0);
    jqItem.attr("originalHTML", jqItem.html());
    jqItem.attr("interval", setInterval(() => {
            if (parseInt(jqItem.attr("dots")) < 3) {
                jqItem.append('.');
                jqItem.attr("dots", parseInt(jqItem.attr("dots")) + 1);
            } else {
                jqItem.html(jqItem.attr("originalHTML"));
                jqItem.attr("dots", 0);
            }
        }, 600)
    );
    return this;
};

$.fn.stopEllipsis = function () {
    try {
        clearInterval($(this).attr("interval"));
    } catch (error) {
        console.log("No interval to clear.");
    }
    return this;
};

$("document").ready(() => {
    enablePopup();

    /**
     * Enables responsive behavior (globally set to <= 992px). Primarily affects the navbar.
     */
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

    /**
     * Opens the navbar with an animation on mobile devices
     */
    $("#nav-logo-container").click(() => {
        if ($("#nav-logo-container").attr("aria-expanded") === "false") {
            $("#nav-log").detach().appendTo("#log-menu-open");
            $("#log-menu-closed").hide();
        }
        $("#logo").toggleClass("navbar-logo-animate");
    });

    /**
     * Closes the navbar if the user clicks elsewhere.
     */
    $(document).mouseup(function (e) {
        let container = $(".navbar");
        let nav = $("#nav-logo-container");

        if (nav.attr("aria-expanded") !== "false") {
            // Checks if the target is or is contained in the navbar
            if (!container.is(e.target) && container.has(e.target).length === 0) {
                nav.click();
            }
        }
    });

    /**
     * Highlights links pointing to current page.
     */
    $("a").each(function () {
        if ($(this).prop("href") === window.location.href) {
            $(this).addClass("current");
        }
    });

    /**
     * Serves a popup to the user in case of failed AJAX requests.
     */
    $(document).ajaxError((event, jqXHR, settings, thrownError) => {
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
});