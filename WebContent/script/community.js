let addressCheck = false;
let personnelCheck = false;
let titleCheck = false;
let categoryCheck = false;

$(document)
		.ready(
				function() {
					
					var errorTxt = document.getElementsByClassName("errorTxt");
					$('#header1').load("header.jsp");
					$('#footer1').load("footer.jsp");

					$('#writeTitle').keyup(function(e) {
						let content = $(this).val();

						// 글쓰기 > 제목 글자수 세기
						if (content.length == 0 || content == '') {
							$('.textCount').text('0');
						} else {
							$('.textCount').text(content.length);
						}
						;
					});

					// 공구 글쓰기 > 참여인원 선택 시 가격표시
					$('select[name=writePersonnel]')
							.change(
									function() {
										var personnelSelected = $(
												'select[name=writePersonnel]').val();
										$("#personnelSelected").text(
												personnelSelected);
										personnelSelected++;
										var price = $('#price').text();
										var personnelPrice = price
												/ personnelSelected;
										$("#personnelPrice").text(
												personnelPrice);
									});

					// 퀵메뉴 댓글버튼 클릭 시 input text에 포커스
					$('#quickReply').click(function() {
						$('#commentInput').focus();
					});
					
					/*
					 * $('#optionSelOpen').click(function(){
					 * $('#openBtn').attr("src", "images/common/plus2.png");
					 * $('#optionSelOpen').attr("id", "optionSelClose");
					 * $('.detailProductInfo').stop().slideDown(500); });
					 * $('#optionSelClose').click(function(){
					 * $('#openBtn').attr("src", "images/common/plus.png");
					 * $('#optionSelClose').attr("id", "optionSelOpen");
					 * $('.detailProductInfo').stop().slideUp(500); });
					 */

					// 공구 상세 > 참여자 설정 클릭 시 목록 내려옴
					$('input[name=personnelSettingBtn]').click(function() {
						$('.personnelSetting').stop().slideDown(500);
					});
					$('input[name=personnelcloseBtn]').click(function() {
						$('.personnelSetting').stop().slideUp(500);
					});

					// 시군구 선택 시 지역명을 hidden에 담는다
					$('#sido_code').change(function() {
						var sidoVal = $("#sido_code option:checked").text();
						$('input[name=sido_code]').val(sidoVal);
					});

					$('#sigoon_code').change(function() {
						var sigoonVal = $("#sigoon_code option:checked").text();
						$('input[name=sigoon_code]').val(sigoonVal);
					});

					$('#dong_code').change(function() {
						var dongVal = $("#dong_code option:checked").text();
						$('input[name=dong_code]').val(dongVal);
					});

					$('#lee_code').change(function() {
						$('input[name=lee_code]').val(leeVal);
					});

					$('input[name=replyUpdateBtn]')
							.click(
									function() {
										var text = "<input type='text' class='replyUpdateInput'><div class='replyInsertBtn'><input type='submit' name='replyBtn' value='입력'></div>"
										$('#replyContents').innerHTML = text;

									});

					// 글쓰기 유효성

					$('input[name=writeTitle]').keyup(function() {
						titleCheck = false;
						var title = $('input[name=writeTitle]').val();
						if (title == "") {
							errorTxt[0].innerHTML = ("필수 입력 항목입니다.");
							$('#hr2').style.backgroundColor = "red";
						} else {
							titleCheck = true;
						}
					});
					$('select[name=writeCategory]').change(function() {
						categoryCheck = false;
						var category = $('select[name=writeCategory]').val();
						if (category == "선택") {
							errorTxt[1].innerHTML = ("필수 입력 항목입니다.");
						} else {
							categoryCheck = true;
						}
					});
					$('#writeCategory').change(function() {
						categoryCheck = false;
						var category = $('#writeCategory').val();
						if (category == "선택") {
							categoryCheck = false;
						} else {
							categoryCheck = true;
						}
					});

					$('#gongguWriteForm').submit(
							function() {
								if ($('input[name=dong_code]').val() == "") {
									alert("주소를 선택해주세요.");
									return false
								} else if (categoryCheck == false) {
									alert("모집 인원을 선택해주세요.");
									return false;
								} else if (titleCheck == false) {
									alert("제목을 입력해주세요.");
									return false;
								} else if ($('textarea[name=writeContents]')
										.val() == "") {
									alert("내용을 입력해주세요.");
									return false;
								}
								return true;

							});

					// 댓글 유효성
					$('form[name=gongguReplyForm]').submit(function() {
						let replyContents = $("input[name=contents]").val();
						if (replyContents == "") {
							alert("댓글 내용을 입력해주세요.");
							return false;
						}
					});
					$('form[name=storyReplyForm]').submit(function() {
						let replyContents = $("input[name=contents]").val();
						if (replyContents == "") {
							alert("댓글 내용을 입력해주세요.");
							return false;
						}
					});

					// 썸네일
					$("input[name=filename]")
							.on(
									"change",
									function(e) {
										let f = e.target.files[0];
										if (!f.type.match("image*")) {
											$("input[name=filename]").val("");
											errorTxt[2].innerHTML = "이미지만 첨부할 수 있습니다.";
											profileImgCheck = false;
										} else {
											profileImgCheck = true;
											errorTxt[2].innerHTML = "&nbsp;";
										}
										// f.size = 1024*1024*2 --> 2MB
										let reader = new FileReader();
										reader.onload = function(e) {
											$(".storyThumbnail")[0].innerHTML = "<img src='images/common/heart2.png' style='width:200px;'>"
											$(".storyThumbnail img").attr(
													"src", e.target.result); // 이미지가
																				// 담김
										}
										reader.readAsDataURL(f); // 비동기적으로 실행
									});

					// 게시글 수정 시 select 값 고정

					let selectedCategory = $("input[name=selectedCategory]")
							.val();
					$("select[name=updateCategory]").val(selectedCategory)
							.prop("selected", true);

					let selectedPersonnel = $("input[name=selectedPersonnel]")
							.val();
					$("select[name=updatePersonnel]").val(selectedPersonnel)
							.prop("selected", true);

					// 스토리 카테고리, 정렬방식
					let status1 = $("input[name=status1]").val();
					let status2 = $("input[name=status2]").val(); // url상의
																	// status1,2
					let icon = $('#categoryIcon').children('div').children(
							'div');// 카테고리 아이콘
					let statusName = $('#status2').children('ul')
							.children('li'); // 정렬방식(조회수순 등)

					// 클릭 시 url 이동(status2)
					statusName
							.each(function(i) {
								$(this)
										.click(
												function(e) {
													let status2inner = this.innerHTML;
													let status2val;

													if (status2inner == "최신순") {
														status2val = 'id';
													} else if (status2inner == '인기순') {
														status2val = 'heartCount';
													} else if (status2inner == '조회수순') {
														status2val = 'readCount';
													} else if (status2inner == '댓글순') {
														status2val = 'replyCount';
													}
													if (status1 == "null") {
														location.href = "storyList.cm?page=1&status2="
																+ status2val;
													} else {
														location.href = "storyList.cm?page=1&status1="
																+ status1
																+ "&status2="
																+ status2val;
													}
												});
							});

					// url의 status 가져와서 스타일 적용
					if (status1 == "recipe" || status1=="vegetable") {
						icon[0].style.border = "2px solid rgb(240, 93, 35)";
					} else if (status1 == "knowhow" || status1=="fruit") {
						icon[1].style.border = "2px solid rgb(240, 93, 35)";
					} else if (status1 == "farm" || status1=="grain") {
						icon[2].style.border = "2px solid rgb(240, 93, 35)";
					} else if (status1 == "garden" || status1=="jam") {
						icon[3].style.border = "2px solid rgb(240, 93, 35)";
					}
					if (status2 == "id") {
						statusName[0].style.textDecorationLine = "underline";
					} else if (status2 == "heartCount") {
						statusName[1].style.textDecorationLine = "underline";
					} else if (status2 == "readCount") {
						statusName[2].style.textDecorationLine = "underline";
					} else if (status2 == "replyCount") {
						statusName[3].style.textDecorationLine = "underline";
					}

				});

