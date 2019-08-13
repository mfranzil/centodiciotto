$("document").ready(function () {
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
        if ($("#nav-logo-container").attr("aria-expanded") == "false") {
            $("#nav-log").detach().appendTo('#log-menu-open');
            $("#log-menu-closed").hide();
        }
        $("#logo").toggleClass("navbar-logo-animate");
    });


    $(function(){
        $('a').each(function() {
            if ($(this).prop('href') == window.location.href) {
                $(this).addClass('current');
            }
        });
    });
});