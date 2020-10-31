/*!
    * Start Bootstrap - Resume v6.0.1 (https://startbootstrap.com/template-overviews/resume)
    * Copyright 2013-2020 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-resume/blob/master/LICENSE)
    */
    (function ($) {
    "use strict"; // Start of use strict

    // Smooth scrolling using jQuery easing
    $('a.js-scroll-trigger[href*="#"]:not([href="#"])').click(function () {
        if (
            location.pathname.replace(/^\//, "") ==
                this.pathname.replace(/^\//, "") &&
            location.hostname == this.hostname
        ) {
            var target = $(this.hash);
            target = target.length
                ? target
                : $("[name=" + this.hash.slice(1) + "]");
            if (target.length) {
                $("html, body").animate(
                    {
                        scrollTop: target.offset().top,
                    },
                    1000,
                    "easeInOutExpo"
                );
                return false;
            }
        }
    });

    // Closes responsive menu when a scroll trigger link is clicked
    $(".js-scroll-trigger").click(function () {
        $(".navbar-collapse").collapse("hide");
    });

    // Activate scrollspy to add active class to navbar items on scroll
    $("body").scrollspy({
        target: "#sideNav",
    });
})(jQuery); // End of use strict

function show_create_profile(){
    document.getElementById('create_profile').style.display = "block";
    document.getElementById('login_content').style.display = "none";
}

function hide_create_profile(){
    document.getElementById('create_profile').style.display = "none";
    document.getElementById('login_content').style.display = "block";
}

function show_lot_number(){
    document.getElementById('appln_id_row').style.display = "none";
    document.getElementById('lot_number_row').style.display = "block";
    document.getElementById('appln_id_btn').style.display = "block";
    document.getElementById('lot_number_btn').style.display = "none";
}

function hide_lot_number(){
    document.getElementById('appln_id_row').style.display = "block";
    document.getElementById('lot_number_row').style.display = "none";
    document.getElementById('appln_id_btn').style.display = "none";
    document.getElementById('lot_number_btn').style.display = "block";
}

$(document).ready(function(){
    hide_create_profile();
    hide_lot_number();
})