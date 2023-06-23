<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
					<li><a href="vege.user?command=editUserInfo">회원정보수정</a></li>
					<li><a href="editPushFrom.fd">알림 설정</a></li>
					<li class="nowpage"><a href="vege.user?command=editPassword">비밀번호
							변경</a></li>
				</ul>
			</div>
			<hr />
		</nav>

		<section id="section500">
			<form onsubmit="return pwUpdateSubmit()" method="post" action="vege.user?command=updatePassword">
				<div>
					<p class="font19">비밀번호 변경</p>
					<p class="font10">영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</p>
				</div>
				<div class="wrap500">
					<table>
						<tr><td><span>새 비밀번호</span></td></tr>
						<tr>
							<td><input type="password" name="pw" maxlength="16"
								size="40" class="text"></td>
						</tr>
						<tr class="inputError">
							<td>
								<div class="errorTxt">&nbsp;</div>
								<span>&nbsp;</span>
							</td>
						</tr>
						<tr><td><span>비밀번호 확인</span></td></tr>
						<tr>
							<td><input type="password" name="pwRe" maxlength="16"
								size="40" class="text" readonly="readonly"></td>
						</tr>
						<tr class="inputError">
							<td>
								<div class="errorTxt">&nbsp;</div>
								<span>&nbsp;</span>
							</td>
						</tr>
						<tr align="center">
							<td><br> <input type="submit"
							class="hugebtn" value="수정 완료"></td>
						</tr>
					</table>
				</div>

			</form>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>