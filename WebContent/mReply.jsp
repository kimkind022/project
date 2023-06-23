<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.CReplyDTO"%>
<%@page import="dto.MembersBean"%>
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
	ArrayList<CReplyDTO> replyList = (ArrayList<CReplyDTO>) request.getAttribute("data");
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

<!-- select * from gonggu where id=(SELECT postId FROM todaymk.gonggupersonnels where personnelId='aa'); -->
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap0">
		<input type="hidden" value="${ID}" name="memberId">
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
					<li><a href="vege.user?command=myStory">스토리</a></li>
					<li><a href="vege.user?command=myGonggu">공동구매</a></li>
					<li class="nowpage"><a href="vege.user?command=myReply">댓글</a></li>
					<li><a href="vege.user?command=myHeart_products">좋아요</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="vege.user?command=myStory&id=${paramId }">스토리</a></li>
					<li><a href="vege.user?command=myGonggu&id=${paramId }">공동구매</a></li>
					<li class="nowpage"><a href="vege.user?command=myReply&id=${paramId }">댓글</a></li>
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
						<input type="hidden" value="${ID}" name="memberId"> 
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
				<div class="innerContents">
					<div>
						<span class="font19">작성한 댓글(스토리)</span>
						<a href="vege.user?command=myGonggu_writed" class="showMore">전체보기</a>
						<div>
							<%
							if (replyList != null ) {
								for (int i = 0; i < 4; i++) {
						%>
						<div class="reply">
							<div id="small_profilePic" style="margin-top: 3px;">
								<c:choose>
									<c:when test="${empty profilepic}">
										<img src="images/common/emptyMember.png"></c:when>
									<c:otherwise>
										<img src="images/profileImages/${profilepic}"></c:otherwise>
								</c:choose>
							</div>
							<form id="replyUpDel">
								<ul>
									<li style="font-weight: bold;"><span><%=member.getNickname() %></span>
									</li>

									<!-- 댓글 내용 -->
									<li>
										<div class="replyContentsWrap">
											<div class="replyContents"><%=replyList.get(i).getContents()%></div>
										</div>
									</li>

									<!-- 하단 메뉴(좋아요 수정삭제 등) -->
									<li class="replyMenu">
									<span><%=replyList.get(i).getDate()%> ᆞ </span> 
									
									<input type="hidden" name="replyId" value="<%=replyList.get(i).getId()%>">
									
									<!--  댓글 좋아요(0보다 많으면 '좋아요', 아니면 갯수 표시) -->
									<div id="replyHeart">
									<c:set var="isMemberLiked" value="<%=replyList.get(i).getIsMemberLiked() %>" /> 
										<c:choose>
											<c:when test="${isMemberLiked == '1'}">
												<span class="replyBtn"  onclick="replyHeartDel(<%=i%>)">
													<img src="images/common/heart3.png" style="width:20px;">
													<%=replyList.get(i).getHeartCount()%> 
												</span>
											</c:when>
											
											<c:otherwise>
												<span class="replyBtn"  onclick="replyHeartAdd(<%=i%>)">
													<img src="images/common/heart2.png" style="width:20px;">
													<% if(replyList.get(i).getHeartCount() > 0) {%>
													<%=replyList.get(i).getHeartCount()%> 
													<%} else{
													out.println("좋아요");
													} %>
												</span>
											</c:otherwise>
										</c:choose>
									</div>
									<span> ᆞ </span> 
									<input type="button" class="replyBtn" name="replyDeleteBtn"
											value="삭제 " onclick="replyDel(<%=i%>)">
								</li>
							</ul>
							</form>
						</div>
						<hr/>

						<!-- 댓글이 없을때 화면에 표시됨 -->
						<%
							}
							} else {
						%>
						<section id="emptyArea">
							등록된 댓글이 없습니다. <br> 첫 댓글을 남겨보세요 :)
						</section>
						<%
							}
						%>
						</div>
					</div>
				</div>
				<div class="innerContents">
					<div>
						<span class="font19">작성한 댓글(공동구매)</span>
						<a href="vege.user?command=myGonggu_writed" class="showMore">전체보기</a>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>