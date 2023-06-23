<%@page import="dto.ProductBeanCategoryCount"%>
<%@page import="dto.ProductBeanWithReviewCount"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.ProductBean"%>
<%@ page import="java.util.*"%>

<%  ArrayList<ProductBeanWithReviewCount> mainpageList = (ArrayList<ProductBeanWithReviewCount>)request.getAttribute("mainpageList");	
	System.out.println("6. 위치: storeMain.jsp 상태: select 한 리스트: " + mainpageList);
%>

<%
	ArrayList<ProductBeanCategoryCount> categoryDataList = (ArrayList<ProductBeanCategoryCount>)request.getAttribute("categoryDataList");
	System.out.println("6. 위치: storeMain.jsp 상태: 카테고리별 8개 select 한 리스트: " + categoryDataList);

%>


 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 메인</title>

<style type="text/css">
		

	.section0{
		width: 1200px;
   	    min-height: 1400px;
	    margin: 0 auto;
	    padding-bottom: 30px;
	    
	}

	.section1{		/* 스토어 글씨 + 채소, 과일, 곡물, 청/잼류 카테고리 아이콘 전체 싸고 있는 div	 */
		width: 1200px;
		margin: 0 auto;
	}
	.storeTitleBox{ 	/* 스토어글씨 싸고 있는 div */
		background-color: rgb();
		width: 1200px;
		height: 50px;
		margin: 0 auto;
		padding-top: 30px;
		padding-bottom: 25px
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

	
	.boxWrapper{
		width:1820px;
		height:720px;
	}
	
	.sladerImage-box {
		width:2020px;
			height:720px;
		overflow:hidden;
	}
	
	.sladerImage{
		width:100%;
   		height:100%;
   		object-fit: cover; 
	}
	
	
	.categoryOnSlader-wrapper{
	
	}
	
	.categoryOnSlader{
		
	}
		
	 /* 신상품 전체 박스 */	
	.section2{
		width: 1200px;
		height: 555px;
		margin: 0 auto;
	}
	
	.titleBox-div{
		border-bottom: solid 2px grey;
		
	}
	
	.titleBox-text{
		margin-top: 10px;
	    font-size: 25pt;
	    text-align: center;
	    height: 50px;
        padding: 25px;
	    
	}
	
	.sectionBox-div{
		min-height: 885px;
	}
	
	.orderbyHeart{
		margin-left: 9px;
	    font-family: "Spoqa-Regular", -apple-system, BlinkMacSystemFont, "Apple SD Gothic Neo", Arial, sans-serif;
	    font-size: 24px;
	    font-weight: bold;
	    color: #ed3324;
	    vertical-align: middle;
	    letter-spacing: 1px;
	    text-decoration: underline;
	} 
	
	.sectionBox-ul{
		display: flex;
		flex-wrap: wrap;
		padding-top: 25px;
		
	}
	.sectionBox-ul > li{
	  	width: 270px;
		height: 430px;
		padding-left:15px;
		padding-right:15px;
	}
	.item-div {
  		width: 270px;
  		height: 260px;
  		background-color: rgb(219 249 249);
  		position: relative;
  		
	}
	
	.imgContainer" { 
		position: relative; 
	}
	
	.firstImage{
	
	}
	.absoluteImage{
		position: absolute;
   		left: 0px;
	}
	
	
	.thumbnail-img{
		height: 270px;
		height: 260px;
		  object-fit: cover;
	}
	
	.popupSliderMenu{
		width: 270px;
		height: 50px;
		background-color: #d8d8d8;
		position: absolute;
		top: 210px;
		visibility:hidden
	}
	.popupSliderMenu div{
		float: left;
	}
	
	
	.medal-Wrapper{
	    width: 50px;
	    height: 50px;
	    position: absolute;
	    top: 9px;
	    left: 196px;
	}
	
	
	.productInfo-div{
		width: 100%;
		height: 150px;
	}
	.productPtagWrapper{
		width: 100%;
		height: 75px;
	}
	
	.showmoreButton-div{
		width: 100%;
		height: 60px;
	}
	
	.showmore{
		width:400px;
		height:50px;
		margin: auto;
  	    display: block;
	}

</style>
</head>

<jsp:include page="common.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="slick/slick.css" />
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
<script type="text/javascript" src="slick/slick.min.js"></script>

<link href="styles/index.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script/storeMain.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>

