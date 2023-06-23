<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.StoryPostsDTO"%>
<%@ page import="java.util.*"%>
<%@page import="dto.MembersBean"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	ArrayList<StoryPostsDTO> articleList = (ArrayList<StoryPostsDTO>) request.getAttribute("data");
	MembersBean member = (MembersBean) request.getAttribute("member");
	// 팔로우 정보
	int isfollow = (int) request.getAttribute("isfollow");	
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
		<c:set var="paramId" value="<%=member.getId() %>"/>
		<c:choose>
			<c:when test="${paramId eq ID}">
				<nav class="mypageNav">
					<div class="mpMainNav">
						<ul>
							<li class="nowpage"><a href="vege.user?command=myStory">프로필</a></li>
							<li><a href="vege.user?command=notice">알림</a></li>
							<li><a href="vege.user?command=myOrder">나의 쇼핑</a></li>
							<li><a href="vege.user?command=myFunding">나의 펀딩</a></li>
							<li><a href="vege.user?command=editUserInfo">설정</a></li>
						</ul>
					</div>
					<hr />
				</nav>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
		<nav class="mypageNav">
			<div>
				<ul>
				<c:choose>
				<c:when test="${paramId eq ID}">
					<li class="nowpage"><a href="vege.user?command=myStory">스토리</a></li>
					<li><a href="vege.user?command=myGonggu">공동구매</a></li>
					<li><a href="vege.user?command=myReply">댓글</a></li>
					<li><a href="vege.user?command=myHeart_products">좋아요</a></li>
				</c:when>
				<c:otherwise>
					<li class="nowpage"><a href="vege.user?command=myStory&id=${paramId }">스토리</a></li>
					<li><a href="vege.user?command=myGonggu&id=${paramId }">공동구매</a></li>
					<li><a href="vege.user?command=myReply&id=${paramId }">댓글</a></li>
					<li><a href="vege.user?command=myHeart_products&id=${paramId }">좋아요</a></li>
				</c:otherwise>
				</c:choose>
				</ul>
			</div>
			<hr />
		</nav>

		<section id="section1200">
			<div id="profile">
				<div class="profilePic">
					<c:set var="profilepic" value="<%=member.getProfileImage() %>"/>
					<c:choose>
						<c:when test="${empty profilepic}">
							<img src="images/common/emptyMember.png"></c:when>
						<c:otherwise>
							<img src="images/profileImages/${profilepic}"></c:otherwise>
					</c:choose>
				</div>
				<div>
					<div class="font19"><%=member.getNickname() %></div>
					<span class="font10"><%=member.getId() %></span>
				</div>
				<ul>
					<li>팔로워 <%= request.getAttribute("follower") %></li>
					<li>|</li>
					<li>팔로잉 <%= request.getAttribute("following") %></li>
				</ul>
				<input type="hidden" value="${ID}" name="memberId"> 
				<c:set var="paramId" value="<%=member.getId() %>"/>
				<c:set var="isfollow" value="<%=isfollow %>" />
				<c:choose>
					<c:when test="${paramId eq ID}">
						<a href="vege.user?command=editUserInfo"> <input type="button"
							value="설정" class="settingBtn">
						</a>
						<ul>
							<li>
								<a href="vege.user?command=notice">
									<img src="images/common/notice.png" />	
								</a>
							</li>
							<li>
								<a href="vege.user?command=myHeart_products">
									<img src="images/common/heart.png" />
								</a>
							</li>
							<li>
					            <a href="storeBasket.pd">
					              <img src="images/common/cart.png" />
					            </a>
					       	</li>
						</ul>
					</c:when>
					<c:otherwise>
						<input type="hidden" value="<%=member.getId() %>" name="writerId">
						
						<c:choose>
							<c:when test="${isfollow==1}">
								<div class="followBtn" onclick="unfollow()">팔로잉</div>
							</c:when>
							<c:otherwise>
								<div class="followBtn2" onclick="follow()">+ 팔로우</div>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="contents">
				<div><span class="font19">&nbsp;작성한 스토리<br>&nbsp;</span></div>
				<%
					if (articleList.size()!=0) {
						for (int i = 0; i < articleList.size(); i++) {
				%>
				<div class="storyPost">
					<a href="storyDetail.cm?page=1&id=<%=articleList.get(i).getId() %>" id="mypageUrl">
						<div class="storyImg">
							<img src="images/community/<%=articleList.get(i).getThumbnail()%>">
						</div>
						<div class="storyTxt">
							<c:set var="title" value="<%= articleList.get(i).getTitle()%>" />
							<c:choose>
								<c:when test="${fn:length(title) gt 14}">
									${fn:substring(title,0,14)} ...
								</c:when>
								<c:otherwise>
									${title}
								</c:otherwise>
							</c:choose>
						</div>
					</a>
					<div class="viewCount">
						<input type="hidden" value="story" name="postType"> 
						<input type="hidden" value="<%=articleList.get(i).getId()%>" name="postId">
						<div>
							<span id="postHeart"> 
								<c:set var="isMemberLiked" value="<%=articleList.get(i).getIsMemberLiked()%>" />
								<c:choose>
									<c:when test="${isMemberLiked == '1'}">
										<span onClick="heartDel(<%=i%>)"> <img
											src="images/common/heart3.png">
										</span>
									</c:when>
									<c:otherwise>
										<span onClick="heartAdd(<%=i%>)"> <img
											src="images/common/heart2.png">
										</span>
									</c:otherwise>
								</c:choose>
							</span>
						<p><%= articleList.get(i).getHeartCount()%></p>
						</div>
						<div>
							<img src="images/common/comment2.png" />
								<p><%= articleList.get(i).getReplyCount()%></p>
						</div>
						<div>
							<a href="storyDetail.cm?page=1&id=<%=articleList.get(i).getId() %>" id="storyUrl">
								<img src="images/common/view2.png" />
							</a>
							<p><%=articleList.get(i).getReadCount() %></p>
						</div>
					</div>
				</div>
			<%
				}
				} else {
			%>
			작성된 스토리가 없습니다.
				<%
			}
			%>
			</div>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>