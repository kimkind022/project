<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.GongguDTO"%>
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
	ArrayList<GongguDTO> articleList = (ArrayList<GongguDTO>) request.getAttribute("data");
	ArrayList<GongguDTO> articleList2 = (ArrayList<GongguDTO>) request.getAttribute("data2");
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
					<li class="nowpage"><a href="vege.user?command=myGonggu">공동구매</a></li>
					<li><a href="vege.user?command=myReply">댓글</a></li>
					<li><a href="vege.user?command=myHeart_products">좋아요</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="vege.user?command=myStory&id=${paramId }">스토리</a></li>
					<li class="nowpage"><a href="vege.user?command=myGonggu&id=${paramId }">공동구매</a></li>
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
						<span class="font19">작성한 공동구매</span> 
						<c:choose>
						<c:when test="${paramId eq ID}">
							<a href="vege.user?command=myGonggu_writed" class="showMore">전체보기</a>
						</c:when>
						<c:otherwise>
							<a href="vege.user?command=myGonggu_writed&id=${paramId }" class="showMore">전체보기</a>
						</c:otherwise>
						</c:choose>
					</div>
					<%
						if (!articleList.isEmpty() && articleList.size() >= 3) {
							for (int i = 0; i < 3; i++) {
					%>
					<div class="gongguPost">
						<div class="gongguImg">
							<img
								src="images/store/<%=articleList.get(i).getProductBean().getImageNo1()%>">
						</div>
						<div class="gongguTxt">
							<div class="gongguLocation">
								<img src="images/common/location2.png" style="width: 25px;">
								<span class="font10"> <%=articleList.get(i).getSido_code()%>&nbsp;
									<%=articleList.get(i).getSigoon_code()%>&nbsp; <%=articleList.get(i).getDong_code()%>&nbsp;
									<%
										if (!articleList.get(i).getLee_code().equals("0")) {
													out.println(articleList.get(i).getLee_code());
												} else {
									%> &nbsp; <%
									 	}
									 %>
								</span>
							</div>
							<ul>
								<li><%=articleList.get(i).getProductBean().getName()%></li>
								<c:set var="discount"
									value="<%=articleList.get(i).getProductBean().getDiscountRate()%>" />
								<c:choose>
									<c:when test="${discount eq 0}">
										<b><%=articleList.get(i).getProductBean().getPrice()%> 원</b>
										<br>
									</c:when>
									<c:otherwise>
										<li><font color="F05D23"><%=articleList.get(i).getProductBean().getDiscountRate()%>%</font>
											<%=articleList.get(i).getProductBean().getPrice()%> 원 <br>
											<span class="pdtnonsale"><%=articleList.get(i).getProductBean().getPrice()%></span></li>
									</c:otherwise>
								</c:choose>

								<li><span class="progressValue">▶ <%=articleList.get(i).getPersonnel() + 1%>명
										구매 시 <%=articleList.get(i).getProductBean().getPrice() / (articleList.get(i).getPersonnel() + 1)%>원
								</span></li>

							</ul>
							<div></div>
						</div>
						<a
							href="gongguDetail.cm?id=<%=articleList.get(i).getId()%>&page=1">
							<div class="gongguTxt">
								<ul>
									<li><c:set var="title"
											value="<%=articleList.get(i).getTitle()%>" /> <!-- 글자수가 10자 이상이면 자른다 -->
										<c:choose>
											<c:when test="${fn:length(title) gt 14}">
												<b>${fn:substring(title,0,14)} ...</b>
											</c:when>
											<c:otherwise>
												<b>${title}</b>
											</c:otherwise>
										</c:choose></li>
									<li><%=articleList.get(i).getNickname()%></li>
									<li><span class="font10">n월 n일 까지 &nbsp;&nbsp;<%=articleList.get(i).getEndDateTrans()%>
											마감
									</span></li>
									<!-- progress, 마감 시 회색 -->
									<%
										if (articleList.get(i).getPersonnelval() == articleList.get(i).getPersonnel()|| articleList.get(i).getEndDateTrans().contains("전"))  {
									%>
									<li><progress class="progressEnd"
											value="<%=articleList.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressEndValue"><%=articleList.get(i).getPersonnelval()%>/<%=articleList.get(i).getPersonnel()%>
											마감된 공동구매입니다.</span> <%
									 	} else {
									 %>
									<li><progress class="progress"
											value="<%=articleList.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressValue"><%=articleList.get(i).getPersonnelval()%>/<%=articleList.get(i).getPersonnel()%>
											모집중 </span></li>
									<%
										}
									%>
								</ul>
							</div>
						</a>
						<div class="viewCount">
							<input type="hidden" value="gonggu" name="postType"> <input
								type="hidden" value="<%=articleList.get(i).getId()%>"
								name="postId">

							<div>
								<img src="images/common/comment2.png" />
								<p><%=articleList.get(i).getReplyCount()%></p>
							</div>
							<div>
								<a href="cStoryPost.jsp?id=<%=articleList.get(i).getId()%>"
									id="storyUrl"> <img src="images/common/mail2.png" />
								</a>
								<p>1521</p>
							</div>
							<div>
								<span id="postHeart"> <c:set var="isMemberLiked"
										value="<%=articleList.get(i).getIsMemberLiked()%>" /> <c:choose>
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
								<p><%=articleList.get(i).getHeartCount()%></p>

							</div>
						</div>
					</div>
					<%
						}
						} else if (!articleList.isEmpty() && articleList.size() < 3) {
							for (int i = 0; i < articleList.size(); i++) {
					%>
					<div class="gongguPost">
						<div class="gongguImg">
							<img
								src="images/store/<%=articleList.get(i).getProductBean().getImageNo1()%>">
						</div>
						<div class="gongguTxt">
							<div class="gongguLocation">
								<img src="images/common/location2.png" style="width: 25px;">
								<span class="font10"> <%=articleList.get(i).getSido_code()%>&nbsp;
									<%=articleList.get(i).getSigoon_code()%>&nbsp; <%=articleList.get(i).getDong_code()%>&nbsp;
									<%
										if (!articleList.get(i).getLee_code().equals("0")) {
													out.println(articleList.get(i).getLee_code());
												} else {
									%> &nbsp; <%
									 	}
									 %>
								</span>
							</div>
							<ul>
								<li><%=articleList.get(i).getProductBean().getName()%></li>
								<c:set var="discount"
									value="<%=articleList.get(i).getProductBean().getDiscountRate()%>" />
								<c:choose>
									<c:when test="${discount eq 0}">
										<b><%=articleList.get(i).getProductBean().getPrice()%> 원</b>
										<br>
									</c:when>
									<c:otherwise>
										<li><font color="F05D23"><%=articleList.get(i).getProductBean().getDiscountRate()%>%</font>
											<%=articleList.get(i).getProductBean().getPrice()%> 원 <br>
											<span class="pdtnonsale"><%=articleList.get(i).getProductBean().getPrice()%></span></li>
									</c:otherwise>
								</c:choose>

								<li><span class="progressValue">▶ <%=articleList.get(i).getPersonnel() + 1%>명
										구매 시 <%=articleList.get(i).getProductBean().getPrice() / (articleList.get(i).getPersonnel() + 1)%>원
								</span></li>

							</ul>
							<div></div>
						</div>
						<a
							href="gongguDetail.cm?id=<%=articleList.get(i).getId()%>&page=1">
							<div class="gongguTxt">
								<ul>
									<li><c:set var="title"
											value="<%=articleList.get(i).getTitle()%>" /> <!-- 글자수가 10자 이상이면 자른다 -->
										<c:choose>
											<c:when test="${fn:length(title) gt 14}">
												<b>${fn:substring(title,0,14)} ...</b>
											</c:when>
											<c:otherwise>
												<b>${title}</b>
											</c:otherwise>
										</c:choose></li>
									<li><%=articleList.get(i).getNickname()%></li>
									<li><span class="font10">n월 n일 까지 &nbsp;&nbsp;<%=articleList.get(i).getEndDateTrans()%>
											마감
									</span></li>
									<!-- progress, 마감 시 회색 -->
									<%
										if (articleList.get(i).getPersonnelval() == articleList.get(i).getPersonnel()|| articleList.get(i).getEndDateTrans().contains("전"))  {
									%>
									<li><progress class="progressEnd"
											value="<%=articleList.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressEndValue"><%=articleList.get(i).getPersonnelval()%>/<%=articleList.get(i).getPersonnel()%>
											마감된 공동구매입니다.</span> <%
									 	} else {
									 %>
									<li><progress class="progress"
											value="<%=articleList.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressValue"><%=articleList.get(i).getPersonnelval()%>/<%=articleList.get(i).getPersonnel()%>
											모집중 </span></li>
									<%
										}
									%>
								</ul>
							</div>
						</a>
						<div class="viewCount">
							<input type="hidden" value="gonggu" name="postType"> <input
								type="hidden" value="<%=articleList.get(i).getId()%>"
								name="postId">

							<div>
								<img src="images/common/comment2.png" />
								<p><%=articleList.get(i).getReplyCount()%></p>
							</div>
							<div>
								<a href="cStoryPost.jsp?id=<%=articleList.get(i).getId()%>"
									id="storyUrl"> <img src="images/common/mail2.png" />
								</a>
								<p>1521</p>
							</div>
							<div>
								<span id="postHeart"> <c:set var="isMemberLiked"
										value="<%=articleList.get(i).getIsMemberLiked()%>" /> <c:choose>
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
								<p><%=articleList.get(i).getHeartCount()%></p>

							</div>
						</div>
					</div>
					<%
						}
						} else if (articleList.isEmpty()) {
					%>
					작성한 게시글이 없습니다.
					<%
						}
					%>
				</div>
				<div class="innerContents">
					<div class="hrMargin">
						<hr />
					</div>
					<div>
						<span class="font19">참여한 공동구매</span> 
						<c:choose>
						<c:when test="${paramId eq ID}">
							<a href="vege.user?command=myGonggu_writed" class="showMore">전체보기</a>
						</c:when>
						<c:otherwise>
							<a href="vege.user?command=myGonggu_writed&id=${paramId }" class="showMore">전체보기</a>
						</c:otherwise>
						</c:choose>
					</div>
					<%
						if (!articleList2.isEmpty() && articleList2.size() >= 3) {
							for (int i = 0; i < 3; i++) {
					%>
					<div class="gongguPost">
						<div class="gongguImg">
							<img
								src="images/store/<%=articleList.get(i).getProductBean().getImageNo1()%>">
						</div>
						<div class="gongguTxt">
							<div class="gongguLocation">
								<img src="images/common/location2.png" style="width: 25px;">
								<span class="font10"> <%=articleList2.get(i).getSido_code()%>&nbsp;
									<%=articleList2.get(i).getSigoon_code()%>&nbsp; <%=articleList2.get(i).getDong_code()%>&nbsp;
									<%
										if (!articleList2.get(i).getLee_code().equals("0")) {
													out.println(articleList2.get(i).getLee_code());
												} else {
									%> &nbsp; <%
									 	}
									 %>
								</span>
							</div>
							<ul>
								<li><%=articleList2.get(i).getProductBean().getName()%></li>
								<c:set var="discount"
									value="<%=articleList2.get(i).getProductBean().getDiscountRate()%>" />
								<c:choose>
									<c:when test="${discount eq 0}">
										<b><%=articleList2.get(i).getProductBean().getPrice()%> 원</b>
										<br>
									</c:when>
									<c:otherwise>
										<li><font color="F05D23"><%=articleList2.get(i).getProductBean().getDiscountRate()%>%</font>
											<%=articleList2.get(i).getProductBean().getPrice()%> 원 <br>
											<span class="pdtnonsale"><%=articleList2.get(i).getProductBean().getPrice()%></span></li>
									</c:otherwise>
								</c:choose>

								<li><span class="progressValue">▶ <%=articleList2.get(i).getPersonnel() + 1%>명
										구매 시 <%=articleList2.get(i).getProductBean().getPrice() / (articleList.get(i).getPersonnel() + 1)%>원
								</span></li>

							</ul>
							<div></div>
						</div>
						<a
							href="gongguDetail.cm?id=<%=articleList2.get(i).getId()%>&page=1">
							<div class="gongguTxt">
								<ul>
									<li><c:set var="title"
											value="<%=articleList2.get(i).getTitle()%>" /> <!-- 글자수가 10자 이상이면 자른다 -->
										<c:choose>
											<c:when test="${fn:length(title) gt 14}">
												<b>${fn:substring(title,0,14)} ...</b>
											</c:when>
											<c:otherwise>
												<b>${title}</b>
											</c:otherwise>
										</c:choose></li>
									<li><%=articleList2.get(i).getNickname()%></li>
									<li><span class="font10">n월 n일 까지 &nbsp;&nbsp;<%=articleList2.get(i).getEndDateTrans()%>
											마감
									</span></li>
									<!-- progress, 마감 시 회색 -->
									<%
										if (articleList2.get(i).getPersonnelval() == articleList2.get(i).getPersonnel()|| articleList.get(i).getEndDateTrans().contains("전"))  {
									%>
									<li><progress class="progressEnd"
											value="<%=articleList2.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList2.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressEndValue"><%=articleList2.get(i).getPersonnelval()%>/<%=articleList2.get(i).getPersonnel()%>
											마감된 공동구매입니다.</span> <%
									 	} else {
									 %>
									<li><progress class="progress"
											value="<%=articleList2.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList2.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressValue"><%=articleList2.get(i).getPersonnelval()%>/<%=articleList2.get(i).getPersonnel()%>
											모집중 </span></li>
									<%
										}
									%>
								</ul>
							</div>
						</a>
						<div class="viewCount">
							<input type="hidden" value="gonggu" name="postType"> <input
								type="hidden" value="<%=articleList2.get(i).getId()%>"
								name="postId">

							<div>
								<img src="images/common/comment2.png" />
								<p><%=articleList2.get(i).getReplyCount()%></p>
							</div>
							<div>
								<a href="cStoryPost.jsp?id=<%=articleList2.get(i).getId()%>"
									id="storyUrl"> <img src="images/common/mail2.png" />
								</a>
								<p>1521</p>
							</div>
							<div>
								<span id="postHeart"> <c:set var="isMemberLiked"
										value="<%=articleList2.get(i).getIsMemberLiked()%>" /> <c:choose>
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
								<p><%=articleList2.get(i).getHeartCount()%></p>

							</div>
						</div>
					</div>
					<%
						}
						} else if (!articleList2.isEmpty() && articleList2.size() < 3) {
							for (int i = 0; i < articleList2.size(); i++) {
					%>
					<div class="gongguPost">
						<div class="gongguImg">
							<img
								src="images/store/<%=articleList2.get(i).getProductBean().getImageNo1()%>">
						</div>
						<div class="gongguTxt">
							<div class="gongguLocation">
								<img src="images/common/location2.png" style="width: 25px;">
								<span class="font10"> <%=articleList2.get(i).getSido_code()%>&nbsp;
									<%=articleList2.get(i).getSigoon_code()%>&nbsp; <%=articleList2.get(i).getDong_code()%>&nbsp;
									<%
										if (!articleList2.get(i).getLee_code().equals("0")) {
													out.println(articleList2.get(i).getLee_code());
												} else {
									%> &nbsp; <%
									 	}
									 %>
								</span>
							</div>
							<ul>
								<li><%=articleList2.get(i).getProductBean().getName()%></li>
								<c:set var="discount"
									value="<%=articleList2.get(i).getProductBean().getDiscountRate()%>" />
								<c:choose>
									<c:when test="${discount eq 0}">
										<b><%=articleList2.get(i).getProductBean().getPrice()%> 원</b>
										<br>
									</c:when>
									<c:otherwise>
										<li><font color="F05D23"><%=articleList2.get(i).getProductBean().getDiscountRate()%>%</font>
											<%=articleList2.get(i).getProductBean().getPrice()%> 원 <br>
											<span class="pdtnonsale"><%=articleList2.get(i).getProductBean().getPrice()%></span></li>
									</c:otherwise>
								</c:choose>

								<li><span class="progressValue">▶ <%=articleList2.get(i).getPersonnel() + 1%>명
										구매 시 <%=articleList2.get(i).getProductBean().getPrice() / (articleList.get(i).getPersonnel() + 1)%>원
								</span></li>

							</ul>
							<div></div>
						</div>
						<a
							href="gongguDetail.cm?id=<%=articleList2.get(i).getId()%>&page=1">
							<div class="gongguTxt">
								<ul>
									<li><c:set var="title"
											value="<%=articleList2.get(i).getTitle()%>" /> <!-- 글자수가 10자 이상이면 자른다 -->
										<c:choose>
											<c:when test="${fn:length(title) gt 14}">
												<b>${fn:substring(title,0,14)} ...</b>
											</c:when>
											<c:otherwise>
												<b>${title}</b>
											</c:otherwise>
										</c:choose></li>
									<li><%=articleList2.get(i).getNickname()%></li>
									<li><span class="font10">n월 n일 까지 &nbsp;&nbsp;<%=articleList2.get(i).getEndDateTrans()%>
											마감
									</span></li>
									<!-- progress, 마감 시 회색 -->
									<%
										if (articleList2.get(i).getPersonnelval() == articleList2.get(i).getPersonnel()|| articleList.get(i).getEndDateTrans().contains("전"))  {
									%>
									<li><progress class="progressEnd"
											value="<%=articleList2.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList2.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressEndValue"><%=articleList2.get(i).getPersonnelval()%>/<%=articleList2.get(i).getPersonnel()%>
											마감된 공동구매입니다.</span> <%
									 	} else {
									 %>
									<li><progress class="progress"
											value="<%=articleList2.get(i).getPersonnelval()%>" min="0"
											max="<%=articleList2.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressValue"><%=articleList2.get(i).getPersonnelval()%>/<%=articleList2.get(i).getPersonnel()%>
											모집중 </span></li>
									<%
										}
									%>
								</ul>
							</div>
						</a>
						<div class="viewCount">
							<input type="hidden" value="gonggu" name="postType"> <input
								type="hidden" value="<%=articleList2.get(i).getId()%>"
								name="postId">

							<div>
								<img src="images/common/comment2.png" />
								<p><%=articleList2.get(i).getReplyCount()%></p>
							</div>
							<div>
								<a href="cStoryPost.jsp?id=<%=articleList2.get(i).getId()%>"
									id="storyUrl"> <img src="images/common/mail2.png" />
								</a>
								<p>1521</p>
							</div>
							<div>
								<span id="postHeart"> <c:set var="isMemberLiked"
										value="<%=articleList2.get(i).getIsMemberLiked()%>" /> <c:choose>
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
								<p><%=articleList2.get(i).getHeartCount()%></p>

							</div>
						</div>
					</div>
					<%
						}
						} else if (articleList2.isEmpty()) {
					%>

					참여중인 공동구매가 없습니다.
					<%
						}
					%>
				</div>
			</div>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>