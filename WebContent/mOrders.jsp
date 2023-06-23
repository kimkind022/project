<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.OrderBean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	ArrayList<OrderBean> articleList = (ArrayList<OrderBean>) request.getAttribute("data");
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

<script type="text/javascript" src="script/mPush.js"></script>
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
					<li class="nowpage"><a href="vege.user?command=myOrder">나의 쇼핑</a></li>
					<li><a href="vege.user?command=myFunding">나의 펀딩</a></li>
					<li><a href="vege.user?command=editUserInfo">설정</a></li>
				</ul>
			</div>
			<hr />
		</nav>
		<nav class="mypageNav">
			<div>
				<ul>
					<li class="nowpage"><a href="vege.user?command=myOrder">주문배송내역
							조회</a></li>
					<li>리뷰</li>
				</ul>
			</div>
			<hr />
		</nav>

		<section id="section1200">
			<div>
				<div>
					<p class="font19">주문배송내역</p>
				</div>
				<div class="wrap1200">
					<div class="order">
						<span>&nbsp;</span>
						<div class="price">
							<span>입금대기</span> <span>0</span>
						</div>
						<img src="images/common/next2.png" style="width: 20px;">
						<div class="price">
							<span>결제완료</span> <span>0</span>
						</div>
						<img src="images/common/next2.png" style="width: 20px;">
						<div class="price">
							<span>배송준비</span> <span>0</span>
						</div>
						<img src="images/common/next2.png" style="width: 20px;">
						<div class="price">
							<span>배송중</span> <span>0</span>
						</div>
						<img src="images/common/next2.png" style="width: 20px;">
						<div class="price">
							<span>배송완료</span> <span><%=articleList.size() %></span>
						</div>
						<span>&nbsp;</span>
					</div>
				</div>
				<div class="wrap1200">

					<%
						if (!articleList.isEmpty()) {
							for (int i = 0; i < articleList.size(); i++) {
					%>
					<c:set var="date" value="<%=articleList.get(i).getOrderDate()%>"/>
					<b>주문번호 : <%=articleList.get(i).getOrderId() %> | 주문일자 : ${fn:substring(date,0,10)}</b>
					<!-- 주문번호/주문일 -->
					<hr class="hr2" />
					<div class="order">
						<div>
							<div class="gongguImg"  onclick="location.href='storeProductDetail.pd?id=<%=articleList.get(i).getProductId()%>'">
								<img src="images/store/<%=articleList.get(i).getProductBean().getImageNo1()%>">
							</div>
							<div class="gongguTxt">
								<ul>
									<li><%=articleList.get(i).getProductBean().getSellerId()%></li>
									<li class="font13"><%=articleList.get(i).getProductBean().getName()%></li>
									<li>&nbsp;</li>
									<li>
										<c:set var="onSale" value="<%=(articleList.get(i).getProductBean().getPrice()) * (1-(articleList.get(i).getProductBean().getDiscountRate()/100.0))%>"/>
										<c:choose>
										<c:when test="${discount ne 0}">
											<b><%=articleList.get(i).getProductBean().getPrice()%> 원</b>
											<br>
										</c:when>
										<c:otherwise>
											<font color="F05D23"><%=articleList.get(i).getProductBean().getDiscountRate()%>%</font>
												<fmt:formatNumber value="${onSale}" pattern="00"/>원 <br>
												<span class="pdtnonsale"><%=articleList.get(i).getProductBean().getPrice()%></span>
										</c:otherwise>
										</c:choose>
									</li>
								</ul>
							</div>
						</div>
						<div class="price">
							<span><c:set var="discount"
										value="<%=articleList.get(i).getProductBean().getDiscountRate()%>" />
									<c:choose>
										<c:when test="${discount eq 0}">
											<b><%=articleList.get(i).getProductBean().getPrice()*articleList.get(i).getOrderAmount() %> 원</b>
										</c:when>
										<c:otherwise>
											<b><%=articleList.get(i).getProductBean().getPrice()*articleList.get(i).getOrderAmount()%> 원</b>
										</c:otherwise>
									</c:choose> </span>&nbsp; | &nbsp;<span><%=articleList.get(i).getOrderAmount()%> 개</span>
						</div>
						<div>
							배송완료 (일반택배)
						</div>
						<button class="bigbtn" onclick="location.href='reviewWrite.jsp?id=<%=articleList.get(i).getProductId()%>&orderId=<%=articleList.get(i).getOrderId() %>'"> 리뷰작성 </button>
					</div>
					<div>&nbsp;</div>
					<%
						}
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