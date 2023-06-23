function checkVisible(elm, eval) {
  eval = eval || "object visible";
  var viewportHeight = $(window).height(), // Viewport Height
  scrolltop = $(window).scrollTop(), // Scroll Top
  y = $(elm).offset().top, elementHeight = $(elm).height();

  if (eval == "object visible")
    return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
  if (eval == "above")
    return ((y < (viewportHeight + scrolltop)));
}

$(document).ready(function() {
  $('.fade').slick({
    arrows : false,
    dots : false,
    infinite : true,
    speed : 700,
    fade : true,
    cssEase : 'linear',
    autoplay : true,
    autoplaySpeed : 1200
  });

  $('.multiple-items1').slick({
    arrows : false,
    dots : false,
    infinite : true,
    autoplay : true,
    autoplaySpeed : 2600,
    speed : 600,
    slidesToShow : 3,
    slidesToScroll : 3
  });
  $('.multiple-items2').delay(10000).slick({
    arrows : false,
    dots : false,
    infinite : true,
    autoplay : true,
    autoplaySpeed : 4300,
    speed : 600,
    slidesToShow : 3,
    slidesToScroll : 3
  });

  $('.multiple-items3').delay(5000).slick({
    arrows : false,
    dots : false,
    infinite : true,
    autoplay : true,
    autoplaySpeed : 5800,
    speed : 600,
    slidesToShow : 3,
    slidesToScroll : 3
  });

  $('#memberamount li > div:nth-child(1)').each(function() {
    $(this).prop('Counter', 0).animate({
      Counter : $(this).text()
    }, {
      duration : 1000,
      easing : 'swing',
      step : function(now) {
        $(this).text(Math.ceil(now));
      }
    });
  });

  $(window).on('scroll', function() {
    if (checkVisible($('#ment'))) {
      $('#ment > .p1').addClass('mentFadeOut');
      $('#ment > .p1').css('opacity', '1');
      $('#ment > .p2').addClass('mentFadeOut2');
      $('#ment > .p2').css('opacity', '1');
    } else {
      $('#ment > .p1').removeClass('mentFadeOut');
      $('#ment > .p1').css('opacity', '0');
      $('#ment > .p2').removeClass('mentFadeOut2');
      $('#ment > .p2').css('opacity', '0');
    }
  });

  $('#section2 > div').mouseenter(function() {
    $(this).find('.overlap3').stop().fadeIn(300); // 페이드이미지 보임
    $(this).find('.overlap2').stop().hide(); // 기존이미지-타이틀+텍스트 사라짐
    $(this).find('.overlap4 > div:nth-child(1)').stop().addClass('midFade'); // 페이드이미지>타이틀
    // 올라옴
    $(this).find('.overlap4 > div:nth-child(1)').stop().css('opacity', '1'); // 페이드이미지>타이틀
    // 보임
    $(this).find('.overlap4 > div:nth-child(2)').stop().fadeIn(100); // 페이드이미지
    // >텍스트 보임
  });
  $('#section2 > div').mouseleave(function() {
    $(this).find('.overlap3').stop().fadeOut(300);
    $(this).find('.overlap2').stop().show();
    $(this).find('.overlap4 > div:nth-child(1)').stop().removeClass('midFade');
    $(this).find('.overlap4 > div:nth-child(1)').stop().css('opacity', '0');
    $(this).find('.overlap4 > div:nth-child(2)').stop().fadeOut(100);
  });

});
