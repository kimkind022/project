let txt = document.getElementsByClassName("text");
let span = document.getElementsByTagName("span");
let agree = document.getElementsByClassName("checkb");
let errorTxt = document.getElementsByClassName("errorTxt");

let idCheck = false;
let nicknameCheck = false;

let pwCheck = false;
let nameCheck = false;
let birthdayCheck = false;
let telCheck = false;
let addressCheck = false;
let agreeCheck = false;

$(document).ready(function() {

  // 이메일좌측입력체크
  $(document).on('keyup', 'input[name=id]', function() {
    idCheck = false;
    let id = $('input[name=id]').val();
    $('.emailSelect > select').val("0");
    if (id == "") {
      errorTxt[0].innerHTML = ("이메일을 입력해주세요.");
    } else {
      errorTxt[0].innerHTML = ("이메일 도메인을 입력해주세요.");
    }
  });

  // 이메일선택체크
  $('.emailSelect > select').change(function() {
    idCheck = false;
    $('input[name=emailSelect]').val($(this).val());
    if ($(this).val() == "") {
      $(this).hide();
    }

    if ($(this).val() == "0" | $(this).val() == "") {
      errorTxt[0].innerHTML = ("이메일 도메인을 입력해주세요.");
    } else {
      errorTxt[0].innerHTML = ("이메일 중복확인을 진행해주세요.");
    }
  });

  // 이메일직접입력체크
  $('input[name=emailSelect]').keyup(function() {
    idCheck = false;
    if ($(this).val() == "") {
      errorTxt[0].innerHTML = ("이메일 도메인을 입력해주세요.");
    } else {
      errorTxt[0].innerHTML = ("이메일 중복확인을 진행해주세요.");
    }

  });

  // 직접입력취소
  $('.directInput > div:last-child').click(function() {
    idCheck = false;
    $('.directInput > div:nth-child(1) > input').val("");
    $('.emailSelect > select').val("0");
    $('.emailSelect > select').show();
    errorTxt[0].innerHTML = ("이메일 도메인을 입력해주세요.");
  });

  // 이메일 중복확인체크
  $(document).on('click', 'input[name=emailSearch]', function() {
    idCheck = false;
    let reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
    let id = $('input[name=id]').val() + "@" + $('input[name=emailSelect]').val();

    if (errorTxt[0].innerHTML != "필수 정보입니다." & errorTxt[0].innerHTML != "올바른 이메일 형식이 아닙니다.") {
      errorTxt[0].innerHTML = ("이메일 중복확인을 진행해주세요.");
    }

    if ($('input[name=id]').val() == "") {
      errorTxt[0].innerHTML = ("올바른 이메일 형식이 아닙니다.");
    } else if (!reg_email.test(id)) {
      errorTxt[0].innerHTML = ("올바른 이메일 형식이 아닙니다.");
    } else {
      $.ajax({
        url : "selectId.jsp?id=" + id,
        dataType : "html",
        success : function(data) {
          idCheck = true;
          errorTxt[0].innerHTML = (data);
        },
        error : function() {
          alert("fail");
        }
      });
    }
  });

  // 비밀번호 체크
  $('input[name=pw]').keyup(function() {
    pwCheck = false;
    let pw = $('input[name=pw]').val();
    let num = pw.search(/[0-9]/g);
    let eng = pw.search(/[a-z]/ig);
    let spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

    $('input[name=pwRe]').val("");
    $('input[name=pwRe]').css('backgroundColor', '#EAEAEA');
    errorTxt[2].innerHTML = ("");

    if (pw == "") {
      errorTxt[1].innerHTML = ("영문,숫자,특수문자를 혼합하여 8~12글자 사이로 비밀번호를 입력해 주세요.");
      $('input[name=pwRe]').attr('readonly', 'readonly');
    } else if (pw.length < 8 || pw.length > 12) {
      errorTxt[1].innerHTML = ("영문,숫자,특수문자를 혼합하여 8~12글자 사이로 비밀번호를 입력해 주세요.");
      $('input[name=pwRe]').attr('readonly', 'readonly');
    } else if (num < 0 || eng < 0 || spe < 0) {
      errorTxt[1].innerHTML = ("영문,숫자,특수문자를 혼합하여 8~12글자 사이로 비밀번호를 입력해 주세요.");
      $('input[name=pwRe]').attr('readonly', 'readonly');
    } else {
      errorTxt[1].innerHTML = ("비밀번호 확인을 입력해주세요.");
      $('input[name=pwRe]').removeAttr('readonly');
      $('input[name=pwRe]').css('backgroundColor', 'white');
    }

  });

  // 비밀번호확인 체크
  $('input[name=pwRe]').keyup(function() {
    pwCheck = false;
    let pw = $('input[name=pw]').val();
    let pwRe = $('input[name=pwRe]').val();

    if (pw == pwRe && pwRe != '') {
      pwCheck = true;
      errorTxt[1].innerHTML = ("");
      errorTxt[2].innerHTML = ("<font color='green'>비밀번호 확인 완료!</font>");
    } else if (pwRe == '') {
      errorTxt[1].innerHTML = ("비밀번호 확인을 입력해주세요.");
      errorTxt[2].innerHTML = ("");
    } else {
      errorTxt[1].innerHTML = ("");
      errorTxt[2].innerHTML = ("비밀번호가 일치하지 않습니다.");
    }
  });

  // 이름체크
  $('input[name=name]').keyup(function() { // 이름 한글만 입력 가능
    nameCheck = false;
    let pattern = /([^가-힣\x20])/i;

    let name = $('input[name=name]').val();

    if (name == '') {
      errorTxt[3].innerHTML = ("이름을 입력해주세요.");
    } else if (pattern.test(name)) { // 영어 또는 특수문자 포함 시 해당 문자 없애기
      errorTxt[3].innerHTML = ("이름은 한글만 입력가능 합니다.");
    } else {
      nameCheck = true;
      errorTxt[3].innerHTML = ("");
    }
  });

  // 닉네임입력체크
  $('input[name=nickname]').keyup(function() {
    nicknameCheck = false;
    let nickname = $('input[name=nickname]').val();
    if (id == "") {
      errorTxt[4].innerHTML = ("닉네임을 입력해주세요.");
    } else {
      errorTxt[4].innerHTML = ("닉네임 중복확인을 진행해주세요.");
    }
  });

  // 닉네임 중복확인 체크
  $('input[name=nickSearch]').click(function() { // 버튼 클릭 시 작동
    nicknameCheck = false;
    pattern = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
    let nickname = $('input[name=nickname]').val();

    if (nickname == "") {
      errorTxt[4].innerHTML = ("닉네임을 입력해주세요.")
    } else if (pattern.test(nickname)) {
      errorTxt[4].innerHTML = ("닉네임은 특수문자를 제외하고 입력해주세요.");
      $(this).val(nickname.replace(pattern, ''));
    } else {
      $.ajax({
        url : "selectNick.jsp?nickname=" + nickname,
        dataType : "html",
        success : function(data) {
          nicknameCheck = true;
          errorTxt[4].innerHTML = (data);
        },
        error : function() {
          alert("fail");
        }
      });
    }
  });

  // 생년체크
  $('input[name=year]').keyup(function() {
    birthday = false;
    let year = $('input[name=year]').val();

    $('select[name=month]').val("0");
    $('select[name=month]').css('backgroundColor', '#EAEAEA');
    $('input[name=day]').val("");
    $('input[name=day]').css('backgroundColor', '#EAEAEA');

    let today = new Date(); // 날짜 변수 선언
    let yearNow = today.getFullYear();

    if ((yearNow - year) > 100 || year > yearNow) {
      errorTxt[5].innerHTML = ('정말요?');
    } else {
      errorTxt[5].innerHTML = ('태어난 월을 선택해주세요.');
      $('select[name=month]').removeAttr('disabled');
      $('select[name=month]').css('backgroundColor', 'white');
    }

  });

  // 생월체크
  $('select[name=month]').change(function() {
    birthdayCheck = false;
    let month = $('select[name=month]').val();

    $('input[name=day]').val("");
    $('input[name=day]').css('backgroundColor', '#EAEAEA');

    if (month < 1 || month > 12) {
      errorTxt[5].innerHTML = ('태어난 월을 선택해주세요.');

    } else {
      errorTxt[5].innerHTML = ('태어난 일을 입력해주세요.');
      $('input[name=day]').removeAttr('readonly');
      $('input[name=day]').css('backgroundColor', 'white');
    }

  });

  // 생일체크
  $('input[name=day]').keyup(function() {
    birthdayCheck = false;
    let year = $('input[name=year]').val();
    let month = $('select[name=month]').val();
    let day = $('input[name=day]').val();

    if (day < 1 || day > 31) {
      errorTxt[5].innerHTML = ('생년월일을 확인해주세요.');

    } else if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) { // 4,6,9,11월
      // +
      // 31일이상
      // 불가능
      errorTxt[5].innerHTML = ('생년월일을 확인해주세요.');

    } else if (month == 2) {
      let isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)); // 윤년
      if (day > 29 || (day == 29 && !isleap)) {
        errorTxt[5].innerHTML = ('생년월일을 확인해주세요.');
      } else {
        birthdayCheck = true;
        errorTxt[5].innerHTML = ('');
      }

    } else {
      birthdayCheck = true;
      errorTxt[5].innerHTML = ('');
    }

  });

  /*
   * 현재연도-출생연도=100 >> 진짜요? 1,3,5,7,8,10,12 >> 31일 2> 29일 2,4,6,9,11 >> 30일
   */

  $('input[name=tel]').keyup(function() {
    telCheck = false;
    let telPattern = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
    let tel = $('input[name=tel]').val();

    if (tel == "") {
      errorTxt[6].innerHTML = ('휴대폰 번호를 입력해주세요');
    } else if (!telPattern.test(tel)) {
      errorTxt[6].innerHTML = ('휴대폰 번호는 11자리 숫자로 입력해주세요.');
    } else {
      telCheck = true;
      errorTxt[6].innerHTML = ('');
    }
  });

  $('input[name=addressInfo]').keyup(function() {
    addressCheck = false;
    let addressInfo = $('input[name=addressInfo]').val();

    if (addressInfo == "") {
      errorTxt[7].innerHTML = "상세주소를 입력해주세요";
    } else {
      addressCheck = true;
      errorTxt[7].innerHTML = "";
    }
  });

});

