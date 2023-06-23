$(document).ready(function() {
  $('.fade').slick({
    arrows : false,
    dots : false,
    infinite : true,
    speed : 700,
    fade : true,
    cssEase : 'linear',
    autoplay : true,
    autoplaySpeed : 2000
  });
  $('.multiple-items').slick({
    arrows : true,
    dots : false,
    infinite : true,
    slidesToShow : 3,
    slidesToScroll : 3
  });
  $('.allShow').click(function(){
    let value=$(this).attr('id');
    location.href = 'fundingList.fd?status2='+value;
  });
});