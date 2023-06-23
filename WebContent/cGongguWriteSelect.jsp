<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="dto.BasketBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ProductBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<%
	ArrayList<BasketBean> addedInBasket = (ArrayList<BasketBean>)request.getAttribute("addedInBasket");
    ArrayList<String> a = new ArrayList<String>();
	List<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");
%>
</head>

<c:if test="${empty ID}">
	out.println("<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>")
</c:if>

<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap1">
		<section>
			<div class="wrap770">
				<section id="storySection">
					<div class="detailSection">
						<b>상품을 선택해주세요.</b> <font color="gray"><br>장바구니에 담은 상품이
							표시됩니다.</font>
						<form id="gongguWriteForm">
						<%if (addedInBasket.size()!=0){
							for(int i=addedInBasket.size()-1; i>=0; i--) { 
						%>
							<div class="detailProductInfo">
								<div class="thumbnail">
									<img src="images/store/<%=productList.get(i).getImageNo1()%>">
								</div>
								<div class="postTxt">
									<ul>
										<li><%= productList.get(i).getName() %></li>
										<c:set var="discount"
											value="<%=productList.get(i).getDiscountRate()%>" />
										<c:choose>
											<c:when test="${discount eq 0}">
												<b><%=addedInBasket.get(i).getPrice()%>
													원</b>
												<br>
											</c:when>
											<c:otherwise>
												<li><font color="F05D23"><%=productList.get(i).getDiscountRate()%>%</font>
													<%=addedInBasket.get(i).getPrice()%> 원 <br>
													<span class="pdtnonsale"><%=addedInBasket.get(i).getPrice()%></span></li>
											</c:otherwise>
										</c:choose>
									</ul>
								</div>
								<input type='button' value='선택' class="bigbtn2" onclick="location.href='gongguWriteForm.cm?product=<%= productList.get(i).getId() %>'">
							</div>
						<%	}
						} else {%>
						<div id="emptyArea">
								<span>장바구니에 상품이 없습니다.</span>
								<span><a href="storeMain.pd">▶ 스토어 구경하기</a></span>
							</div>
						<%
							}
						%>
						<div>
						</div>
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