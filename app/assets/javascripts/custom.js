$(document).on ("turbolinks:load", function(){
  $('#nav-toggle').click(function(e) {
    $('.main-nav').toggleClass('is-open');
    $('.hamburger').toggleClass('is-open');
    $('body').toggleClass('fixed');
    $('#menu-app-slide').toggleClass('slider');
    console.log("test");
  });
})
