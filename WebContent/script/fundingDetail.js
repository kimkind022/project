let isproceeding = $('input[name=isproceeding]').val();

$(document).ready(function() {
  
  if (isLogin()) {
  } else {
    $('textarea[name=replyContents]').attr('placeholder', '로그인 후 작성 가능합니다');
    $('textarea[name=replyContents]').attr('readonly', 'readonly');
  }

  $('.rewardsSummary').mouseenter(function() {
    $(this).find('p').toggleClass('displayNone');
    $(this).css('border','0');
  });
  $('.rewardsSummary').mouseleave(function() {
    $(this).find('p').toggleClass('displayNone');
    $(this).css('border','1px solid black');
  });
  $('.rewardsSummary').click(function() {
    let selectedOption = $('.rewardChoose option[class=' + $(this).attr('id') + ']');
    let selectedId = selectedOption.val();
    
    if (isproceeding != 'true') {
      alert("마감된 펀딩입니다.");
    } else if (!isLogin()) {
      alert("로그인 후 가능 합니다");
    } else if (selectedOption.attr('value4') == '0') {
      alert("남은 수량이 없습니다");
    } else if ($('#optionNum' + selectedId).length > 0) {
      alert("이미 선택한 리워드 입니다");
    } else {
      addReward(selectedOption);

      $('html, body').animate({scrollTop: $('body').offset().top}, 400);
    }
    $(this).val("0");
    totalPrice();

  });

  $(document).on('change', '.rewardChoose', function() {
    let selectedOption = $(this).find('option:selected');
    let selectedId = selectedOption.val();
    
    if (isproceeding != 'true') {
      alert("마감된 펀딩입니다.");
    } else if (selectedOption.attr('value4') == '0') {
      alert("남은 수량이 없습니다");
    } else if ($('#optionNum' + selectedId).length > 0) {
      alert("이미 선택한 리워드 입니다");
    } else {
      addReward(selectedOption);
    }
    $(this).val("0");
    totalPrice();
  });

  $(document).on('blur', '.rewardCount', function() {
    let count = $(this).val();
    let stock = $(this).closest('.selectedReward li').find('.price').attr('value2');
    let cost = minusComma($(this).closest('.selectedReward li').find('.price').val());
    if ((count < 1) || (count > parseInt(stock))) {
      $(this).val('1');
      count = $(this).val();
    }
    $(this).closest('.selectedReward li').find('.totalPrice').text(addComma(parseInt(count || 0) * parseInt(cost || 0)));
    totalPrice();
  });

  $(document).on('click', 'input[name=x]', function() {
    $(this).closest('.selectedReward li').remove();
    totalPrice();
    if ($('.selectedReward li')) {
      $('.allRewardCost').css('visibility', 'hidden');
    }
  });

  $(document).on('click', '.like', function() {
    if (isLogin()) {
      $.ajax({
        url : "fundingheartstoggle.fd",
        dataType : "html",
        data : {
          "postId" : $('input[name=fundingId]').val()
        },
        success : function(data) {
          $('.like').html(data);
        },
        error : function() {
          alert("fail");
        }
      });
    } else {
      alert("로그인이 필요합니다.");
    }
  });

  $(document).on('click', 'input[name=replyWrite]', function() {
    if (!isLogin()) {
      alert("로그인이 필요합니다.");
    } else {
      let replyContents = $('textarea[name=replyContents]').val();
      if (replyContents.length == 0 || replyContents == '') {
        alert("내용을 입력해주세요");
      } else {
        $.ajax({
          url : "fundingReplyWrite.fd",
          dataType : "html",
          data : {
            "fundingId" : $('input[name=fundingId]').val(),
            "contents" : $('textarea[name=replyContents]').val()
          },
          success : function(data) {
            $('.replysDIv').html(data);
            $('textarea[name=replyContents]').val("");
          },
          error : function() {
            alert("fail");
          }
        });
      }
    }
  });

  $('.postNav li').click(function() {
    let moveNum = $(this).index();
    $('html, body').animate({

      scrollTop : $('.postContents >div').eq(moveNum).offset().top
    }, 400);
  });
  
  $(window).on('scroll', function() {
    $('.postContents > div').each(function(){
      if (checkVisible($(this))) {
        let navNum = $(this).index();
        $('.postNav li').css('border-bottom', '0');
        $('.postNav li').eq(navNum).css('border-bottom', '2px solid rgb(240, 93, 35)');
      }

    });
  });
  
  
  
});

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

function addReward(selectedOption) {
  let selectedId = selectedOption.val();
  $('.allRewardCost').css('visibility', 'visible');
  $('.selectedReward').append(
          "<li id=optionNum" + selectedOption.val() + " >"
              + "<div><label>리워드 명 : </label>" + selectedOption.attr('value2') + "</div>"
              + "<input type=hidden name=optionId value=" + selectedOption.val() + ">"
              + "<input type=hidden name=price value=" + selectedOption.attr('value3') + ">"
              + "<div><label>수량 : </label><input type=number class=rewardCount name=rewardCount value=1> <label>개</label> </div>"
              + "<input type=hidden class=price value=" + selectedOption.attr('value3') 
              + " value2=" + selectedOption.attr('value4') + ">" 
              + "<div><label>금액 : </label><label class=totalPrice> "+selectedOption.attr('value3')
              + "</label><label>원</label></div>" + "<input type=button name=x value=x>"
              + "</li>");
}

function totalPrice() {
  let sum = 0;
  $('.totalPrice').each(function() {
    sum += parseInt(minusComma($(this).text()));
  });
  $('.allRewardCost #totalPriceDisplay').text(addComma(sum));
}

function submitCheck() {
  if (isproceeding != "true") {
    alert("마감된 펀딩입니다.");
    return false;
  } else if (!isLogin()) {
    alert("로그인이 필요합니다.");
    return false;
  } else if ($('.allRewardCost #totalPriceDisplay').text() == "0") {
    alert("선택된 리워드가 없습니다");
    return false;
  }
   
  return true;
}

function isLogin() {
  let login = $('input[name=isLogin]').attr('value');
  if (login != 'true') {
    return false;
  }
  return true;
}

function addComma(value){
  value = String(value);
  return value.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function minusComma(value){
  value = String(value);
  return value.replace(/[^\d]+/g, '');
}