function gongguStauts(){
	let status1 = $("input[name=status1]").val();
	let loca1 = $('input[name=sido_code]').val();
	let loca2 = $('input[name=sigoon_code]').val();
	let loca3 = $('input[name=dong_code]').val();
	let loca4 = $('input[name=lee_code]').val();
	if (status1 == "null") {
		location.href = "gongguList.cm?status2="
			+ loca1+"-"+ loca2+ "-"+ loca3+ "-"+ loca4+"&page=1";
	}else {
		if(loca1==""&& loca2==""&&loca3==""&&loca4==""){
			location.href = "gongguList.cm?status1="
				+ status1+"&page=1";
		}else{
			location.href = "gongguList.cm?status1="
				+ status1 + "&status2="	+ loca1+"-"+ loca2+ "-"+ loca3+ "-"+ loca4+"&page=1";
		}
	}
}

// 게시글 삭제
function gongguDelete() {
	let postId = $('input[name=postId]').val();
	let page = $('input[name=nowPage]').val();
	let statu = confirm("게시글을 삭제하시겠습니까?");
	if (!statu) {
		return false;
	} else {
		location.href = "gongguDeletePro.cm?id=" + postId + "&page=" + page;
	}
}
function storyDelete() {
	let postId = $('input[name=postId]').val();
	let page = $('input[name=nowPage]').val();
	let statu = confirm("게시글을 삭제하시겠습니까?");
	if (!statu) {
		return false;
	} else {
		location.href = "storyDeletePro.cm?id=" + postId + "&page=" + page;
	}
}

