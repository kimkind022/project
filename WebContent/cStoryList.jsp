<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="dto.CReplyDTO"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.StoryPostsDTO"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>

<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>

<%
	ArrayList<StoryPostsDTO> articleList = (ArrayList<StoryPostsDTO>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	String status1 = pageInfo.getStatus1();
	String status2 = pageInfo.getStatus2();
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>스토리 전체보기</title>

<jsp:include page="common.jsp"></jsp:include>
<link href="styles/communityStory.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script/community.js"></script>

</head>
<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap1">
		<div class="wrap770">

			<!-- 퀵메뉴, 글 작성 클릭 시 로그인 확인 -->
				<div id="quickmenu">
					<c:choose>
						<c:when test="${empty ID}">
							<a href="login.jsp">
						</c:when>
						<c:otherwise>
							<a href="storyWriteForm.cm">
						</c:otherwise>
					</c:choose>
					<div class="quickIcon2">
						<div>
							<img src="images/common/write.png" />
						</div>
					</div>
					</a> <a href="#header1">
						<div class="quickIcon1">
							<div>
								<img src="images/common/up.png" />
							</div>
						</div>
					</a>
				</div>


			<!-- 포스팅 목록 -->
			<section id="storySection">
				<div class="title">
					<h1>스토리</h1>
				</div>
				<div id="categoryIcon">
					<div onclick="location.href='storyList.cm?page=1&status1=recipe';">
						<div>
							<img src="images/community/recipe.png" />
						</div>
						<span>레시피</span>
					</div>
					<div onclick="location.href='storyList.cm?page=1&status1=knowhow';">
						<div>
							<img src="images/community/tip.png" />
						</div>
						<span>노하우</span>
					</div>
					<div onclick="location.href='storyList.cm?page=1&status1=farm';">
						<div>
							<img src="images/community/farm.png" />
						</div>
						<span>농장소개</span>
					</div>
					<div onclick="location.href='storyList.cm?page=1&status1=garden';">
						<div>
							<img src="images/community/garden.png" />
						</div>
						<span>텃밭자랑</span>
					</div>
					<div onclick="location.href='storyList.cm?page=1';">
						<div>
							<img src="images/common/showmore.png" />
						</div>
						<span>전체보기</span>
					</div>
				</div>
				<div id="status2">
					<ul>
						<li>최신순</li>
						<li>인기순</li>
						<li>조회수순</li>
						<li>댓글순</li>
					</ul>
				</div>
				<input type="hidden" value="${ID}" name="memberId">
				<input type="hidden" value="story" name="postType">
				<input type="hidden" value=<%=nowPage %> name="nowPage">
				<input type="hidden" value=<%=status1 %> name="status1">
				<input type="hidden" value=<%=status2 %> name="status2">
				<input type="hidden" value=<%=request.getRequestURL() %> name="nowURL">
				<input type="hidden" value=<%=request.getQueryString() %> name="nowQuery">
				<% 
					if (listCount != 0) {
						for (int i = 0; i < articleList.size(); i++) {
				%>
				<input type="hidden" name="postId" value="<%=articleList.get(i).getId()%>">
				<div class="listSection">
					<header id="postHeader">
						<div class="postSubTitle">
							<%=articleList.get(i).getCategory()%>
						</div>
						<div class="postTitle">
							<a href="storyDetail.cm?id=<%=articleList.get(i).getId()%>&page=<%=nowPage %>">
								<%=articleList.get(i).getTitle()%>
							</a>
						</div>
						<div id="profileContainer">
							<div id="profileImg">
								<c:set var="profileImg" value="<%=articleList.get(i).getProfileImage()%>" />
								<c:choose>
									<c:when test="${empty profileImg}">
										<img src="images/common/emptyMember.png">
									</c:when>
									<c:otherwise>
										<img src="images/profileImages/<%=articleList.get(i).getProfileImage()%>">
									</c:otherwise>
								</c:choose>
							</div>
							<div id="profileTxt">
								<ul class="txtleft">
									<li style="font-weight: bold;"><%=articleList.get(i).getNickname()%></li>
									<li style="font-size: 11pt; color: gray;"><%=articleList.get(i).getDateTrans()%></li>
								</ul>
							</div>
							<!-- 작성자=로그인 닉네임 체크 -->
							<c:set var="postNick" value="<%=articleList.get(i).getNickname()%>" />
							<c:set var="follow" value="<%=articleList.get(i).getIsFollow() %>" />
							<input type="hidden" value="<%=articleList.get(i).getMemberId() %>" name="writerId">
							<c:choose>
								<c:when test="${NICKNAME != postNick}">
									<c:choose>
										<c:when test="${follow==1}">
											<div class="followBtn" onclick="unfollow(<%=i %>)">팔로잉</div>
										</c:when>
										<c:otherwise>
											<div class="followBtn2" onclick="follow(<%=i %>)">+ 팔로우</div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div class="updel">
										<ul>
											<li><input type="button" value="삭제"
												onClick="storyDelete()"></li>
											<li>|</li>
											<li><a
												href="storyUpdateForm.cm?id=<%=articleList.get(i).getId()%>&page=<%=nowPage%>"><input
													type="button" value="수정"></a></li>
										</ul>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</header>
					<section id="postcontainer">
						<div class="listImg">
							<a href="storyDetail.cm?id=<%=articleList.get(i).getId()%>&page=<%=nowPage %>">
								<img src="images/community/<%=articleList.get(i).getThumbnail()%>">
							</a>
						</div>
						<div class="viewCountWrap">
							<div class="viewCount">
								<div>
									<div id="postHeart">
										<c:set var="isMemberLiked" value="<%=articleList.get(i).getIsMemberLiked() %>" /> 
										<c:choose>
											<c:when test="${isMemberLiked == '1'}">
												<span onClick="heartDel(<%=i%>)" >
													<img src="images/common/heart3.png">
												</span>
											</c:when>
											<c:otherwise>
												<span onClick="heartAdd(<%=i%>)">
													<img src="images/common/heart2.png">
												</span>
											</c:otherwise>
										</c:choose><br>
									</div>
								</div>
								<div>
									<img src="images/common/comment2.png" />
								</div>
							</div>
							<div class="viewCount2">
								<br>
								<ul class="txtleft">
									<li>좋아요 <%=articleList.get(i).getHeartCount() %></li>
									<li>댓글 <%=articleList.get(i).getReplyCount() %></li>
									<li>조회수 <%=articleList.get(i).getReadCount() %></li>
								</ul>
							</div>
						</div>
						<div class="postTxt">
							<c:set var="contents"
								value="<%=articleList.get(i).getContents()%>" />
							<!-- 글자수가 30자 이상이면 자른다 -->
							<c:choose>
								<c:when test="${fn:length(contents) gt 30}">
									${fn:substring(contents,0,30)}
										<a href="storyDetail.cm?id=<%=articleList.get(i).getId()%>&page=<%=nowPage %>">&nbsp;&nbsp;
										...더보기</a>
								</c:when>
								<c:otherwise>
									<%=articleList.get(i).getContents()%>
								</c:otherwise>
							</c:choose>
						</div>
					</section>
				</div>
				<%
					}
					} else {
				%>
				<div id="emptyArea">
					<span>아직 등록된 스토리가 없습니다.</span>
					<span>첫 게시글을 남겨보세요 :)</span>
				</div>
				<%
					}
				%>
		</div>
		<hr />
		<div id="page">
			<span> <%
 	if (nowPage <= 1) {
 %> [이전]&nbsp; <%
 	} else {
 %> <a href="storyList.cm?page=<%=nowPage - 1%>">[이전]</a>&nbsp; <%
 	}
 %> <%
 	for (int a = startPage; a <= endPage; a++) {
 		if (a == nowPage) {
 %> [<%=a%>] <%
 	} else {
 %> <a href="storyList.cm?page=<%=a%>">[<%=a%>]
			</a>&nbsp; <%
 	}
 %> <%
 	}
 %> <%
 	if (nowPage >= maxPage) {
 %> [다음] <%
 	} else {
 %> <a href="storyList.cm?page=<%=nowPage + 1%>">[다음]</a> <%
 	}
 %>
				</section>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>