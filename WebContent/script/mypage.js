let txt = document.getElementsByClassName("text");
let span = document.getElementsByTagName("span");
let agree = document.getElementsByClassName("checkb");
let errorTxt = document.getElementsByClassName("errorTxt");

let nicknameCheck = true;
let nameCheck = true;
let telCheck = true;
let addressCheck = true;
let pwCheck = false;
let profileImgCheck = false;


$(document).ready(function() {

  // 이름체크
  $('input[name=name]').change(function() { // 이름 한글만 입력 가능
    nameCheck = false;
    pattern = /[가-힣]/g;
    pattern2 = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;

    let name = $('input[name=name]').val();
    if (pattern.test(name)) { // (가~힣)을 포함 시 경고를 없앤다
      nameCheck = true;
      errorTxt[0].innerHTML = ("&nbsp;");
    } else if (pattern2.test(name)) { // 영어 또는 특수문자 포함 시 해당 문자 없애기
      $(this).val(name.replace(pattern2, ''));
      errorTxt[0].innerHTML = ("이름은 한글만 입력가능 합니다.");
      nameCheck = false;
    } else if (name == '') {
      errorTxt[0].innerHTML = ("이름을 입력해주세요.");
      nameCheck = false;
    } else {
      errorTxt[0].innerHTML = ("이름은 한글만 입력가능 합니다.");
      nameCheck = false;
    }
  });

  // 닉네임입력체크
  $('input[name=nickname]').change(function() {
	nicknameCheck = false;
    let nickname = $('input[name=nickname]').val();
    if (id == "") {
      errorTxt[1].innerHTML = ("닉네임을 입력해주세요.");
      nicknameCheck = false;
    } else {
      errorTxt[1].innerHTML = ("닉네임 중복확인을 진행해주세요.");
      nicknameCheck = false;
    }
  });

  // 닉네임 중복확인 체크
  $('input[name=nickSearch]').click(function() { // 버튼 클릭 시 작동
    pattern = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
    let nickname = $('input[name=nickname]').val();

    if (nickname == "") {
      errorTxt[1].innerHTML = ("닉네임을 입력해주세요.")
      nicknameCheck = false;
    } else if (pattern.test(nickname)) {
      errorTxt[1].innerHTML = ("닉네임은 특수문자를 제외하고 입력해주세요.");
      $(this).val(nickname.replace(pattern, ''));
      nicknameCheck = false;
    } else {
      $.ajax({
        url : "selectNick.jsp?nickname=" + nickname,
        dataType : "html",
        success : function(data) {
          nicknameCheck = true;
          errorTxt[1].innerHTML = (data);
        },
        error : function() {
        	nicknameCheck = false;
          alert("fail");
        }
      });
    }
  });

  $('input[name=tel]').change(function() {
    let telPattern = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
    let tel = $('input[name=tel]').val();
    if (tel == "") {
      errorTxt[2].innerHTML = ('휴대폰 번호를 입력해주세요');
      telCheck = false;
    } else if (!telPattern.test(tel)) {
      errorTxt[2].innerHTML = ('휴대폰 번호는 11자리 숫자로 입력해주세요.');
      telCheck = false;
    } else if (tel.length<11) {
        errorTxt[2].innerHTML = ('휴대폰 번호는 11자리 숫자로 입력해주세요.');
        telCheck = false;
        
    } else {
      telCheck = true;
      errorTxt[2].innerHTML = ('&nbsp;');
    }
  });

  $('input[name=addressInfo]').blur(function() {
    let addressInfo = $('input[name=addressInfo]').val();

    if (addressInfo == "") {
      errorTxt[3].innerHTML = "상세주소를 입력해주세요";
      nicknameCheck = false;
    } else {
      addressCheck = true;
      errorTxt[3].innerHTML = "&nbsp;";
    }
  });

  // 프사
	$("input[name=filename]").on("change", function(e){ 
		let f = e.target.files[0];
		if(!f.type.match("image*")){ 
			$("input[name=filename]").val("");
			errorTxt[4].innerHTML="이미지만 첨부할 수 있습니다.";
			profileImgCheck = false;
	    } else {
	    	profileImgCheck = true;
	        errorTxt[4].innerHTML = "&nbsp;";
	      }
		// f.size = 1024*1024*2 --> 2MB
		let reader = new FileReader();
		reader.onload = function(e){
			$(".profilethumbnail img").attr("src", e.target.result); //이미지가 담김
			}
		reader.readAsDataURL(f); // 비동기적으로 실행

	}); 
  
  
	//비밀번호 체크
$('input[name=pw]').change(function() {
	 pwCheck = false;
	 let pw = $('input[name=pw]').val();
	 let num = pw.search(/[0-9]/g);
	 let eng = pw.search(/[a-z]/ig);
	 let spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
	 $('input[name=pwRe]').val("");
	 $('input[name=pwRe]').css('backgroundColor', '#EAEAEA');
	 errorTxt[1].innerHTML = ("");
	
	 if (pw == "") {
	   errorTxt[0].innerHTML = ("영문,숫자,특수문자를 혼합하여 8~12글자 사이로 비밀번호를 입력해 주세요.");
	   $('input[name=pwRe]').attr('readonly', 'readonly');
	 } else if (pw.length < 8 || pw.length > 12) {
	   errorTxt[0].innerHTML = ("영문,숫자,특수문자를 혼합하여 8~12글자 사이로 비밀번호를 입력해 주세요.");
	   $('input[name=pwRe]').attr('readonly', 'readonly');
	 } else if (num < 0 || eng < 0 || spe < 0) {
	   errorTxt[0].innerHTML = ("영문,숫자,특수문자를 혼합하여 8~12글자 사이로 비밀번호를 입력해 주세요.");
	   $('input[name=pwRe]').attr('readonly', 'readonly');
	 } else {
	   errorTxt[0].innerHTML = ("비밀번호 확인을 입력해주세요.");
	   $('input[name=pwRe]').removeAttr('readonly');
	   $('input[name=pwRe]').css('backgroundColor', 'white');
	 }
	
	});
	
	//비밀번호확인 체크
	$('input[name=pwRe]').change(function() {
	 pwCheck = false;
	 let pw = $('input[name=pw]').val();
	 let pwRe = $('input[name=pwRe]').val();
	
	 if (pw == pwRe && pwRe != '') {
	   pwCheck = true;
	   errorTxt[0].innerHTML = ("");
	   errorTxt[1].innerHTML = ("<font color='green'>비밀번호 확인 완료!</font>");
	 } else if (pwRe == '') {
	   errorTxt[0].innerHTML = ("비밀번호 확인을 입력해주세요.");
	   errorTxt[1].innerHTML = ("");
	 } else {
	   errorTxt[0].innerHTML = ("");
	   errorTxt[1].innerHTML = ("비밀번호가 일치하지 않습니다.");
	 }
	});
	
	
	

});





