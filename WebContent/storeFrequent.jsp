<%@page import="dto.OrderBean"%>
<%@page import="dto.ProductBean"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>



<%
	//길동이가 주문한 적이 있는 상품의 아이디를 상품테이블에, 그 전체 정보를 담아놓은 articleListOrdered
	ArrayList<ProductBean> articleListOrdered = (ArrayList<ProductBean>)request.getAttribute("articleListOrdered");
%>

	
<%  /* 길동이가 주문한 적이 있는 상품의 아이디를 주문테이블에서 뽑아옴. 상품번호 순으로   */	
	ArrayList<OrderBean> dataOrdersList = (ArrayList<OrderBean>)request.getAttribute("dataOrdersList");
%>


<% 
	ArrayList<BoardBean> reviewCheck = (ArrayList<BoardBean>)request.getAttribute("reviewCheck");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주구매페이지</title>

<style type="text/css">

	
	.section0{
		width: 1200px;
		height: 1400px;
		margin: 0 auto;
	}
	.section1{		/* 스토어 글씨 + 채소, 과일, 곡물, 청/잼류 카테고리 아이콘 전체 싸고 있는 div	 */
		width: 1200px;
	}
	.storeTitleBox{ 	/* 스토어글씨 싸고 있는 div */
		background-color: rgb();
		width: 1200px;
		height: 50px;
		margin: 0 auto;
		padding-top: 30px;
		padding-bottom: 20px
	}
	.storeTitle{ 	/* p태그 */
		margin: 0 auto;
	    text-align: center;
	    font-size: 20pt;
	}
	
	.categoryBundle-Icons-div{	 /* 채소, 과일, 곡물, 청/잼류 카테고리 아이콘들 싸고 있는 div  */
		width: 1200px;
		height: 100px;
  		border: 1px;	
	}
	
	
	
	.categoryBundle-Icons-div ul{
		display: flex;
		justify-content: space-between;
		margin: 0 300px;		
	}
	
	.categoryIcon{
		/* width: 50px;
	    height: 100px; */
	    float: left;
	    
	    width: 80px;
        height: 80px;
        margin: 10px;
        position :relative;
        
	    border: 1px solid #EAEAEA;
	    border-radius: 10px;
	    background-color: white;
	    box-shadow: 0px 2px 2px #eaeaea;
	}
	
	.categoryIcon-img{
		width:50px;
		/* vertical-align: sub;
		 */
		position: absolute;
   		left: 15px;
        top: 5px;
		
		
	}
	
	.categoryIcon-title{
	    width: 100%;
	    height: 30px;
	    position: absolute;
	    top: 54px;
	}
	
	.categoryIcon-title > p{
		text-align: center;	
	}
	
	.directory-oderby-box{
		width: 1200px;
		padding-top: 10px;
		padding-bottom: 30px;
		border: 1px;
		border-bottom: solid;
		border-color: grey;
	}
	.directory{
		float:left;
	}
	.orderby{
		float:right;
	}
	.orderby-ul > li {
		float:left;
	}
	
	
	/* 마이리뷰 관련 내용 */
	.myReview-contentBox{
		margin: 0px 0px 10px 0px;
		position:relative;	
	
	}
	.myReview-contentBox-ul{
		display: flex;
	}
	.myReview-contentBox-ul > div{
	 	width: 210px;
	    height: 210px;
  	    background-color: #ffd2ba;
		overflow: hidden;

	    margin-left:15px;
	   	margin-right:15px;
	   	border-radius: 10px;
	}
	
	.myReview-contentBox-ul > div :hover img {
		transform: scale(1.03);
	}
	
	.relativediv:nth-child(5){
	 	opacity: 0.5;
	}
	
	.thumbnail-Img {
		border-radius: 10px;
		max-width:100%;
		transition: all 0.2s linear;
	}
	
	
	.seemore{
		width: 210px;
	   height: 210px;
	   background-color: #ff5800;
	   margin-left: 15px;
	   margin-right: 15px;
	   border-radius: 10px;
	   
	   	position: absolute;
	        left: 960px;
	    opacity: 0.4;
		
	}
	
	.seemore-h2{
		top: 87px;
	    left: 26px;
	    position: absolute;
	    font-size: 20px;
	    text-align: center;
	}
	
	.linktoWriteReview{
		position: absolute;
	    top: 160px;
	    width: 210px;
	    height: 50px;
	    background-color: black;
	    opacity: 0.6;
	    border-end-start-radius: 10px;
  		border-end-end-radius: 10px;
	}
	.linktoWriteReview > p{
	    color: white;
 	   text-align: center;
  	   font-size: 16pt;
  	   padding-top: 10px;
  	   
	}
	
	
	
	/* 자주구매한 상품관련 내용 */
	.frequent-mainBox{
		width:1200px;
		min-height: 1500px;
	}
	.frequent-overall{
    	padding-bottom: 10px;
    	display: flex;
    }
    .frequent-overall > div{
    	    justify-content: space-between;

    }
	
	.frequent-overall-text{
		display: block;
		font-size: 24px;
 		color: #222;
	}
	.divShape{
		margin-bottom: 16px;
		padding-top: 10px;
		padding-bottom: 10px;
	    
  		border-bottom: 1px solid #cdcdcd;
	}
	
	
	.frequent-content{
		margin-top: 10px;
	    display: block;
		width: 1200px;
		height: 500px;	
	}
	
	.frequent-content-ul{
		display: flex;
	}
	.frequent-content-ul > li{
	 	vertical-alin: top;
	 	width: 270px;
		height: 500px;
		padding-left:15px;
		padding-right:15px;
	 /* 	margin-right: 40px; */
	 	
	 	
	}
	/* .frequent-content-ul > li:nth-of-type(4n + 4) {
	 	margin-right: 0;
	} */
	.li-thumbnail {
   		width: 100%;
   		height: 260px;

	}
	.productInfo-div {
		width: 100%;
	    height: 150px;
	}
