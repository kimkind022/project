<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.CReplyDTO"%>
<%@page import="dto.StoryPostsDTO"%>
<%@page import="dto.GongguDTO"%>
<%@page import="dto.MembersBean"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%
	ArrayList<StoryPostsDTO> storyList = (ArrayList<StoryPostsDTO>) request.getAttribute("storyList");
	ArrayList<GongguDTO> gongguList = (ArrayList<GongguDTO>) request.getAttribute("gongguList");
	ArrayList<MembersBean> memberList = (ArrayList<MembersBean>) request.getAttribute("memberList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>커뮤니티</title>
<style>
</style>

<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>
<link href="styles/community.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" type="text/css" href="slick/slick.css" />
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
<script type="text/javascript" src="slick/slick.min.js"></script>
<script>
$(document).ready(function() {
	$('.single-item').slick({
		dots: true,
		  infinite: true,
		  autoplay: true,
		  speed: 300,
		  slidesToShow: 1,
	});
});
</script>
</head>
<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap0">
		<section>
			<div class="wrap1200">
				<div id="cSlider">
					<div class="cSlider1">
						<img src="images/community/<%=storyList.get(0).getThumbnail() %>">
						<div class="cSlider1Txt" style="position: absolute;">
							<div>
								<span><%=storyList.get(0).getTitle()%></span>
								<div class="cSliderprofile">
									<div id="small_profilePic" style="margin-top: 3px;">
									<c:set var="profileImg"
									value="<%=memberList.get(0).getProfileImage()%>" />
								<c:choose>
									<c:when test="${empty profileImg}">
										<img src="images/common/emptyMember.png">
									</c:when>
									<c:otherwise>
										<img
											src="images/profileImages/<%=memberList.get(0).getProfileImage()%>">
									</c:otherwise>
								</c:choose>
								</div>
									<span><%=storyList.get(0).getNickname()%></span>
								</div>
							</div>
							<div class="cSliderBtn" onclick="location.href='storyDetail.cm?id=<%=storyList.get(0).getId()%>&page=1'">보러가기</div>
						</div>
						<!-- 좋아요 순 상위 3개 -->
					</div>
					<div class="cSlider2">
						<div class='single-item'>
							<div onclick="location.href='fundingDetail.fd?id=11'">
								<img src="images/community/banner1.jpg">
							</div>
							<div>
								<img src="images/community/banner2.jpg">
							</div>
							<div>
								<img src="images/community/banner3.jpg">
							</div>
							<div>
								<img src="images/community/banner4.jpg">
							</div>
						</div>
					</div>
				</div>
				
				<hr/>
				<div class="container1">
					<div class="titleDiv">
						<div class="containerTitle">인기회원</div>
					</div>
					
					<input type="hidden" value="${ID}" name="memberId"> 
					<div class="multiple-items1">
						<%
							for (int i = 0; i < 3; i++) {
						%>
						<input type="hidden" value="<%=memberList.get(i).getId() %>" name="writerId">
						<div class="contents1">
							<div>
								<img src="images/common/medal<%=i+1 %>.png" style="width:50px;">
								<%=memberList.get(i).getNickname()%></div>
							<div class="profileImg2">
								<c:set var="profileImg"
									value="<%=memberList.get(i).getProfileImage()%>" />
								<c:choose>
									<c:when test="${empty profileImg}">
										<img src="images/common/emptyMember.png">
									</c:when>
									<c:otherwise>
										<img
											src="images/profileImages/<%=memberList.get(i).getProfileImage()%>">
									</c:otherwise>
								</c:choose>

							</div>
							<div class="profileTxt">
								<ul>
									<li><b>팔로워 <%=memberList.get(i).getFollowerCount()%></b></li>
									<li style="color: gray;">작성한 스토리 <%=memberList.get(i).getStoryCount()%></li>
								</ul>
								<c:set var="follow" value="<%=memberList.get(i).getIsFollow() %>" />
								<c:choose>
									<c:when test="${follow==1}">
										<div class="followBtn" onclick="unfollow(<%=i %>)">팔로잉</div>
									</c:when>
									<c:otherwise>
										<div class="followBtn2" onclick="follow(<%=i %>)">+ 팔로우</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>

				<div id="menu">
					<div onclick="location.href='storyList.cm?page=1'">
						<ul>
							<li>레시피부터 노하우까지 꿀팁 총 집합</li>
							<li>스토리</li>
						</ul>
						<span>></span>
					</div>
					<div onclick="location.href='gongguList.cm?page=1'">
						<ul>
							<li>대용량 상품, 구입이 망설여진다면</li>
							<li>공동구매</li>
						</ul>
						<span>></span>
					</div>
					<div onclick="location.href='communityMain.jsp'">
						<ul>
							<li>내 주변에는 어떤 시장이?</li>
							<li>우리동네 장터찾기</li>
						</ul>
						<span>></span>
					</div>
				</div>



				<div class="container">
					<div class="titleDiv">
						<div class="containerTitle">오늘의 스토리</div>
					</div>
					<div class="multiple-items2">

						<%
							for (int i = 0; i < 4; i++) {
						%>
						<div class="contents"
							onclick="location.href='storyDetail.cm?id=<%=storyList.get(i).getId()%>&page=1'">
							<div class="postImg">
								<img src="images/community/<%=storyList.get(i).getThumbnail()%>">
							</div>
							<div class="postTxt"><%=storyList.get(i).getTitle()%></div>

							<div class="postProfile">
								<div id="small_profilePic" style="margin-top: 3px;">
									<c:set var="profileImg"
										value="<%=storyList.get(i).getProfileImage()%>" />
									<c:choose>
										<c:when test="${empty profileImg}">
											<img src="images/common/emptyMember.png">
										</c:when>
										<c:otherwise>
											<img
												src="images/profileImages/<%=storyList.get(i).getProfileImage()%>">
										</c:otherwise>
									</c:choose>
								</div>
								<span><%=storyList.get(i).getNickname()%> ᆞ <%=storyList.get(i).getDateTrans()%></span>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>


				<div class="container3">
					<div class="titleDiv">
						<div class="containerTitle">내 주변 공동구매</div>
					</div>
					<div class="myLocation">
						<img src="images/common/location2.png" style="width: 25px;">
						ㅇㅇ시 ㅇㅇ구 ㅇㅇ동
					</div>
					<div class="multiple-items2">
						<%
							for (int i = 0; i < 3; i++) {
						%>
						<div class="contents3">
							<div class="cPdtInfo">
								<div class="pdtImg"
									onclick="location.href='storeProductDetail.pd?id=<%=gongguList.get(i).getProductBean().getId()%>'">
									<img
										src="images/store/<%=gongguList.get(i).getProductBean().getImageNo1()%>">
								</div>
								<div class="gongguTxt"
									onclick="location.href='storeProductDetail.pd?id=<%=gongguList.get(i).getProductBean().getId()%>'">
									<ul>
										<li><%=gongguList.get(i).getProductBean().getName()%></li>
										<c:set var="discount"
											value="<%=gongguList.get(i).getProductBean().getDiscountRate()%>" />
										<c:choose>
											<c:when test="${discount eq 0}">
												<b><%=gongguList.get(i).getProductBean().getPrice()%> 원</b>
												<br>
											</c:when>
											<c:otherwise>
												<li><font color="F05D23"><%=gongguList.get(i).getProductBean().getDiscountRate()%>%</font>
													<%=gongguList.get(i).getProductBean().getPrice()%> 원 <br>
													<span class="pdtnonsale"><%=gongguList.get(i).getProductBean().getPrice()%></span></li>
											</c:otherwise>
										</c:choose>

										<li><span class="progressValue">▶ <%=gongguList.get(i).getPersonnel() + 1%>명
												구매 시 <%=gongguList.get(i).getProductBean().getPrice() / (gongguList.get(i).getPersonnel() + 1)%>원
										</span></li>
									</ul>
								</div>
							</div>

							<div class="gongguTxt"
								onclick="location.href='gongguDetail.cm?id=<%=gongguList.get(i).getId()%>&page=1'">
								<ul>
									<li><c:set var="title"
											value="<%=gongguList.get(i).getTitle()%>" /> <!-- 글자수가 10자 이상이면 자른다 -->
										<c:choose>
											<c:when test="${fn:length(title) gt 14}">
												<b>${fn:substring(title,0,14)} ...</b>
											</c:when>
											<c:otherwise>
												<b>${title}</b>
											</c:otherwise>
										</c:choose></li>
									<li><%=gongguList.get(i).getNickname()%></li>
									<li><span class="font10">n월 n일 까지 &nbsp;&nbsp;<%=gongguList.get(i).getEndDateTrans()%>
											마감
									</span></li>
									<!-- progress, 마감 시 회색 -->
									<%
										if (gongguList.get(i).getPersonnelval() == gongguList.get(i).getPersonnel()|| gongguList.get(i).getEndDateTrans().contains("전")) {
									%>
									<li><progress class="progressEnd"
											value="<%=gongguList.get(i).getPersonnelval()%>" min="0"
											max="<%=gongguList.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressEndValue"><%=gongguList.get(i).getPersonnelval()%>/<%=gongguList.get(i).getPersonnel()%>
											마감된 공동구매입니다.</span> <%
 	} else {
 %>
									<li><progress class="progress"
											value="<%=gongguList.get(i).getPersonnelval()%>" min="0"
											max="<%=gongguList.get(i).getPersonnel()%>"></progress></li>
									<li><span class="progressValue"><%=gongguList.get(i).getPersonnelval()%>/<%=gongguList.get(i).getPersonnel()%>
											모집중 </span></li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>

			</div>
		</section>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	</section>
	</div>
</body>
</html>

