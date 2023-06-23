$(document).ready(function() {
  var article = (".show");
  $(".item  td").click(function() {
    var myArticle = $(this).parents().next("tr");
    if ($(myArticle).hasClass('hide')) {
      $(article).removeClass('show').addClass('hide');
      $(myArticle).removeClass('hide').addClass('show');

      $(".focusRow").removeClass('focusRow');
      $(this).parent().addClass('focusRow');

    } else {
      $(myArticle).addClass('hide').removeClass('show');
    }
  });

  $('input[name=write]').click(function() {
    if ($('input[name=isLogin]').val() == "false") {
      alert("로그인이 필요합니다.");
    } else {
      location.href = 'inquiryWriteFrom.fd';
    }
  });

});