// 댓글 작성 시 로그인 체크
function replyLogin() {
	let memberId = $('input[name=memberId]').val();
	if (memberId == "") {
		alert("로그인이 필요한 서비스입니다.");
		location.href = "login.jsp";
	}
}

// ////////ajax

function follow(i){
	let memberId = $('input[name=writerId]')[i].value; // 작성자
	let followerId = $('input[name=memberId]').val(); // 팔로워
	if (followerId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {

		$.ajax({
			url : "follow.jsp?",
			data: {
				"todo": "insert", 
				"memberId":memberId,
				"followerId":followerId },		
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
function unfollow(i){
	let memberId = $('input[name=writerId]')[i].value; // 작성자
	let followerId = $('input[name=memberId]').val(); // 팔로워
	if (followerId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {

		$.ajax({
			type : 'get',
			url : "follow.jsp?",
			data: {
				"todo": "delete", 
				"memberId":memberId,
				"followerId":followerId },			
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


function personnelAdd(i) {
	let personnels = $('input[name=replyMemberId]');
	let statu = confirm("참여자로 추가하시겠습니까?");
	if (!statu) {
		return false;
	}
	let personnelId = personnels[i].value;
	let postId = $('input[name=postId]').val();
	$.ajax({
		type : 'get',
		url : "cGongguPersonnel.jsp",
		data : {
				"personnelId": personnelId, 
				"postId":postId },	
		dataType : "json",

		success : function(data) {
			if (data == "1") {
				alert('추가 완료!');
				location.reload();
			} else if (data == "0") {
				alert("이미 참여중인 회원입니다");
				return false;
			}
		},
		error : function() {
			alert('error');
		}
	});
}

function personnelDel(i) {
	let personnels = $('input[name=personnelId]');
	let statu = confirm("참여자를 목록에서 삭제하시겠습니까?");
	if (!statu) {
		return false;
	}
	let personnelId = personnels[i].value;
	let postId = $('input[name=postId]').val();
	$.ajax({
		type : 'get',
		url : "cGongguPersonnelDel.jsp?personnelId=" + personnelId + "&postId="
				+ postId,
		dataType : "text",

		success : function(data) {
			alert('삭제 완료!');
			location.reload();
		},
		error : function() {
			alert('error');
		}
	});
}

// 댓글,게시글 좋아요 추가+삭제
function heartAdd(i) {
	let postType = $('input[name=postType]').val();
	let postId = $('input[name=postId]')[i].value;
	let memberId = $('input[name=memberId]').val();
	if (memberId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {
		$.ajax({
			url : "cHeartAdd.jsp",
			data : {
				"postType": postType,
				"memberId": memberId,
				"postId" : postId
			},
			dataType : "json",
			success : function(data) {
				if (data == "1") {
					location.reload();
				}
			},
			error : function() {
				alert('로그인 후 이용가능합니다.');
			}
		});
	}
}

function heartDel(i) {
	let postType = $('input[name=postType]').val();
	let postId = $('input[name=postId]')[i].value;
	let memberId = $('input[name=memberId]').val();

	if (memberId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {
		$.ajax({
			type : 'get',
			url : "cHeartDel.jsp?postType=" + postType + "&memberId="
					+ memberId + "&postId=" + postId,
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
}

function replyHeartAdd(i) {
	let postType = $('input[name=postType]').val();
	let replyId = $('input[name=replyId]')[i].value;
	let memberId = $('input[name=memberId]').val();

	if (memberId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {
		$.ajax({
			type : 'get',
			url : "cReplyHeartAdd.jsp?postType=" + postType + "&memberId="
					+ memberId + "&replyId=" + replyId,
			dataType : "json",

			success : function(data) {
				if (data == "1") {
					location.reload();
				}
			},
			error : function() {
				alert('로그인 후 이용가능합니다.');
			}
		});
	}
}

function replyHeartDel(i) {

	let postType = $('input[name=postType]').val();
	let replyId = $('input[name=replyId]')[i].value;
	let memberId = $('input[name=memberId]').val();

	if (memberId == "") {
		alert('로그인 후 이용가능합니다.');
	} else {
		$.ajax({
			type : 'get',
			url : "cReplyHeartDel.jsp?postType=" + postType + "&memberId="
					+ memberId + "&replyId=" + replyId,
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
}

function replyInsert() {
	let postType = $('input[name=postType]').val();
	let nowPage = $('input[name=nowPage]').val();
	let memberId = $('input[name=memberId]').val();
	let writerId = $('input[name=writerId]').val();
	let postId = $('input[name=postId]').val();
	let contents = $('input[name=replyInput]').val();

	$.ajax({
		type : 'post',
		url : "storyReplyWrite.cm",
		data: {
			"postType":postType,
			"memberId": memberId,
			"postId": postId,
			"contents" : contents,
			"writerId": writerId
		},
		dataType : "json",

		success : function() {
			location.reload();
		},
		error : function() {
			alert('error');
		}
	});
}

function replyDel(i) {
	let replyId = $('input[name=replyId]')[i].value;
	let postType = $('input[name=postType]').val();
	let memberId = $('input[name=memberId]').val();

	$.ajax({
		type : 'get',
		url : "cReplyUpDel.jsp?&do=delete&replyId=" + replyId + "&postType="
				+ postType,
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

function replyUpd(i) {
	let postType = $('input[name=postType]').val();
	let replyId = $('input[name=replyId]')[i].value;
	let contents = $('.replyContents')[i].innerHTML;
	let wrap = $('.replyContentsWrap');

	// 수정버튼 클릭 시 입력창 만들기
	wrap[i].innerHTML = "<input type='text' name='updateText' class='replyInput' value='"
			+ contents + "'>";
	// 수정버튼 > 수정완료버튼으로 변경
	$('.updateBtnWrap')[i].innerHTML = "<input type='button' class='replyBtn' name='updateClick' value='수정완료'>";

	$('input[name=updateClick]').click(function() {
		let text = $('input[name=updateText]').val();
		$.ajax({
			url : "cReplyUpDel.jsp",
			dataType : "json",
			data : {
				"text" : text,
				"replyId" : replyId,
				"do" : "update",
				"postType" : postType
			},

			success : function(result) {
				if (result == 1) {
					location.reload();
				}
			},
			error:function(request, status, error) {
		        alert("status : " + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});
}