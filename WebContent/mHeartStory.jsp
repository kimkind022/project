<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.StoryPostsDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	ArrayList<StoryPostsDTO> articleList = (ArrayList<StoryPostsDTO>) request.getAttribute("data");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/mypage.js"></script>
<link href="styles/mypage.css" rel="stylesheet" type="text/css">


<!-- 마이페이지의 메인 페이지: 프로필 -->
<body>

	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap0">
		<input type="hidden" value="${ID}" name="memberId">
		<div class="wideProfile">
			<div class="mPageTitle">
				<span class="font19">좋아요 스크랩북</span>
			</div>
			<div class="profilePic2" onclick="location.href='vege.user?command=myStory'">
				<c:choose>
						<c:when test="${empty PROFILEIMG}">
							<img src="images/common/emptyMember.png"></c:when>
						<c:otherwise>
							<img src="images/profileImages/${PROFILEIMG}"></c:otherwise>
					</c:choose>
			</div>
			<div class="font15">${NICKNAME}</div>
		</div>
		<nav class="mypageNav">
			<div>
				<ul>
					<li><a href="vege.user?command=myHeart_products">상품</a></li>
					<li class="nowpage"><a href="vege.user?command=myHeart_story">스토리</a></li>
					<li><a href="vege.user?command=myHeart_gonggu">공동구매</a></li>
					<li><a href="vege.user?command=myHeart_funding">펀딩</a></li>
				</ul>
			</div>
			<hr />
		</nav>
		<section id="section1200">
			<div class="heartWrap">
			<%
				if (!articleList.isEmpty()) {
					for (int i = 0; i < articleList.size(); i++) {
			%>
				<div class="HeartCcontents" onclick="location.href='storyDetail.cm?page=1&id=<%=articleList.get(i).getId() %>'">
					<div class="HeartPostImg">
						<img src="images/community/<%=articleList.get(i).getThumbnail()%>">
					</div>
					<div class="postTxt"><%=articleList.get(i).getTitle()%></div>

					<div class="postProfile">
						<div id="small_profilePic" style="margin-top: 3px;">
							<c:set var="profileImg"
								value="<%=articleList.get(i).getProfileImage()%>" />
							<c:choose>
								<c:when test="${empty profileImg}">
									<img src="images/common/emptyMember.png">
								</c:when>
								<c:otherwise>
									<img
										src="images/profileImages/<%=articleList.get(i).getProfileImage()%>">
								</c:otherwise>
							</c:choose>
						</div>
						<span><%=articleList.get(i).getNickname()%></span>
					</div>
				</div>
			
				<%
					}
					}
				%>
			</div>
		</section>




	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>