// 동의체크
function checkAll(agreeValue) {
  agreeCheck = false;
  if (agreeValue == agree[0]) {
    for (i = 1; i <= 5; i++) {
      agree[i].checked = agree[0].checked;
    }
  } else if (agreeValue == agree[1]) {
    if (agreeValue.checked != agree[2].checked) {
      agree[0].checked = false;
    } else {
      agree[0].checked = agreeValue.checked;
    }
  } else if (agreeValue == agree[2]) {
    for (i = 3; i <= 5; i++) {
      agree[i].checked = agree[2].checked;
    }
    if (agreeValue.checked != agree[1].checked) {
      agree[0].checked = false;
    } else {
      agree[0].checked = agreeValue.checked;
    }
  } else {
    if (agreeValue.checked == agree[3].checked) {
      if (agreeValue.checked == agree[4].checked) {
        if (agreeValue.checked == agree[5].checked) {
          agree[2].checked = agreeValue.checked;
          if (agree[2].checked != agree[1].checked) {
            agree[0].checked = false;
          } else {
            agree[0].checked = agree[2].checked;
          }
          return true;
        }
      }
    }
    agree[2].checked = false;
    agree[0].checked = false;
  }
  agreeCheck = agree[1].checked;
}

function joinClick() {
  if (idCheck == false) {
    alert("아이디 중복확인을 진행해주세요");
    return false;
  } else if (nicknameCheck == false) {
    alert("닉네임 중복확인을 진행해주세요");
    return false;
  } else {
    let idOverlap = document.getElementsByName("idOverlap")[0];
    let nicknameOverlap = document.getElementsByName("nickname")[0];

    if (idOverlap.value != "true") {
      alert("아이디를 확인해주세요");
      return false;
    } else if (!pwCheck) {
      alert("비밀번호를 확인해주세요");
      return false;
    } else if (!nameCheck) {
      alert("이름을 확인해주세요");
      return false;
    } else if (idOverlap.value != "true") {
      alert("닉네임을 확인해주세요");
      return false;
    } else if (!birthdayCheck) {
      alert("생년월일을 확인해주세요");
      return false;
    } else if (!telCheck) {
      alert("연락처를 확인해주세요");
      return false;
    } else if (!addressCheck) {
      alert("주소를 확인해주세요");
      return false;
    } else if (!agreeCheck) {
      alert("필수 동의사항을 확인해주세요");
      return false;
    }
  }
  return true;
}

window.history.forward();
function noBack() {
  window.history.forward();
}
