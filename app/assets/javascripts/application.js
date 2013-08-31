// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$( document ).ready(function() {
    $(".comment_form_reply_link").on('click', function(e){

        var link = $(this).attr("id");
        var text_box = $(this).next('.comment_form');

        $(".comment_form:eq(" + link + ")")
            .animate({height: ["toggle", "swing"]}, "slow");

        // .scrollTo() is a function of  flesler/jquery.scrollTo plugin
        $('html').scrollTo( $(".comment_form:eq(" + link + ")"), 500, { offset:{ top:-150,left:0}});

// things to keep in mind:
// .animate({scrollTop: $(".comment_form:eq(" + link + ")").offset().top -100 }, 'slow');
// if ( $(this).is(':visible'))
// console.log('executed scrollToElement');


        $(".comment_form:gt(" + link + ")").css("display", "none");     // two forms of css parameters
        $(".comment_form:lt(" + link + ")").css({"display" : "none"});  // taken from jQuery docs

              e.preventDefault();
});

    $('.text_area_in_comment_form').html('');
});