</style>
</head>

<jsp:include page="common.jsp"></jsp:include>
<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	
	<!-- 모두 감싸고 있는 width 1200 div -->
	<section class="section0">	
		<!-- 스토어 글씨 + 채소, 과일, 곡물, 청/잼류 카테고리 아이콘들 싸고 있는 div	 -->	
		<section class="section1 categoryBundle">
			<div class="storeTitleBox"> <!-- 스토어글씨 싸고 있는 div -->
				<p class="storeTitle">
					 자주 구매한 상품 
				</p>
			</div>
			<hr>
			
			<!-- 채소, 과일, 곡물, 청/잼류 카테고리 아이콘들 싸고 있는 div -->
			<div class="categoryBundle-Icons-div">
				<ul>
					<li>					
						<div class="categoryIcon">
						
							<img src="images/common/zoomin.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p>전체</p>
							</div>
			
						</div>
					</li>
					<li>					
						<div class="categoryIcon">
						
							<img src="images/common/fruit.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p>과일</p>
							</div>
			
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
								<img src="images/common/vegetable.png" class="categoryIcon-img"/>
								<div class="categoryIcon-title">
									<p>채소</p>
								</div>
							
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/grain.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p>쌀/잡곡</p>
							</div>
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/jam.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p>청/잼류</p>
							</div>
						
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/showmore.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p>기타</p>
							</div>
						
						</div>
					</li>
					
					
				
					
				</ul>
			</div>
			
			<!-- <div class="directory-oderby-box">
				<div class="directory">
					<p> Home > 스토어 > 자주구매한상품 </p>
				</div>			
				<div class="orderby">
					<ul class="orderby-ul">
						<li>자주구매순&nbsp&nbsp| &nbsp</li>
						<li>최신구매순&nbsp&nbsp</li>
					</ul>	
				</div>
			</div> -->
			<hr class="hr">

			<section class="myReview">
				<div class="divShape">
					<h2 class="frequent-overall-text">마이리뷰</h2>
					<p>남겨주신 리뷰는 다른 고객에게 큰 도움이 됩니다. </p>
					<%-- 
						<p> review테이블에 존재하는(리뷰작성된 적이 있는 orderId의 값)</p>
						<%= ReviewChecked.get(0).getOrderId() %>
						<p> 마이리뷰에 등록된 개별 상품이 가지고 있는 orderId의 값)</p>
						<%= dataOrdersList.get(0).getOrderId()%>  --%>
					
				</div>
				
				
				<%
				/* articleListOrdered : 로그인한 memberId로 주문했던 것만 product 테이블에서 모든 상품정보를 select해서 담아놓은 ArrayList */
				System.out.println("articleListOrdered.size: " + articleListOrdered.size());
				/* reviewChecked:  로그인한 memberId로 reviews테이블에서 orderId만 뽑아서 담아놓은 ArrayList. */
				System.out.println("reviewCheck.size: " + reviewCheck.size());
				System.out.println("dataOrdersList.size: " + dataOrdersList.size());
				
				int [] x = new int[articleListOrdered.size()];
				Arrays.fill(x,0);
				
				for(int i=articleListOrdered.size()-1; i>=0; i--){	
					System.out.println(	"articleListOrdered.get(i).getId() :" + articleListOrdered.get(i).getId() );
					for(int j=0; j<reviewCheck.size(); j++){
					/* for(int j=reviewCheck.size()-1; j>=0; j--){ */
						System.out.println(	"dataOrdersList.get(i).getOrderId() :" + dataOrdersList.get(i).getOrderId() + ",," + "reviewCheck.get(j).getOrderId()" + reviewCheck.get(j).getOrderId());
								//주문한 오아이디가,리뷰 리스트에 있는 오더아이디와 일치하면 이미쓰여진거니까 배열 x에 100으로 입

						if( dataOrdersList.get(i).getOrderId() == Integer.parseInt(reviewCheck.get(j).getOrderId()) ){
							
						x[4-i]=100;
						break;
						}		
						
					}
				}
						//System.out.println(reviewChecked.get(j).getOrderId() + "," + dataOrdersList.get(i).getOrderId() );
						//System.out.println(articleListOrdered.get(i).getId() + "," + dataOrdersList.get(i).getProductId() );
				
				%>
				<% 
				for(int i=articleListOrdered.size()-1; i>=0; i--){
				 System.out.println(x[i]);
				}
				%>
				<div class="myReview-contentBox">
					<ul class="myReview-contentBox-ul">
						
						<%
						if(articleListOrdered != null){ 
							for(int i=articleListOrdered.size()-1; i>=0; i--){	
								System.out.println(articleListOrdered.get(i).getId());
								System.out.println (articleListOrdered.get(i).getId() + ",," + dataOrdersList.get(i).getProductId() );		
						%>		
									
						<div class="relativediv">
							<li>
								<!-- 사진부분 -->
								<a href="storeProductDetail.pd?id=<%=articleListOrdered.get(i).getId()%>"> <!-- getId의 id는 product 테이블의id, 상품식별하는 id를 의미 -->
									<img class="thumbnail-Img" src="images/store/<%=articleListOrdered.get(i).getImageNo1()%>" width="210px" height="210px">
								</a>
							<% 
							if(x[i]==100){
							%> 
								<!-- 리뷰쓰기,수정부분 -->					
								<!--  articleListOrdered.get(i).getId()는 productId -->
								<a href="reviewModify.pd?id=<%=articleListOrdered.get(i).getId()%>&orderId=<%=dataOrdersList.get(4-i).getOrderId()%>">
									 <div class="linktoWriteReview absolutediv">
									 	  <p>리뷰수정</p>
									 </div> 					 
								</a>
							<% } 
								else{
							%> 
								<a href="reviewWrite.pd?id=<%=articleListOrdered.get(i).getId()%>&orderId=<%=dataOrdersList.get(i).getOrderId()%>">
									 <div class="linktoWriteReview absolutediv">
									 	  <p>리뷰쓰기</p>
									 </div> 					 
								</a>
							<%} %>
						
							</li>
						</div>
						<% } %>
						
						<% } %>
						
						<div class="seemore relativediv">
							<h2 class="seemore-h2">
								내 리뷰 보러가기 ...
							</h2>
						</div>
					</ul>		
				</div>
			</section>
			
			<section class="frequent-mainBox">
				<div class="frequent-overall divShape">
					<div>
						<h2 class="frequent-overall-text"> 자주 구매한 상품 전체</h2>
					</div>
					<div style="align-self: end;">	
						<p>&nbsp;더보기 ></p>
					</div>	
				</div>
					
				<div class="frequent-content">
					<div class="frequent-content-div">
						<ul class="frequent-content-ul">
						
							<%--  <% System.out.println(articleListAll);%>  --%>
							<%
							if(articleListOrdered != null){ 
								for(int i=articleListOrdered.size()-1; i>=1; i--){	
							%>						
													
							<li class="frequent-content-li">
								<a href="storeProductDetail.pd?id=<%=articleListOrdered.get(i).getId()%>"> <!-- getId의 id는 product 테이블의id, 상품식별하는 id를 의미 -->
									<div class="li-thumbnail">
										<img src="images/store/<%=articleListOrdered.get(i).getImageNo1()%>" width="270px" height="260px">		
									</div>
								</a>
							<!-- 	<div style="top: -57px;left: 224px;position: relative;">
									<div style=" position: absolute;">
										<img src="images/common/heart.png" width="50px" height="50px" > 
									</div>
								</div> -->
								<div class="productInfo-div">
									<p style="font-size:20pt"><%=articleListOrdered.get(i).getName()%></p>		
									<span style="font-size:17pt">가격: <%=articleListOrdered.get(i).getPrice()%></span>		
								</div>
							</li>	
								<% } %>
							<% } %>
							
						
						</ul>
					</div class="seeMore-wapper">
						<div class="seeMore"></div>
					</div>
			
			
			</section> <!-- 섹션 frequent-mainBox -->
		</section> <!-- section1 categoryBundle-->
	</section>	<!-- section0 -->
		
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>