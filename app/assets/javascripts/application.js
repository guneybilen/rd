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

function updatePosts () {
//  var article_id = $("#article").attr("data-id");
  if ($(".polls").length > 0) {
    var after = $(".polls").attr("data-time");
  } else {
    var after = "0";
  }
  $.getScript("/polls.js?after=" + after);
  setTimeout("updatePosts()", 50000);
}


$( document ).ready(function() {

    if ($(".posts").length > 0) {
        setTimeout(updatePosts, 50000);
    }

    $(document).delegate(".comment_form_reply_link", "click", function(e){
//    $(".comment_form_reply_link").live('click', function(e){

        $(this).addClass("clicked_link");
        var link = $(this).attr("id");
        var text_box = $(this).next('.comment_form');

        $(".comment_form:eq(" + link + ") > .comment").addClass('batin');

        $(".comment_form:eq(" + link + ")")
                            .append("<span class='span_comment'><img src='assets/loader.gif' class='loader'/></span>");
        $(".loader").hide();
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
    $('password_resets_text_field_tag').html('');

    // hide it first
    $(".loader").hide();

    // document keyword must be there otherwise ajaxStart does not work
    // when an ajax request starts, show spinner

    $(".batin").show();

///////////////////////////////////////////////////////////////////////////////
// ajaxStart() ve ajaxStop() is replaced with the delegate() method below
    $(document).delegate('.batin', 'click', function(){
        $(".batin").hide();
        $(".loader").show();
    });

///////////////////////////////////////////////////////////////////////////////
// ajaxStart() ve ajaxStop() creates problem in the project.
//    $(document).ajaxStart(function(){
//
//        $(".batin").hide();
//        $(".loader").show();
//  //          $(".span_comment").replaceWith($(".loader").show());
//
//    });
    // document keyword must be there otherwise ajaxStop does not work
    // when an ajax request complets, hide spinner
//    $(document).ajaxStop(function(){
//
//        $(".batin").show();
//    });

     $('#search_posts_form_text_field').tokenInput("/posts/posts_search_autocomplete",
        {
            theme: "facebook",
            tokenLimit:1,
            minChars: 2,
            resultsLimit: 10,
            hintText: "Please type in the search term...",
            noResultsText: "No results have been found...",
            searchingText: "We're searching...",
            preventDuplicates: true,
            propertyToSearch: "post",
            resultsFormatter: function(item){
              return "<li>"  +
              item.post  + "," + "<span style='padding-left: 10px'>"+ item.name + "</span>" + "</li>"
          }
        }
    );

    $("#token-input-search_posts_form_text_field").val("Search Posts...");


    $("#token-input-search_posts_form_text_field").focus(function () {

       $(this).css("width", "300px");
       $(this).val("");
    });

    $("#token-input-search_posts_form_text_field").keyup(function () {

       $(this).css("width", "300px");

    });

    $("#token-input-search_posts_form_text_field").blur(function () {

       $(this).css("width", "300px");
       $(this).val("Search Posts...");

    });


    $('#search_users_form_text_field').tokenInput("/users/users_search_autocomplete",
        {
            theme: "facebook",
            tokenLimit:1,
            minChars: 2,
            resultsLimit: 10,
            hintText: "Please type in the search term...",
            noResultsText: "No results have been found...",
            searchingText: "We're searching...",
            preventDuplicates: false,
            propertyToSearch: "name",
            resultsFormatter: function(item){
              return "<li>"  + item.name + "</li>"
          }
        }
    );


    $("#token-input-search_users_form_text_field").val("Search Users...");

    $("#token-input-search_users_form_text_field").focus(function () {

       $(this).css("width", "300px");
       $(this).val("");
    });

    $("#token-input-search_users_form_text_field").keyup(function () {

       $(this).css("width", "300px");

    });

    $("#token-input-search_users_form_text_field").blur(function () {

       $(this).css("width", "300px");
       $(this).val("Search Users...");

    });


    $("#forgot_my_password").click ( function () {
        $('#password_reset').slideDown();
    });

    $("#cancel_password_reset").click ( function () {
        $('#password_reset').slideUp();
    });

});