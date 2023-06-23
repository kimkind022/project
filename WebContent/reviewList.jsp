<%@page import="dto.ProductBean"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%	
	ArrayList<BoardBean> articleList=(ArrayList<BoardBean>)request.getAttribute("articleList");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>

<%
	ProductBean productList = (ProductBean)request.getAttribute("productList");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.section0{
		background-color: rgb(234 234 234); 
		width: 1200px;
		height: 1400px;
		margin: 0 auto;
	}
	
	/* 사진들과 오른쪽 정보들을 담고 있는 큰 박스 */	
	.section1{
		width: 1200px;
		height: 900px;
		background-color: rgb(125 161 248); 
		display:flex;
		justify-content: space-between;
		
	}
	
	/* 왼쪽, 하늘색, 사진들을 감싸고 있는 div*/
	.product-overview-image-Wrap{	
		width:768px;
		background-color: rgb(139 156 196);  /* 어두운 하늘 */
	}
	
	/* 메인이미지를 감싸고 있는 div */
	.mainImage{
		width:768px;
		height:600px;
		background-color: rgb(194 210 247); /* 최상단 밝은하늘 */
	}
	
	/* 서브이미지들을 갖고 있는 ul을 감싸고 있는 div */
	.subImages-Container{
		width:768px;
		height:100px;
		background-color: rgb(146 173 237); /* 중간하늘 */
	
	}
	/* ul */
	.subImages{
		width:600px;
		heigth:200px;
		background-color: rgb(); 
		display: flex;
	}
	
	.subImages li{
		padding-left: 20px;
	}
	
	/* 오른쪽, 보라색, 상품 가격 등을 감싸고 있는 div */ 
	.product-overview-content{
		width:432px;		
		background-color: rgb(173 145 202);
	}
	
	/* 내비게이션, 상품-리뷰-문의 */
	.product-navigation-content{
		max-width: 1136px;
		height: 50px;
  		margin: 0 auto;
  		margin-left: 0px;
  		font-size: 15pt;
  		
  		
	}
	ol, ul{
	 	listy-style:none;"
	 	margin: 0 0 0 0;
	 	padding: 0 0 0 0;
	 	
	}
	.product-navigation-ul{
		width: 66.6%;
		height: 50px;
		display: flex;
	}
	.product-navigation-ul li{
		width: 100px;
		text-align: center;
   		padding-left: 50px;
   		padding-top: 10px;
	}


	.product-info{
		width: 768px;
		background-color: rgb(255 207 159);
	}




	/* 리뷰, 문의, */
	.section2{
		background-color: beige;
		width: 1200px;
		
	}
	
	.ratingBox{
		width: 768px;
		height: 200px;
		background-color: rgb(240 239 238);
		border-radius: 8px;
 	    text-align: center;
 	    margin: 16px 0 24px;
	}
	.ratingBoxInner{
		width: 768px;
		height: 150px;
		padding: 24px 0;
	    display: flex;
    }
	
	.starBadgeBox{
		width: 50%;
		
    	border-right: 1px solid rgb( 0 0 0 );
		
	}
	.starAverageBox{
		width: 50%;
	}
	.filter-best-recent{
		width: 768px;
		height: 50px;
		background-color: rgb(240 239 238);
		border: 1px;
		border-top: solid;
		border-bottom: solid;
		border-color: grey;
		padding-top:10px;
		padding-bottom:10px;
	}
	
	.filter-best-recent-left{
		float:left;
		display: flex;
		
	}
	.filter-best-recent-left > div {
		width:100px;
	}
	
	
	.filter-best-recent-right{
		float:right;
	}
	.orderbyBest{
		
	}
	.reviewListContainer{
		width:768px;
		background-color: rgb(255 224 229);
	}
	.consumerInfo{
		width:500px;
		display: flex;
		padding: 10px 0 10px 0;
	}
	.chosenOptions{
		padding: 0 0 10px 0;
		
	}
	.profilePic{
		width:70px;
		height:70px;
		background-color: rgb(225 255 224);
			
	}
	.photoReview{
		width:120px;
		height:120px;
		padding: 0 0 10px 0;
		background-color: rgb(255 242 63);
	}
	
	
	
	
	
	
	
	
	.product-price{
 		width: 100px;
 		color: grey;
	}
	.product-calculatedPrice{
		font-size: 15pt;
	}
	
	.product-option-form-button-wrap{
		width:600px;
		display:flex;		
	}
	.product-option-form-button-wrap > button{
		width : 200px;
		height: 50px;
		justify-content: space-between;
		margin-left: 10px;
	}
	
	
	#boardsForm{
		background-color: #dddddd; /* 회색 */
		width: 1200px;
	}
	
	.reviewContent{
	    font-size: 15px;
	    line-height: 21px;
	    letter-spacing: normal;
	    color: #424242;
	    padding: 0 0 10px 0;
	}
	.reviewUnderline{
	    border: 0;
	    height: 1px;
	    background-color: rgb(120 120 120);
	}
		
	#pageList{
		width:768px;
	    text-align: center;
	}
	
