$("document").ready(function () {
    $(".popup-opener").click(function () {
        $(this).next().show();
    });
    $(".popup-closer").click(function () {
        $(".popup_window").hide();
    });
    $(".popup_window").click(function (e) {
        if ($(".popup_window").is(e.target)) {
            $(".popup_window").hide();
        }
    });
});