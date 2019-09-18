$("document").ready(function () {
    $(".popup-opener").click(function () {
        $(this).next().show();
    });
    $(".popup-closer").click(function () {
        e.preventDefault();
        $(".popup-window").hide();
    });
    $(".popup-window").click(function (e) {
        if ($(this).is(e.target)) {
            $(this).hide();
        }
    });
});