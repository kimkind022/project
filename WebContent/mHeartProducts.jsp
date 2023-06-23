<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.ProductBean"%>
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
	ArrayList<ProductBean> articleList = (ArrayList<ProductBean>) request.getAttribute("data");
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
					<li class="nowpage"><a
						href="vege.user?command=myHeart_products">상품</a></li>
					<li><a href="vege.user?command=myHeart_story">스토리</a></li>
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
				<div class="heartPdtContents" onclick="location.href='storeProductDetail.pd?id=<%=articleList.get(i).getId()%>'">
					<div class="heartPdtImg">
						<img src="images/store/<%=articleList.get(i).getImageNo1()%>">
					</div>
					<div class="gongguTxt">
						<ul>
							<li>[<%=articleList.get(i).getSellerId()%>]</li>
							<li class="font13"><%=articleList.get(i).getName()%></li>
							<li>&nbsp;</li>
							<li><c:set var="onSale"
									value="<%=(articleList.get(i).getPrice())* (1 - (articleList.get(i).getDiscountRate() / 100.0))%>" />
								<c:choose>
									<c:when test="${discount ne 0}">
										<b><%=articleList.get(i).getPrice()%> 원</b>
										<br>
									</c:when>
									<c:otherwise>
										<font color="F05D23"><%=articleList.get(i).getDiscountRate()%>%</font>
										<fmt:formatNumber value="${onSale}" pattern="00" />원 <br>
										<span class="pdtnonsale"><%=articleList.get(i).getPrice()%></span>
									</c:otherwise>
								</c:choose>
							</li>
						</ul>
					</div>
				</div>
				<%}} %>
			</div>
		</section>




	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>