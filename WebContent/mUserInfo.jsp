<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.MembersBean"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	MembersBean membersBean = (MembersBean) request.getAttribute("data");
%>
<jsp:useBean id="Dateutil" class="util.Dateutil" />
<c:set var="Dateutil" value="${Dateutil}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<!-- 주소검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="script/addressFind.js"></script>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/mypage.js"></script>
<link href="styles/mypage.css" rel="stylesheet" type="text/css">

<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap0">

		<nav class="mypageNav">
			<div class="mpMainNav">
				<ul>
					<li><a href="vege.user?command=myStory">프로필</a></li>
					<li><a href="vege.user?command=notice">알림</a></li>
					<li><a href="vege.user?command=myOrder">나의 쇼핑</a></li>
					<li><a href="vege.user?command=myFunding">나의 펀딩</a></li>
					<li class="nowpage"><a href="vege.user?command=editUserInfo">설정</a></li>
				</ul>
			</div>
			<hr />
		</nav>
		<nav class="mypageNav">
			<div>
				<ul>
					<li class="nowpage"><a href="vege.user?command=editUserInfo">회원정보수정</a></li>
					<li><a href="editPushFrom.fd">알림 설정</a></li>
					<li><a href="vege.user?command=editPassword">비밀번호 변경</a></li>
				</ul>
			</div>
			<hr />
		</nav>

		<section id="section770">
			<form onsubmit="return updateSubmit()" method="post" action="vege.user?command=updateUserInfo" enctype="multipart/form-data">
				<div>
					<span class="font19">회원정보수정</span>
					<span id="memberDel">탈퇴하기</span>
				</div>
				<div class="wrap770">
				<table>
					<tr>
						<td><span>이름</span></td>
						<td><input type="text" name="name" maxlength="10" size="40"
							class="text" value="<%=membersBean.getName()%>"></td>
						<td>&nbsp;</td>
					</tr>
					<tr class="inputError">
						<td></td>
						<td>
							<div class="errorTxt">&nbsp;</div>
							<span>&nbsp;</span>
						</td>
						<td></td>
					</tr>
					<tr>
						<td><span>닉네임</span></td>
						<td><input type="text" name="nickname" maxlength="6"
							size="40" placeholder="6자 이하로 입력"  value="<%=membersBean.getNickname()%>" class="text"></td>
						<td><input type="button" name="nickSearch" class="button"
							value="중복확인"></td>
					</tr>
					<tr class="inputError">
						<td></td>
						<td>
							<div class="errorTxt">&nbsp;</div>
							<span>&nbsp;</span>
						</td>
						<td></td>
					</tr>
					<tr>
						<td><span>휴대폰</span></td>
						<td><input type="text" name="tel" maxlength="11" size="40"
							placeholder="'-' 제외 숫자만 입력"  value="<%=membersBean.getTel()%>"class="text"></td>
						<td>&nbsp;</td>
					</tr>
					<tr class="inputError">
						<td></td>
						<td>
							<div class="errorTxt">&nbsp;</div>
							<span>&nbsp;</span>
						</td>
						<td></td>
					</tr>
					<tr>
						<td class="address2"><span>주소</span></td>
						<td>
							<div class="address1">
								<input type="text" name="address" class="text" placeholder="주소" value="<%=membersBean.getAddress1()%>" readonly>
							</div>
						</td>
						<td class="address2"><input type="button"
							name="addressSearch" value="주소검색" class="button"
							onclick="execDaumPostcode()"></td>
					</tr>
					<tr>
						<td class="address2">
						<td>
							<div class="address1">
								<input type="text" name="addressInfo" class="text"placeholder="상세 주소(동,호수 등)" value="<%=membersBean.getAddress2()%>" readonly="readonly">
							</div>
						</td>
						<td class="address2"></td>
					</tr>
					<tr class="inputError">
						<td></td>
						<td>
							<div class="errorTxt">&nbsp;</div>
							<span>&nbsp;</span>
						</td>
						<td></td>
					</tr>
					<tr>
						<td><span>프로필 사진</span></td>
						<td>
						<span class="profilethumbnail">
							<c:set var="profileImg" value="<%=membersBean.getProfileImage() %>"/> 
							<c:choose>
								<c:when test="${empty profileImg}">
									<img src="images/common/emptyMember.png"></c:when>
								<c:otherwise>
									<img src="images/profileImages/<%=membersBean.getProfileImage() %>"></c:otherwise>
							</c:choose>
						</span>
						<input type="file" name="filename" onChange="getThumbnail()"></td>
						<td></td>
					</tr>
					<tr class="inputError">
						<td></td>
						<td>
							<div class="errorTxt">&nbsp;</div>
							<span>&nbsp;</span>
						</td>
						<td></td>
					</tr>
					<tr align="center">
						<td colspan="3">
							<hr />
						</td>
					</tr>

					<tr align="center">
						<td colspan="3"><br> <input type="submit" name="updateBtn"
							class="bigbtn" value="수정 완료"></td>
					</tr>
				</table>
				</div>
				</form>
			</div>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>