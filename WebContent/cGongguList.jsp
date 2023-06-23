<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.GongguDTO"%>
<%@ page import="java.util.*"%>
<%@page import="dto.CReplyDTO"%>
<%@page import="java.util.ArrayList"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%
	ArrayList<GongguDTO> articleList = (ArrayList<GongguDTO>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	String status1 = pageInfo.getStatus1();
	String status2 = pageInfo.getStatus2();
	ArrayList<GongguDTO> markerList = (ArrayList<GongguDTO>) request.getAttribute("markerList");
%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공동구매 전체보기</title>

<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>

<link href="styles/communityGonggu.css" rel="stylesheet" type="text/css">



<!-- 지도 api -->
<link rel="stylesheet" href="http://openlayers.org/en/latest/css/ol.css"
	type="text/css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87a6a025a5963b5b4156ee175dd459a8&libraries=services,clusterer"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>



</head>
<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap0">
		<section>
			<div class="wrap1200">

				<!-- 퀵메뉴, 글 작성 클릭 시 로그인 확인 -->
				<div id="quickmenu">
					<c:choose>
						<c:when test="${empty ID}">
							<a href="login.jsp">
						</c:when>
						<c:otherwise>
							<a href="gongguWriteSelect.cm">
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
				<section id="gongguSection">
					<input type="hidden" value=<%=status1 %> name="status1">
					<header id="gongguHeader">
						<div class="title">공동구매</div>
						<nav id="categoryIcon">
							<span>카테고리 선택</span>
							<div
								onclick="location.href='gongguList.cm?status1=vegetable&page=1';">
								<div>
									<img src="images/common/vegetable.png" />
								</div>
								<span>채소</span>
							</div>
							<div
								onclick="location.href='gongguList.cm?status1=fruit&page=1';">
								<div>
									<img src="images/common/fruit.png" />
								</div>
								<span>과일</span>
							</div>
							<div
								onclick="location.href='gongguList.cm?status1=grain&page=1';">
								<div>
									<img src="images/common/grain.png" />
								</div>
								<span>쌀/곡류</span>
							</div>
							<div onclick="location.href='gongguList.cm?status1=jam&page=1';">
								<div>
									<img src="images/common/jam.png" />
								</div>
								<span>청/잼류</span>
							</div>
							<div onclick="location.href='gongguList.cm?page=1';">
								<div>
									<img src="images/common/showmore.png" />
								</div>
								<span>전체보기</span>
							</div>
							<%
								if (markerList != null) {
									for (int i = 0; i < markerList.size(); i++) {
							%>
							<!-- 지도에 표시할 마커 위치값 -->
							<%
								if (markerList.get(i).getLee_code().equals("0")) {
							%>
							<input type="hidden" name="marker"
								value="<%=markerList.get(i).getSido_code() + ' ' + markerList.get(i).getSigoon_code() + ' '
								+ markerList.get(i).getDong_code()%>">
							<%
								} else if (!markerList.get(i).getLee_code().equals("0")) {
							%>
							<input type="hidden" name="marker"
								value="<%=markerList.get(i).getSido_code() + ' ' + markerList.get(i).getSigoon_code() + ' '
								+ markerList.get(i).getDong_code() + ' ' + markerList.get(i).getLee_code()%>">
							<%
								}
									}
								}
							%>
						</nav>
						<div id="mapImg">
							<div id="map" style="width: 600px; height: 420px;"></div>
						</div>

						<nav id="locationSelect">
							시/군/구 선택
							<form id="nsdiSearchForm" action="#" class="form_data"
								onsubmit="return false;search();">
								<select id="sido_code">
									<option>선택</option>
								</select><br> <select id="sigoon_code">
									<option>선택</option>
								</select><br> <select id="dong_code">
									<option>선택</option>
								</select><br> <select id="lee_code">
									<option>선택</option>
								</select><br> 
								
								<input type="hidden" name="sido_code"> 
								<input type="hidden" name="sigoon_code"> 
								<input type="hidden" name="dong_code"> 
								<input type="hidden" name="lee_code">
								
								<input type="button" value="선택완료" class="followBtn" onclick="gongguStauts()">
							</form>
						</nav>
					</header>
					
					<div class="postSubTitle">
						<img src="images/common/location2.png" style="width: 25px;">
						<c:set var="status2" value="<%=status2 %>"/>
						<c:choose>
							<c:when test="${status2 ne 'empty'}">
								${fn:replace(status2, "-"," ")}
							</c:when>
							<c:otherwise>
								지역 전체보기
							</c:otherwise>
						</c:choose>
					</div>
					<input type="hidden" value="${ID}" name="memberId"> 
					<input type="hidden" value="gonggu" name="postType">

					<div id="gongguContainer">

						<%
							if (articleList != null && listCount > 0) {
								for (int i = 0; i < articleList.size(); i++) {
						%>

						<hr />
						<div class="gongguPost">
							<div class="productInfo">
								<div class="thumbnail">
									<img
										src="images/store/<%=articleList.get(i).getProductBean().getImageNo1()%>">
								</div>
								<div class="postTxt">
									<ul>
										<li><%=articleList.get(i).getProductBean().getName()%></li>
										<c:set var="discount"
											value="<%=articleList.get(i).getProductBean().getDiscountRate()%>" />
										<c:choose>
											<c:when test="${discount eq 0}">
												<b><fmt:formatNumber value="<%=articleList.get(i).getProductBean().getPrice()%>" pattern="###,###,###,###,###,###" />
													원</b>
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
								</div>
							</div>


							<a
								href="gongguDetail.cm?id=<%=articleList.get(i).getId()%>&page=<%=nowPage%>">
								<div class="postTxt">
									<ul>
										<li><h3><%=articleList.get(i).getTitle()%></h3></li>
										<li><%=articleList.get(i).getNickname()%></li>
										<li><font color="gray">
												<c:set var="endDateVal" value="<%=articleList.get(i).getEndDate() %>"/>
												<fmt:formatDate value="${endDateVal }" pattern="MM월 dd일 까지"/>  
												&nbsp;&nbsp; <%=articleList.get(i).getEndDateTrans()%> 마감
										</font></li>
										<!-- progress, 마감 시 회색 -->
										<%
											if (articleList.get(i).getPersonnelval() == articleList.get(i).getPersonnel() || articleList.get(i).getEndDateTrans().contains("전"))  {
										%>
										<li><progress class="progressEnd"
												value="<%=articleList.get(i).getPersonnelval()%>" min="0"
												max="<%=articleList.get(i).getPersonnel()%>"></progress></li>
										<li><span class="progressEndValue"><%=articleList.get(i).getPersonnelval()%>/<%=articleList.get(i).getPersonnel()%>
												마감된 공동구매입니다. <%
											} else {
										%>
												<li><progress class="progress"
														value="<%=articleList.get(i).getPersonnelval()%>" min="0"
														max="<%=articleList.get(i).getPersonnel()%>"></progress></li>
												<li><span class="progressValue"><%=articleList.get(i).getPersonnelval()%>/<%=articleList.get(i).getPersonnel()%>
														모집중 </span></li> <%
									 	}
									 %>
									</ul>
								</div>
							</a>
							<div class="replyCount">
								<!-- 게시글 아이디 -->
								<input type="hidden" name="postId"
									value="<%=articleList.get(i).getId()%>">
								<ul>
									<li><img src="images/common/comment2.png"><br><%=articleList.get(i).getReplyCount()%>
										<!-- 댓글 --></li>
									<li><img src="images/common/mail2.png"><br>0
										<!-- 쪽지 --></li>
									<li><div id="postHeart">
											<c:set var="isMemberLiked"
												value="<%=articleList.get(i).getIsMemberLiked()%>" />
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
											<br><%=articleList.get(i).getHeartCount()%>
										</div> <!-- 좋아요 --></li>
								</ul>
								<span class="font10"><%=articleList.get(i).getReadCount()%>
									views</span>
							</div>

						</div>

						<%
							}
							} else {
						%>
							<div id="emptyArea">
								<span>아직 등록된 공동구매가 없습니다.</span>
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
 %> <a href='gongguList.cm?<%= request.getQueryString().replace("page="+nowPage, "page="+(nowPage-1)) %>'>[이전]</a>&nbsp; <%
 	}
 %> <%
 	for (int a = startPage; a <= endPage; a++) {
 		if (a == nowPage) {
 %> [<%=a%>] <%
 	} else {
 %><a href='gongguList.cm?<%= request.getQueryString().replace("page="+nowPage, "page="+a ) %>'>[<%=a%>]
						</a>&nbsp; <%
 	}
 %> <%
 	}
 %> <%
 	if (nowPage >= maxPage) {
 %> [다음] <%
 	} else {
 %><a href='gongguList.cm?<%= request.getQueryString().replace("page="+nowPage, "page="+(nowPage+1)) %>'>[다음]</a> <%
 	}
 %>
						</span>
					</div>
				</section>
			</div>
		</section>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript" src="script/map_kakao.js"></script>
	<script type="text/javascript" src="script/map_location.js"></script>
</body>
</html>
