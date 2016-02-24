$(document).ready(function() {
    $("body").keydown(function(e) {
        if (e.which === 37) {
            $("#plot_left").trigger("click");
        } else if (e.which === 39) {
            $("#plot_right").trigger("click");
        }
     });
});
