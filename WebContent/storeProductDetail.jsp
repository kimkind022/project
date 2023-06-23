<%@page import="dto.ProductBean"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%	
	/* reviewList에는목록 5개씩 잘라서 보여줄거라서.review 다섯개만 들어있음 */ 
	/* 보내주는 위치 : BoardListAction.java */
	ArrayList<BoardBean> reviewList = (ArrayList<BoardBean>)request.getAttribute("reviewList");
    
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	System.out.println("위치: storeProductDetail.jsp 상태: pageInfo : " + pageInfo);
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>

<%
	ProductBean productBean = (ProductBean)request.getAttribute("productBean");
%>

<%
	/* 보내주는 위치 : BoardListAction.java */
	int listCountWhere = (int)request.getAttribute("listCountWhere");
%>

<%
	 String productId = request.getParameter("id");
	 System.out.println("productId: " + productId );
%>

<%
	int heartDataSelectCheck = (int)request.getAttribute("heartDataSelectCheck");	
	System.out.println("위치: storeProductDetial.jsp . heartDataSelectCheck: " + heartDataSelectCheck);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품상세페이지</title>
<jsp:include page="common.jsp"></jsp:include>

	<style type="text/css">
		.section0{
			width: 1200px;
			margin: 0 auto;
		}
		
		/* 사진들과 오른쪽 정보들을 담고 있는 큰 박스 */	
		.section1{
			width: 1200px;
			height: 900px;
			display:flex;
			justify-content: space-between;
			margin: 50px 0px 0px 0px;
		}
		
		/* 왼쪽, 하늘색, 사진들을 감싸고 있는 div*/
		.product-overview-image-Wrap{	
			width:590px;
		}
		
		/* 메인이미지를 감싸고 있는 div */
		.main-img-container{
			width: 590px;

			height:600px;
			object-fit: cover;


		}
		
		/* 서브이미지들을 갖고 있는 ul을 감싸고 있는 div */
		.sub-img-container{
			width:768px;
			height:100px;
			margin: 30px 0px 0px 0px;
			
		
		}
		/* ul */
		.subImages-ul{
			width:600px;
			heigth:200px;
			background-color: rgb(); 
			display: flex;
			justify-content: space-around;
		}
		
		#mainImage{
		   width: 590px;
 		   height:590px;
		    -webkit-transition:all 0.5s linear;
		    transition:all 0.5s linear;
		    overflow: hidden;
		    
		}
		
		
		
		.subImages-ul li{
		
			
			
		}
		
		.subImages{
			width:100px;
			height:100px;
		}
		
		/* 오른쪽, 보라색, 상품 가격 등을 감싸고 있는 div */ 
		.product-overview-content{
			width:540px;	
			padding-top: 20px;
   			padding-left: 70px;	
		}
		
		.navigationWrapper{
			width:1200px;
			border-bottom: 3px solid black;
			
		}
		/* 내비게이션, 상품-리뷰-문의 */
		.product-navigation-content{
			max-width: 1136px;
			height: 70px;
			width: 768px;
	  		margin: 0 auto;
	  		margin-left: 0px;
	  		font-size: 15pt;
	  		padding-left: 25px;
	  		
	  		
		}
		ol, ul{
		 	listy-style:none;"
		 	margin: 0 0 0 0;
		 	padding: 0 0 0 0;
		 	
		}
		.product-navigation-ul{
			width: 66.6%;
			height: 72px;
			display: flex;
		}
		.product-navigation-ul li{
			width: 100px;
			text-align: center;
	   		padding-left: 13px;
		    padding-right: 13px;
		    padding-top: 13px;
		    padding-bottom: 24px;
		}
		.navigationWrapper {
		
		}
		/* sticky */
		#navbar {
		  width: 1200px;
