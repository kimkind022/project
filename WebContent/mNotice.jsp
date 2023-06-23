<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dto.PageInfo"%>
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
	ArrayList<NoticeDTO> articleList = (ArrayList<NoticeDTO>) request.getAttribute("data");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
</head>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/mypage.js"></script>
<link href="styles/mypage.css" rel="stylesheet" type="text/css">


<!-- 마이페이지의 메인 페이지: 프로필 -->
<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap0">

		<nav class="mypageNav">
			<div class="mpMainNav">
				<ul>
					<li><a href="vege.user?command=myStory">프로필</a></li>
					<li class="nowpage"><a href="vege.user?command=notice">알림</a></li>
					<li><a href="vege.user?command=myOrder">나의 쇼핑</a></li>
					<li><a href="vege.user?command=myFunding">나의 펀딩</a></li>
					<li><a href="vege.user?command=editUserInfo">설정</a></li>
				</ul>
			</div>
			<hr />
		</nav>


		<section id="section1200">
			<div id="profile">
				<div class="profilePic">
					<c:choose>
						<c:when test="${empty PROFILEIMG}">
							<img src="images/common/emptyMember.png">
						</c:when>
						<c:otherwise>
							<img src="images/profileImages/${PROFILEIMG}">
						</c:otherwise>
					</c:choose>

				</div>
				<div>
					<div class="font19">${NICKNAME}</div>
					<span class="font10">${ID}</span>
				</div>
				<ul>
					<li>팔로워 <%= request.getAttribute("follower") %></li>
					<li>|</li>
					<li>팔로잉 <%= request.getAttribute("following") %></li>
				</ul>
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
			</div>
			<div id="contents">
					<div><span class="font19">알림</span></div>
					<%
					if (articleList != null) {
						for (int i = 0; i < articleList.size(); i++) {
					%>
					<c:set var="readcount" value="<%=articleList.get(i).getReadCount() %>"/>
					<div class="reply" onclick="noticeRead(<%=i%>)">
						<input type="hidden" value="<%=articleList.get(i).getId() %>" name="noticeId">
						<input type="hidden" value="<%=articleList.get(i).getUrl() %>" name="noticeUrl">
						<ul>
							<c:if test="${readcount eq 0}">
								<li><span style="font-weight: bold; color:rgb(240,93,35);">▶ 새 알림</span></li>
							</c:if>
							<li>
								<div class="replyContentsWrap">
									<div class="replyContents"><%=articleList.get(i).getData() %></div>
								</div>
							</li>
							<li class="replyMenu">
								<span><%=articleList.get(i).getDateTrans() %></span> 
								<span> ᆞ </span> 
								<span>
								<c:choose>
								<c:when test="${readcount eq 0}">
									읽지않음
								</c:when>
								<c:otherwise>
									읽음
								</c:otherwise>	
								</c:choose>
								</span>
							</li>
						</ul>
					</div>
					<hr/>
						<%
							}
							} else {
						%>
							<div id="emptyArea">
								<span>새 알림이 없습니다./span>
							</div>
						<%
							}
						%>
				<div id="page">
					<span> <%
 	if (nowPage <= 1) {
 %> [이전]&nbsp; <%
 	} else {
 %> <a href='vege.user?<%= request.getQueryString().replace("page="+nowPage, "page="+(nowPage-1)) %>'>[이전]</a>&nbsp; <%
 	}
 %> <%
 	for (int a = startPage; a <= endPage; a++) {
 		if (a == nowPage) {
 %> <b style="color:black;">[<%=a%>]</b> <%
 	} else {
 %><a href='vege.user?command=notice&page=<%=a%>'>[<%=a%>]
						</a>&nbsp; <%
 	}
 %> <%
 	}
 %> <%
 	if (nowPage >= maxPage) {
 %> [다음] <%
 	} else {
 %><a href='vege.user?<%= request.getQueryString().replace("page="+nowPage, "page="+(nowPage+1)) %>'>[다음]</a> <%
 	}
 %>
					</span>
				</div>						
						
				</div>
				

		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>