<body>


	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	
	<!-- 전체섹션 -->
	<section class="section0">
	
		<!-- 스토어 글씨 + 채소, 과일, 곡물, 청/잼류 카테고리 아이콘들 싸고 있는 div	 -->	
		<div class="section1 categoryBundle">
			<div class="storeTitleBox"> <!-- 스토어글씨 싸고 있는 div -->
				<p class="storeTitle">
					 메인 페이지
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
								<p class="pTag">전체</p>
							</div>
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/fruit.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">과일</p>
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/vegetable.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">채소</p>
							</div>
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/grain.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">쌀/곡류</p>
							</div>
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/jam.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">청/잼류</p>
							</div>
						</div>
					</li>
					
					<li>					
						<div class="categoryIcon">
							<img src="images/common/showmore.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">기타</p>
							</div>
						</div>
					</li>
					
					
					
					
					<!-- <li>					
						<div class="categoryIcon">
							<img src="images/common/showmore.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">기타상품</p>
							</div>
						</div>
					</li> -->
				</ul>
			</div>
		</div>
	
		
		
		<div class="section2">
			<div class="titleBox-div">
				<p class="titleBox-text"> 오늘의 마켓 인기상품</p>
			</div>
			
			<div class="sectionBox-div">
				<ul class="sectionBox-ul ">
				<% for(int i=0; i<4; i++) {%>
					<li class="sectionBox-li li">
						<div class="item-div" >
							<div class="imgContainer">
 								<a href="storeProductDetail.pd?id=<%=mainpageList.get(i).getId()%>"> <!-- getId의 id는 product 테이블의id, 상품식별하는 id를 의미 -->
<%-- 								<a href="mybatis.st?command=storeProductDetail?id=<%=list.get(i).getId()%>">	
 --%>								<div class="imgWrapper">
										<img src="images/store/<%=mainpageList.get(i).getImageNo1()%>" class ="thumbnail-img imghover absoluteImage" width="270px">	
										<img src="images/store/<%=mainpageList.get(i).getImageNo2()%>" class ="thumbnail-img imghover" width="270px">	
									</div>
								</a>	
								<div class="popupSliderMenu">
									<div><img src="images/common/heart.png" style="width: 50px"></div>	
									<div><img src="images/common/cart.png" style="width: 50px"></div>	
								</div>
								<div class="medal-Wrapper"   >	
									<% if(i == 0){ %>
										<img src="images/common/medalgold.png" style="width: 80px">	
									<% } else if(i == 1){ %>
										<img src="images/common/medalsilver.png" style="width: 80px">	
									<% }  else if(i == 2){ %>
										<img src="images/common/medalbronze.png" style="width: 80px">	
									<% } %>			
								</div>
							</div>	
						</div>
						
						
						<div class="productInfo-div">
							<div class="productPtagWrapper">
								<p style="font-size:20pt"><%=mainpageList.get(i).getName()%></p>
							</div>	
							<span style="font-size:17pt"><%=mainpageList.get(i).getPrice() %></span>원
							<p>리뷰수: <%=mainpageList.get(i).getRe() %></p>
						</div >
					</li>
					<%} %>	
				</ul>
			</div>
		</div>
		
	<!-- 	<div class="showmoreButton-div">
			<button class="showmore"> 인기상품 더보기 > </button>
		</div> -->
		
		<!-- 카테고리별 8개씩 보여줄 부분 -->
		<div class="section3" >
			<div class="titleBox-div">
				<p class="titleBox-text" id="ParameterTitle"><%=categoryDataList.get(0).getCategory() %></p>
			</div>
			
			<div class="sectionBox-div" id="Parse_Area">
				<ul class="sectionBox-ul">
				
					<% for(int i=0; i < 8; i++) {%>
						
						<li class="sectionBox-li">
							<div class="item-div">
								<div class="imgContainer">
								 	<a href="storeProductDetail.pd?id=<%=categoryDataList.get(i).getId()%>">
								 		<div class="imgWrapper">
											<img src="images/store/<%=categoryDataList.get(i).getImageNo1()%>" class="thumbnail-img imghover absoluteImage" width="270px">	
											<img src="images/store/<%=categoryDataList.get(i).getImageNo2()%>" class="thumbnail-img imghover" width="270px">	
										</div>
									</a>
									<div class="popupSliderMenu">
										<div><img src="images/common/heart.png" style="width: 50px"></div>	
										<div><img src="images/common/cart.png" style="width: 50px"></div>	
									</div>
								</div>	
							</div>
						
							<div class="productInfo-div">
								<div class="productPtagWrapper">
									<p style="font-size:20pt"><%=categoryDataList.get(i).getName()%></p>
								</div>	
								<span style="font-size:17pt"><%=categoryDataList.get(i).getPrice() %></span>원
								<p>리뷰수: <%=categoryDataList.get(i).getReviewCount()%></p>
							</div >
						</li>
						
					<%} %>	
				</ul>
			</div>
			<a id="showmoreParameter" href="storeCategoryShowMore.pd?category=과일">
				<div class="showmoreButton-div">
					<button class="showmore"> 카테고리 별 전체보기 > </button>
				</div>
			</a>
		</div>
		
	</section>
	<jsp:include page="footer.jsp"></jsp:include>

	<!--풋터-->
	
	<script>
		$(document).ready(function () {
			
			  $('.categoryIcon').click(function() {
				    $('.categoryIcon').css('border','1px solid #EAEAEA');
			        $(this).css('border','2px solid rgb(240, 93, 35)');
			    });
			    
			
			
		    $(".categoryIcon").click(function() { 
		    	var pTagtext = $(this).find(".pTag").html();
		    	console.log(pTagtext);
		    	
		    	$.ajax({
		    		type : "GET", 
		            url : "storeCategoryData.pd",
		            dataType : "html",
		            data : {"category": pTagtext},
		            error : function(){
		                alert("통신실패!!!!");
		            },
		            success : function(Parse_data){
			            $("#Parse_Area").html(Parse_data);
		            	$("#ParameterTitle").html(pTagtext);
					    $("#showmoreParameter").attr('href', 'storeCategoryShowMore.pd?category='+pTagtext);
		 		    }
		    	});
		     });
		    
		  
		    
		});
	</script>
</body>


</html>




