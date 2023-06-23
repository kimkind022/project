<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.GongguDTO"%>
<%@page import="dto.ProductBean"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	GongguDTO article = (GongguDTO) request.getAttribute("article");
	String nowPage = request.getParameter("page");
	ProductBean product = (ProductBean) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공동구매</title>


<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>

<link href="styles/communityGonggu.css" rel="stylesheet" type="text/css">
<!-- 지도 api -->
<link rel="stylesheet" href="http://openlayers.org/en/latest/css/ol.css"
	type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v5.3.0/build/ol.js"></script>



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
						<div class="postSubTitle">
							<img src="images/common/location2.png" style="width: 25px;">
							<%=article.getSido_code()%>&nbsp;
							<%=article.getSigoon_code()%>&nbsp;
							<%=article.getDong_code()%>&nbsp;
							<%
								if (!article.getLee_code().equals("0")) {
									out.println(article.getLee_code());
								} else {
							%>
							&nbsp;
							<%
								}
							%>
						</div>
					<br>
					<form id="gongguUpdateForm" action="gongguUpdatePro.cm?id=<%=article.getId()%>&page=<%=nowPage%>" method="post"
						name="form2">
						<input type="hidden" value="1" name="productId"> 
						<input type="hidden" value="${ID}" name="memberId"> 
							
						<div>상품정보, 옵션을 확인해주세요.</div>
						<div class="detailProductInfo">

							<div class="thumbnail">
								<img src="images/store/<%=product.getImageNo1() %>">
							</div>
							<div class="postTxt">
								<ul>
									<li><%=product.getName() %></li>
									<li><c:set var="discount" value="<%=product.getDiscountRate() %>"/>
									<c:choose>
										<c:when test="${discount eq 0}">
											<b><fmt:formatNumber value="<%=product.getPrice() %>" pattern="###,###,###,###,###,###" /> 원</b> <br> 
										</c:when>
										<c:otherwise>
											<li><font color="F05D23"><%=product.getDiscountRate()%>%</font> 
												<fmt:formatNumber value="<%=product.getPrice() %>" pattern="###,###,###,###,###,###" /> 원 <br> 
												<span class="pdtnonsale"><%=product.getPrice() %></span></li>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
							<div style="width:60px;">
							</div>
							<input type='button' value='옵션변경' class="followBtn">
						</div>
						<div>
							<div>
								<input type="hidden" value="<%=article.getPersonnel()%>" name="selectedPersonnel">
								모집인원 <select name="updatePersonnel" id="writeCategory" disabled>
									<option>선택</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select> <br> <font color="F05D23"> <span
									id="personnelSelected"><%=article.getPersonnel()+1%></span>명 구매 시 <span id="personnelPrice"> <%=product.getPrice() / (article.getPersonnel() + 1)%></span>원
								</font>
							</div>
						</div>

						<div>
							<div>
								<input type='text' name='updateTitle' id="writeTitle"
									maxlength="30" placeholder="제목을 입력해주세요." value="<%=article.getTitle()%>">
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
							<textarea name="updateContents" id="writeContents"
								placeholder="내용을 입력해주세요."><%=article.getContents()%></textarea>
						</div>
							<input type='submit' value='작성완료' class="bigbtn2" id="gongguSubmit">
					</form>
					</div>
				</section>
			</div>
		</section>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript" src="script/mapApi.js"></script>
</body>
</html>