// 알림 설정
function pushEmail(){ // pushSms, pushApp 추가예정
	if($('#switch1').is(":checked") == false){
		alert("checked false");
	}
	if($('#switch1').is(":checked") == true){
		alert("checked true");
	}
}

// 회원정보수정 submit
function updateSubmit() {
	if (nicknameCheck == false) {
		alert("닉네임 중복확인을 진행해주세요");
		return false;
	} else {
    if (!nameCheck) {
    	alert("이름을 확인해주세요");
    	return false;
    } else if (!telCheck) {
    	alert("연락처를 확인해주세요");
    	return false;
    } else if (!addressCheck) {
    	alert("주소를 확인해주세요");
    	return false;
    }
  }
  alert("정보 수정이 완료되었습니다.");
  return true;
}

// 비밀번호수정 submit
function pwUpdateSubmit() {
	if (pwCheck==false) {
		alert("비밀번호 확인을 진행해주세요");
		return false;
	}
	alert("정보 수정이 완료되었습니다.");
	return true;
}	



//댓글,게시글 좋아요 추가+삭제
function heartAdd(i) {
	let postType = $('input[name=postType]').val();
	let postId = $('input[name=postId]')[i].value;
	let memberId = $('input[name=memberId]').val();
	let text = "<span onClick='heartDel(<%=i%>)'><img src='images/common/heart3.png'></span>";

	$.ajax({
		type : 'POST',
		url : "cHeartAdd.jsp?postType=" + postType + "&memberId=" + memberId
				+ "&postId=" + postId,
		dataType : "json",

		success : function(data) {
			if (data == "1") {
				document.getElementById("postHeart").innerHTML = text;
				location.reload();
			}
		},
		error : function() {
			alert('로그인 후 이용가능합니다.');
		}
	});
}

