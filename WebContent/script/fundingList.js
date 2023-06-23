$(document).ready(function() {
  let status = $('input[name=statusValue]').val();
  let status2 = $('input[name=status2Value]').val();
  let status3 = $('input[name=status3Value]').val();

  $('.postCount').text($('.fundingPost').length);

  $('select[name=status] option').each(function() {
    if ($(this).val() == status) {
      $(this).attr('selected', 'selected');
    }
  });
  $('select[name=status2] option').each(function() {
    if ($(this).val() == status2) {
      $(this).attr('selected', 'selected');
    }
  });
  $('.iconDiv').each(function() {
    if($(this).attr('id') == status3){
      $(this).css('border','2px solid rgb(240, 93, 35)');
    }
  });

  $(document).on('change', 'select[name=status]', function() {
    location.href = 'fundingList.fd?status=' + $(this).find('option:selected').val() + "&status2=" + status2 + "&status3=" + status3;
  });
  $(document).on('change', 'select[name=status2]', function() {
    location.href = 'fundingList.fd?status=' + status + "&status2=" + $(this).find('option:selected').val() + "&status3=" + status3;
  });

  $(document).on('click', '.iconDiv', function() {
    let category = $(this).attr('id');
    location.href = 'fundingList.fd?status=' + status + "&status2=" + status2+"&status3="+category;
  });

  $('input[name=write]').click(function() {
    if (isLogin()) {
      location.href = 'fundingWriteForm.fd';
    } else {
      alert("로그인이 필요합니다.");
    }
  });

  $(document).on('click', 'button[class=listAdd]', function() {
    let nowPage = parseInt($('input[name=nowPage]').val() || 0);
    $('input[name=nowPage]').val(nowPage + 1);
    nowPage = parseInt($('input[name=nowPage]').val() || 1);
    let postCount = parseInt($('.postCount').text() || 0);
    let listCount = parseInt($('.listCount').text() || 0);

    if (postCount < listCount) {
      $.ajax({
        url : "fundingList.fd",
        dataType : "html",
        data : {
          "page" : nowPage,
          "status" : status,
          "status2" : status2
        },
        success : function(data) {
          $('.postList').append($(data).find('.postList').html());
          $('.postCount').text($('.fundingPost').length);
          $('.listCount').html($(data).find('.listCount').html());
        },
        error : function() {
          alert("fail");
        }
      });
    } else {
      $('input[name=nowPage]').val(nowPage - 1);
    }
  });

  $('.quickIcon1').click(function() {
    $('html, body').animate({
      scrollTop : $('body').offset().top
    }, 400);
  });

});

function isLogin() {
  if ($('input[name=isLogin]').val() == "false") {
    return false;
  }
  return true;
}