<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.ProductBean"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공동구매</title>


<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>

<link href="styles/communityGonggu.css" rel="stylesheet" type="text/css">

<!-- 지도 api -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>
<% ProductBean product = (ProductBean) request.getAttribute("product"); %>


</head>

<c:if test="${empty ID}">
	out.println("<script>alert("잘못된 접근입니다."); history.go(-1);</script>")
</c:if>

<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap1">
		<section>
			<div class="wrap770">
				<section id="storySection">
				<div class="detailSection">
					주소를 선택해주세요.
					<div class="selectaddress">
							<form id="nsdiSearchForm" action="#" class="form_data" onsubmit="return false;search();">
								<select id="sido_code">
									<option>선택</option>
								</select>
								<select id="sigoon_code">
									<option>선택</option>
								</select>
								<select id="dong_code">
									<option>선택</option>
								</select>
								<select id="lee_code">
									<option>선택</option>
								</select>
							</form>
						</nav>
						<br>
					</div>
					<form id="gongguWriteForm" action="gongguWritePro.cm" method="post"
						name="form2">
						<input type="hidden" value="<%=product.getId() %>" name="productId"> 
						<input type="hidden" value="${ID}" name="memberId"> 
						
						<!-- 주소코드 -->
						<input type="hidden" name="sido_code">
						<input type="hidden" name="sigoon_code">
						<input type="hidden" name="dong_code">
						<input type="hidden" name="lee_code">
						
							
						<div id="optionSelOpen">
							<span>상품정보, 옵션을 확인해주세요.</span>&nbsp;
						</div>
						<div class="detailProductInfo">
							<div class="thumbnail">
								<img src="images/store/<%=product.getImageNo1() %>">
							</div>
							<div class="postTxt">
								<ul>
									<li><%=product.getName() %></li>
									<c:set var="discount"
											value="<%=product.getDiscountRate()%>" />
										<c:choose>
											<c:when test="${discount eq 0}">
												<b><span id="price"><%=product.getPrice()%></span>원</b>
												<br>
											</c:when>
											<c:otherwise>
												<li><font color="F05D23"><%=product.getDiscountRate()%>%</font>
													<span id="price"><%=product.getPrice()%></span> 원 <br>
													<span class="pdtnonsale"><%=product.getPrice()%></span></li>
											</c:otherwise>
										</c:choose>
									
								</ul>
							</div>
							<input type='button' value='옵션변경' class="bigbtn2">
						</div>
						<div>
							<div>
								모집인원 <select name="writePersonnel" id="writeCategory">
									<option>선택</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select> <br>
								<font color="F05D23"> <span id="personnelSelected"></span>명 구매 시 <span id="personnelPrice"></span>원
								</font><br><br>
							</div>
						</div>
						<div>
							<div>
								마감일 <input type="date" name="endDate" id="endDate"> 24시 까지
							</div>
						</div>

						<div>
							<div>
								<input type='text' name='writeTitle' id="writeTitle"
									maxlength="30" placeholder="제목을 입력해주세요.">
							</div>
							<div class="textLength">
								<div class="textCount">0</div>
								<div class="textTotal">/ 30</div>
							</div>
						</div>
						<div>
							<hr id="hr2" />
							<div class="errorTxt"></div>
						</div>
						<div></div>
						<div>
							<textarea name="writeContents" id="writeContents"
								placeholder="내용을 입력해주세요."></textarea>
						</div>
						<input type='submit' value='작성완료' class="bigbtn2"
							id="gongguSubmit">
					</form>
					</div>
				</section>
			</div>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript" src="script/map_location.js"></script>
</body>
</html>