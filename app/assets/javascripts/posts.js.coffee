# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  if $('.posts_page').length
    $(window).scroll ->
      url = $('.pagination .next_page > a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 250

        $('.pagination').text("Fetching more posts...").delay(2000).fadeOut('slow');

        $.getScript(url)

    $(window).scroll()