/* 		  overflow: hidden;
 */		  background-color: white;
		  position: sticky;
		  top: 91px;
		  border-top: solid;
		  
		  
		}
		
		/* #navbar a {
		  float: left;
		  display: block;
		  color: black;
		  text-align: center;
		  padding: 14px 16px;
		  text-decoration: none;
		  font-size: 17px;
		} */
		
		/* #navbar a:hover {
		  background-color: #ddd;
		  color: black;
		}
		
		#navbar a.active {
		  background-color: #04AA6D;
		  color: white;
		} */
		
	/* 	.content {
		  padding: 16px;
		} */
		
	/* 	.sticky {
		  position: fixed;
		  top: 0;
		  width: 100%;
		} */
	/* 	
		.sticky + .content {
		  padding-top: 60px;
		} */
		
		
		.product-navigation-p{
		    font-size: 27px;
		}
	
	
		.section2 {
			width: 1200px;
			display: flex;
			
    		justify-content: flex-start;
		}
		.product-info{
			width: 768px;
			float: left;
		}
	
		.product-info-img{
		    width: 768px;
		}
	
		
		.placeAnOrderMenu{
		    display: none;
		    width: 100%;
			height: 400px;
			float: right;
			margin-left: 20px;
		    position: sticky;
		    top: 165px;
		}
		.placeAnOrderMenu2{
		   display:block;
		}
		.product-title {
			padding: 15px 15px;
			
		}
		
		/* .placeAnOrderMenu div{
			padding-left:20px;
		} */
		.buttonContainer :first-child{
			padding-bottom: 0px;
			
		}
		
		.buttonInPlaceAnOrderMenu-wrapper{
			padding : 20px 0px 20px 0px;
		}
		.buttonInPlaceAnOrderMenu {
			width: 100%;
			height: 50px;
		
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
			background-color: white;
		}
		.consumerInfo{
			width:500px;
			display: flex;
			padding: 10px 0 10px 0;
		}
		.star-rating{
			width:20px;
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
		
		.product-quantity {
		    padding: 15px 15px;
		    border: 2px solid #f1f1f1;
		}
		
		.plusminusButton{
			width: 35px;
			color: #fb8259;
		}
		#plus{
			margin-left:10px;
		}
		#minus{
			margin-right:10px;
		}
		
		#quantity{
			font-size: 20pt;
			vertical-align: bottom;
			
		}
		
		.product-totalprice{
			margin-top: 15px;
		    padding: 15px 15px;
		    border: 2px solid #f1f1f1;
		}
		#totalprice{
			font-size: 20pt;
		}
		
		.product-option-form-button-wrap{
			margin-top: 15px;
			width:600px;
			display:flex;		
		}
		.product-option-form-button-wrap > .button{
			width: 200px;
   			height: 50px;
			justify-content: space-between;
			margin-left: 10px;
		}
		
		.heartImg-div{
			 align-self: center; 
		 }
		
		.heartImg{
			padding-left: 10px;
		}
		
		#boardsForm{
			background-color: #dddddd; /* 회색 */
			width: 768px;
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
	<!-- ajax쓰려면 이 라이브러리 추가해야 함 --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 

	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	
	<section class="section0">
		<!-- section1 : 사진들과 오른쪽 정보들을 담고 있는 큰 박스 -->
		
		<div class="section1">
			<!-- 사진관련 큰메인사진,썸네일5개 -->
			<div class="product-overview-image-Wrap">
				<div class="main-img-container">
					<img id='mainImage' src="images/store/<%=productBean.getImageNo1()%>"/>
				</div>
				<div class="sub-img-container">	
					<ul class="subImages-ul">
						<li style="width:100px; height:100px;">
							 <div class="img-container">
								 <img src="images/store/<%=productBean.getImageNo1()%>" class="subImages" >	
							 </div>
						</li>
						<li style="width:100px; height:100px;">
							 <div class="img-container">
								<img src="images/store/<%=productBean.getImageNo2()%>" class="subImages" width="100px">
							 </div>				
						</li>
						<li style="width:100px; height:100px;">
						   	 <div class="img-container" > 							
								<img src="images/store/<%= productBean.getImageNo3()%>" class="subImages" width="100px">	
							 </div>		
						</li>
						<li style="width:100px; height:100px;">
  							 <div class="img-container"> 							
								<img src="images/store/<%=productBean.getImageNo4()%>" class="subImages" width="100px">
							 </div>		
						</li>
						<li style="width:100px; height:100px;">
							<div class="img-container"> 	
								<img src="images/store/<%=productBean.getImageNo5()%>" class="subImages" width="100px">	
							</div>
						</li>
					</ul>
				</div>	
			</div>
			
			<form action="basketInsertAction.pd" method="post" name="boardform" onsubmit="return submitcheck()">		
				<div class="product-overview-content">
					<input type="hidden" name="id" value="<%=productBean.getId()%>">
					
					<p><%=productBean.getSellerId() %></p>
					<h1 class="product-title"> 
						<%=productBean.getName() %>
					</h1>
					
					<p>원산지표시: <%=productBean.getOrigin() %>  </p>
					
					
					<!-- 가격관련 -->
					<div class="product-price-wrap">
						<span class="product-discountRate">
							<%=productBean.getDiscountRate() + "%" %>
						</span>
						<span class="product-price">
							<del><%=productBean.getPrice()%></del>					
						</span>
						
						<div class="product-calculatedPrice">
							<% int result = (int)( (1- (productBean.getDiscountRate() / 100.0) ) * (  productBean.getPrice()) );
								out.println((int)result + "원");	
						    %> 
						</div>
						
						<div class="product-quantity">
							수량 : 
							<!--button태그는 기본속성이 서브밋이라서 button태그로 만든 버튼을 누르면 서브밋이 되버린다.
								button태그의 type="button"이라고 써주면 기존에 알고 있고 있던 inputtype button이된다.  -->
								<button type=button class="plusminusButton" id="minus" style="font-size: 20px;">-</button>
								<span class="quantity" id="quantity">1</span>
								<button type=button class="plusminusButton" id="plus" style="font-size: 20px;">+</button>
						</div>
						
						<div class="product-totalprice"> 
							주문하실 총 금액 :
							<span id="totalprice"> <%= result %> 원</span>
							<input type="hidden" value="<%=result%>" name="price">
							<input type="hidden" value="1" name="quantity">
	<!-- 						<input type="text" name="totalprice">
	 -->				</div>
					</div>
					
					
					<!-- 가격합계 -->
									
					<!-- 장바구니, 바로구매 싸고있는 div-->
					<div class="product-option-form-button-wrap">	
						<input type="submit" class="button" value="장바구니">
						<button class="button">바로구매</button>
						<div class="heartImg-div"> 
							<% if ( heartDataSelectCheck == 0 ) { %>
							   <img class="heartImg" id="Parse_Area" src="images/common/heart.png" width="40px" height="40px" > 
							<% }
							   else if( heartDataSelectCheck == 1 ) {%>
							   <img class="heartImg" id="Parse_Area" src="images/common/heart3.png" width="40px" height="40px" > 
							<% }%> 
						</div>
					</div>	
					
				</div>
			</form>
			
		</div> <!-- section1 -->
	
		<div id="navbar" class="navigationWrapper " >
			<nav class="product-navigation-content" >
				<ul class="product-navigation-ul">
					<a href="#product-info">
						<li class="product-navigation-li">
							<p class="product-navigation-p">상품정보<p>
						</li>
					</a>
					<a href="#reviewList">
						<li class="product-navigation-li" >
							<p class="product-navigation-p">리뷰</p>
						</li>
					</a>			
				</ul>
			</nav>
		</div>
	
		<!-- section2 -->
		<div class="section2">
			<div class="product-info">
				<a name="product-info">
					<img class="product-info-img" src="images/store/<%=productBean.getInfo()%>">
				</a>	
			</div>
			<div id="menu" class="placeAnOrderMenu">
				<div class="product-title-wrapper">
					<h1 class="product-title"> 
						<%=productBean.getName() %>
					</h1>
				</div>
				<div class="product-quantity">
					수량 : 
					<!--button태그는 기본속성이 서브밋이라서 button태그로 만든 버튼을 누르면 서브밋이 되버린다.
					button태그의 type="button"이라고 써주면 기존에 알고 있고 있던 inputtype button이된다.  -->
					<button type=button class="plusminusButton" id="minus" style="font-size: 20px;">-</button>
					<span class="quantity" id="quantity">1</span>
					<button type=button class="plusminusButton" id="plus" style="font-size: 20px;">+</button>
				</div>
				<div class="product-totalprice"> 
							주문하실 총 금액 :
							<span id="totalprice"> <%= result %> 원</span>
							<input type="hidden" value="<%=productBean.getPrice()%>" name="price">
							<input type="hidden" value="1" name="quantity">
	<!-- 						<input type="text" name="totalprice">
	 -->		</div>
				<div class="buttonContainer">
					<div class="buttonInPlaceAnOrderMenu-wrapper">
						<input type="button" class="buttonInPlaceAnOrderMenu" value="장바구니">
					</div>
					<div class="buttonInPlaceAnOrderMenu-wrapper">
						<input type="button" class="buttonInPlaceAnOrderMenu" value="장바구니">
					</div>
				</div>	
			</div>
		</div>	
		
		<!-- section3 -->
		<div class="section3">
			<!-- 리뷰, 문의 게시판 리스 -->
			<div id="boardsForm">
				<!-- table div 게시판 리스트-->
				<div id="reviewList">
					<h1>리뷰 <%= listCountWhere %></h1>
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
						if(reviewList != null && listCount > 0){ 
							for(int i=0;i<reviewList.size();i++){
					%>
						<div class="consumerInfo">
							<div class="profilePic">
								profile사진
							</div>
							<div class="">
								<p>nickname: <p>
								<p>리뷰작성일: <%=reviewList.get(i).getDate() %></p>
								<p>상품구매일:	
								<p>평점: 
						
								<% int rating = reviewList.get(i).getRating(); %>
								<% for( int r = 0; r < rating; r++ ) {%>
									<img src="images/common/starFull.png" class="star-rating">
								<% }%>
							
								<% for( int r = 0; r < 5-rating; r++ ){ %>
									<img src="images/common/starEmpty.png" class="star-rating">							
								<%}%>
															
					
								</p>
							</div>	
						</div>	
						<div class="chosenOptions">
							<p>구매한상품명 : <%=reviewList.get(i).getOrderId()%></p>
							<p>선택한상품옵션ex.Color</p>
						</div>
						<div class="photoReview">
							<img src="images/store/<%=reviewList.get(i).getFile()%>" width="120px"	height="120px">
						</div>
						<div class="reviewContent">
							<%=reviewList.get(i).getContents() %>
						</div>
						<hr class="reviewUnderline">							
						<%} %>
						
						<div id="pageList">	<!-- 페이지 숫자  -->
							<%if(nowPage<=1){ %>
							[이전]&nbsp;
							<%}else{ %>
							<a href="storeProductDetail.pd?id=<%=productBean.getId()%>&page=<%=nowPage-1 %>">[이전]</a>&nbsp;
							<%} %>
					
					
							<%for(int i = startPage; i <= endPage; i++){
								if(i == nowPage){%>
									[<%= i %>]
							<%}
								else{ 
							%>
									<a href="storeProductDetail.pd?id=<%=productBean.getId()%>&page=<%= i %>">
										[<%= i %>]
									</a>&nbsp;
								<%} %>
							<%} %>
					
					
							<%if(nowPage>=maxPage){ %>
								[다음]
							<%}else{ %>
							<a href="storeProductDetail.pd?id=<%=productBean.getId()%>&page=<%=nowPage+1 %>">[다음]</a>
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
		</div><!-- section3 -->
		
	</section><!-- section0 -->
		

	
<script>
	/* 이미지 호버, 메인사진 바뀌기 */
		var mainImage = $("#mainImage");
		$(".img-container img").mouseover(function(){
		    var src = $(this).attr("src");
		    $("#mainImage").attr("src",src);
		    
			$(this).attr("style", "border:solid #f67e7e");
		});
		
		$(".img-container img").mouseleave(function(){
			$(this).removeAttr("style", "border:solid #f67e7e");
		});
		
		mainImage.on("click",function(){
		    $(this).css("transform","scale(1.5)");
		});
		
		$(".product-navigation-ul a").mouseover(function(){
			/* alert("!!!!!"); */
			$(this).attr("style", "border-bottom: 4px solid red;")
			//$(this).css("border-bottom", "solid #f67e7e")
		});

		$(".product-navigation-ul a").mouseleave(function(){
			$(this).removeAttr("style", "border-bottom: 4px solid red;");
		});
		
		
		
	/* 클릭해서 수량변경시키기 */
		
	$(document).ready(function(){
		$('#plus').click(function(){
			let quantity = $('input[name=quantity]').val(); 
			
			$('input[name=quantity]').val(  parseInt(quantity) + 1  );
			$('.quantity').html(   parseInt(quantity) + 1   ); 
			calcsum();
		});
				
		$('#minus').click(function(){
			let quantity = $('input[name=quantity]').val(); 
			
			if (quantity != "1"){
				$('input[name=quantity]').val(  parseInt(quantity) - 1  );
				$('.quantity').html(   parseInt(quantity) -1   ); 
				calcsum();
			}
		});
		
		$(window).on('scroll', function() {
			console.log($(this).scrollTop());
		    if( $(this).scrollTop() > 464 ) {
		    	//alert("ddd");
		        $('#menu').addClass('placeAnOrderMenu2');
		        //console.log(ab)
		   
		    } else {
		   		$('#menu').removeClass('placeAnOrderMenu2');
		    } 
		});
		
		/* alert("plus"); */
		/* 다른 화면으로 보내려고 만든 hidden의 수량 수정 */
		/* 화면에 표시될 span 수량 수정 */
		/* 총금액 수정*/
		
    	/* alert("aa") */
    	$('.heartImg').click(function(){
	    	$.ajax({
	            type : "GET", //전송방식을 지정한다 (POST,GET)
	            url : "heartData.pd?id="+ <%=productId%> ,//호출 URL을 설정한다. GET방식일경우 뒤에 파라미터를 붙여서 사용해도된다.
	            dataType : "html",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
	           
	            error : function(){
	                alert("통신실패!!!!");
	            },
	            
	            success : function(Parse_data){
	            	if(Parse_data == 0){
	            		console.log("0인 경우 아무것도 안한 것");
		            	$("#Parse_Area").attr("src", "images/common/heart.png");
		            }
	            	else if(Parse_data == 1){
	            		console.log("1인 경우 delete 한 것 ");
	            		$("#Parse_Area").attr("src", "images/common/heart.png");
	            	}
	            	else if(Parse_data == 2){
	            		console.log("2인 경우 insert 한 것 ");
	            		$("#Parse_Area").attr("src", "images/common/heart3.png");
	            	}
	            }
	        });
    	});	
    	
    	//상품상세페이지에서 서브이미지 5개 안되는 경우 안보이게 하는 부분
    	var subImagesSRC = $('.subImages').get();
    	/* console.log( subImagesSRC[0] ); */
    	
    	for( var i = 0; i < subImagesSRC.length; i++){
    		var subImg = $('.subImages').eq(i).attr("src");
    		console.log(subImg);	
    		 if ( subImg == "images/store/null" ) {
    			 $('.subImages').eq(i).closest('li').attr("style", "display:none" ) ;
    		}  
    	}    	
	});
	
	
	function calcsum() {
		let price= $('input[name=price]').val();
		let quantity = $('input[name=quantity]').val(); 
		let sum = parseInt(price) * (parseInt(quantity));

		$('#totalprice').html( sum + " 원");

		$('input[name=totalprice]').val( sum );
	}
	
	function submitcheck() {
		alert("장바구니에 추가되었습니다.");
		return true;
	}
	

</script>

</body>
</html>