</style>
</head>
<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	
	<section class="section0">
		<!-- section1 : 사진들과 오른쪽 정보들을 담고 있는 큰 박스 -->
		<div class="section1">
			
			<!-- 사진관련 큰메인사진,썸네일5개 -->
			<div class="product-overview-image-Wrap">
				<div class="mainImage">
				</div>
				<div class="subImages-Container">	
					<ul class="subImages">
						<li style="width:100px; height:100px;">
							 <img src="images/store/appleImages/<%=productList.getImageNo1()%>" width="100px">	
						</li>
						<li style="width:100px; height:100px;">
							<img src="images/store/appleImages/<%=productList.getImageNo2()%>" width="100px">	
						</li>
						<li style="width:100px; height:100px;">
							<img src="images/store/appleImages/<%=productList.getImageNo3()%>" width="100px">
						</li>
						<li style="width:100px; height:100px;">
  							<img src="images/store/appleImages/<%=productList.getImageNo4()%>" width="100px">	
						</li>
						<li style="width:100px; height:100px;">
							<img src="images/store/appleImages/<%=productList.getImageNo5()%>" width="100px">	
						</li>
					</ul>
				</div>	
			</div>
			
			
			<div class="product-overview-content">
				<p><%=productList.getSellerId() %></p>
				<h1 class="product-title"> 
					<%=productList.getName() %>
				</h1>
				
				<!-- 가격관련 -->
				<div class="product-price-wrap">
					<span class="product-discountRate">
						<%=productList.getDiscountRate() + "%" %>
					</span>
					<span class="product-price">
						<del><%=productList.getPrice()%></del>					
					</span>
					<div class="product-calculatedPrice">
						<% double result = (1- (productList.getDiscountRate() / 100.0) ) * (  productList.getPrice()  );
							out.println((int)result + "원");	
					    %> 
					</div>
				</div>
				
				
				<!-- 가격합계 -->
								
				<!-- 장바구니, 바로구매 싸고있는 div-->
				<div class="product-option-form-button-wrap">
					<button class="button">장바구니</button>
					<button class="button">바로구매</button>
				</div>	
				
			</div>
		</div>
		
		<nav class="product-navigation-content">
			<ul class="product-navigation-ul">
				<a href="#product-info"><li>상품정보</li></a>
				<a href="#reviewList"><li>리뷰</li></a>
				<a href=""><li>문의</li></a>
				<li><%out.println(productList); %></li>
			</ul>
		</nav>

		<!-- section2 -->
		<div class="section2">
			<!-- 상품정보 -->
			<div class="product-info">
				<a name="product-info"><img src="images/store/appleImages/<%=productList.getInfo()%>"></a>	
			</div>
		
		
			<!-- 리뷰, 문의 게시판 리스 -->
			<div id="boardsForm">
				<!-- table div 게시판 리스트-->
				<div id="reviewList">
					<h1>리뷰 <%= articleList.size() %></h1>
					<div class="ratingBox"> 
						<div class="ratingBoxInner">
							<div class="starBadgeBox">
								별
							</div>
							<div class="starAverageBox">
								그래프
							</div>
						</div>
					</div>
					
					<div class="filter-best-recent">
						<div class="filter-best-recent-left">
							<div class="orderbyBest"> 
								베스트순
							</div>
							<div class="orderbyRecent">
								최신순
							</div>
							<div>
								사진리뷰만	
							</div>
						</div>
						
						<div class="filter-best-recent-right">
							<div>
								별점
							</div>
						</div>
					</div>
					<div class="reviewListContainer">
					<% 
						if(articleList != null && listCount > 0){ 
							for(int i=0;i<articleList.size();i++){
					%>
						<div class="consumerInfo">
							<div class="profilePic">
								profile사진
							</div>
							<div class="">
								<p>nickname: <p>
								<p>리뷰작성일: <%=articleList.get(i).getDate() %></p>
								<p>상품구매일:	
								<p>평점: <%=articleList.get(i).getRating() %> </p>
							</div>	
						</div>	
						<div class="chosenOptions">
							<p>구매한상품명 : <%=articleList.get(i).getOrderId()%></p>
							<p>선택한상품옵션ex.Color</p>
						</div>
						<div class="photoReview">
							<img src="images/uploadFile/<%=articleList.get(i).getFile()%>">
						</div>
						<div class="reviewContent">
							<%=articleList.get(i).getContents() %>
						</div>
						<hr class="reviewUnderline">							
						<%} %>
						
						<div id="pageList">	페이지 숫자 
							<%if(nowPage<=1){ %>
							[이전]&nbsp;
							<%}else{ %>
							<a href="reviewsList.pd?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
							<%} %>
					
							<%for(int a=startPage;a<=endPage;a++){
									if(a==nowPage){%>
							[<%=a %>]
							<%}else{ %>
							<a href="reviewsList.pd?page=<%=a %>">[<%=a %>]
							</a>&nbsp;
							<%} %>
							<%} %>
					
							<%if(nowPage>=maxPage){ %>
							[다음]
							<%}else{ %>
							<a href="reviewsList.pd?page=<%=nowPage+1 %>">[다음]</a>
							<%} %>
						</div>
					</div> <!-- reviewListContainer -->	
				
					
				</div>
				<!-- table div -->
				
				
			<%
		    }
			else
			{
			%>
				<div id="emptyArea">
					등록된 글이 없습니다.
				</div>
		
			</div>>	
			<!-- 왼쪽 리뷰, 문의 게시판 리스 -->
			
		<%
		}
		%>		
		</div>
		<!-- section2 -->
	</section>
	<!-- section0 -->
		

	<!--풋터-->
	


</body>
</html>