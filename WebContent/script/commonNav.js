$(document).ready(function(){
  $('.quickIcon1').click(function(){
    $('html, body').animate({
      scrollTop : $('body').offset().top
    }, 400);
  });
  
  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 200) {
      $('.commonNav').removeClass('displayNone');
    } else {
      $('.commonNav').addClass('displayNone');
    }
  });
});