function heartDel(i) {
	let postType = $('input[name=postType]').val();
	let postId = $('input[name=postId]')[i].value;
	let memberId = $('input[name=memberId]').val();
	alert(postType+ " " + postId+ " " + memberId);
	let text = "<span onClick='heartAdd(<%=i%>)'><img src='images/common/heart2.png'></span>";

	$.ajax({
		type : 'POST',
		url : "cHeartDel.jsp?postType=" + postType + "&memberId=" + memberId
				+ "&postId=" + postId,
		dataType : "json",

		success : function(data) {
			if (data == "1") {
				document.getElementById("postHeart").innerHTML = text;
				location.reload();
			}
		},
		error : function() {
			alert('error');
		}
	});
}

function replyHeartAdd(i) {
	let postType = $('input[name=postType]').val();
	let replyId = $('input[name=replyId]')[i].value;
	let memberId = $('input[name=memberId]').val();

	let text ="<span class='replyBtn'  onclick='replyHeartDel(<%=i%>)'>"
		+ "<img src='images/common/heart3.png' style='width:20px;'>"
		+ "<%=replyList.get(i).getHeartCount()%></span>";

	$.ajax({
		type : 'POST',
		url : "cReplyHeartAdd.jsp?postType=" + postType + "&memberId="
				+ memberId + "&replyId=" + replyId,
		dataType : "json",

		success : function(data) {
			if (data == "1") {
				document.getElementById("replyHeart").innerHTML = text;
				location.reload();
			}
		},
		error : function() {
			alert('로그인 후 이용가능합니다.');
		}
	});
}

function replyHeartDel(i) {
	
	let postType = $('input[name=postType]').val();
	let replyId = $('input[name=replyId]')[i].value;
	let memberId = $('input[name=memberId]').val();
		
	let text = "<span class='replyBtn'  onclick='replyHeartAdd(<%=i%>)'>"
		+"<img src='images/common/heart2.png' style='width:20px;'>"
		+"<% if(replyList.get(i).getHeartCount() > 0) {%><%=replyList.get(i).getHeartCount()%>"
		+"<%} else{out.println('좋아요);} %></span>";

	$.ajax({
		type : 'POST',
		url : "cReplyHeartDel.jsp?postType=" + postType + "&memberId="
				+ memberId + "&replyId=" + replyId,
		dataType : "json",

		success : function(data) {
			if (data == "1") {
				document.getElementById("replyHeart").innerHTML = text;
				location.reload();
			}
		},
		error : function() {
			alert('error');
		}
	});
}


function noticeRead(i){
	let noticeId = $('input[name=noticeId]')[i].value;
	$.ajax({
		type : 'get',
		url : "noticeRead.jsp?&id=" + noticeId,
		dataType : "json",
		
		success : function(data) {
			if (data == "1") {
				location.href=$('input[name=noticeUrl]')[i].value;
			}
		},
		error : function() {
			alert('error');
		}
	});
}


function replyDel(i){
	let replyId = $('input[name=replyId]')[i].value;
	$.ajax({
		type : 'POST',
		url : "cReplyUpDel.jsp?&do=delete&replyId=" + replyId,
		dataType : "json",
		
		success : function(data) {
			if (data == "1") {
				location.reload();
			}
		},
		error : function() {
			alert('error');
		}
	});
}

function follow(){
	let memberId = $('input[name=writerId]').val(); // 작성자
	let followerId = $('input[name=memberId]').val(); // 팔로워
	if (memberId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {

		$.ajax({
			type : 'POST',
			url : "follow.jsp?todo=insert" + "&memberId="
					+ memberId + "&followerId=" + followerId,
			dataType : "json",

			success : function(data) {
				if (data==1) {
					location.reload();
				}
			},
			error:function(request, status, error) {
			        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
}
function unfollow(){
	let memberId = $('input[name=writerId]').val(); // 작성자
	let followerId = $('input[name=memberId]').val(); // 팔로워
	if (memberId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {

		$.ajax({
			type : 'POST',
			url : "follow.jsp?todo=delete" + "&memberId="
					+ memberId + "&followerId=" + followerId,
			dataType : "json",

			success : function(data) {
				if (data) {
					location.reload();
				}
			},
			error:function(request, status, error) {
			        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}
}


window.history.forward();
function noBack() {
  window.history.forward();
}
