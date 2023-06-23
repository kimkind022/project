<%@page import="dto.ProductBeanCategoryCount"%>
<%@ page import="dto.ProductBean"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
	ArrayList<ProductBeanCategoryCount> categoryShowMoreList = (ArrayList<ProductBeanCategoryCount>)request.getAttribute("categoryShowMoreList");	
	System.out.println("6. 위치: storeCategoryShowMore.jsp 상태: select 한 리스트: " + categoryShowMoreList);
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
		width: 600px;
		height: 100px;
  		border: 1px;
		display: flex;
		justify-content: space-between;
		margin: 0 auto;
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
	/* .section2{
		width: 1200px;
		height: 555px;
		margin: 0 auto;
	} */
	
	.section3{
		padding-bottom: 20px; 
		border-bottom: solid 2px grey; 
	}
	
	.titleBox-div{
		border-bottom: solid 2px grey;
		
	}
	
	.titleBox-text{
		margin-top: 10px;
	    font-size: 25pt;
	    text-align: center;
	    height: 50px;
        padding: 25px 25px 0px 25px;
	}
	.choiceBox-div{
	    text-align: right;
    	padding-right: 30px;
    	padding-bottom: 10px;	
	}
	#choiceBox{
		width: 120px;
   		height: 30px;
   	    text-align: center;
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
					 카테고리 전체보기 페이지
				</p>
			</div>
			<hr>
			
			<!-- 채소, 과일, 곡물, 청/잼류 카테고리 아이콘들 싸고 있는 div -->
			<div class="categoryBundle-Icons-div">
						
						<div class="categoryIcon">
						
							<img src="images/common/zoomin.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">전체</p>
							</div>
			
						</div>
							
						<div class="categoryIcon">
						
							<img src="images/common/fruit.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">과일</p>
							</div>
			
						</div>
					
					
									
						<div class="categoryIcon">
								<img src="images/common/vegetable.png" class="categoryIcon-img"/>
								<div class="categoryIcon-title">
									<p class="pTag">채소</p>
								</div>
							
						</div>
					
					
										
						<div class="categoryIcon">
							<img src="images/common/grain.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">쌀/잡곡</p>
							</div>
						</div>
					
					
									
						<div class="categoryIcon">
							<img src="images/common/jam.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">청/잼류</p>
							</div>
						
						</div>
					
					
									
						<div class="categoryIcon">
							<img src="images/common/showmore.png" class="categoryIcon-img"/>
							<div class="categoryIcon-title">
								<p class="pTag">기타</p>
							</div>
						
						</div>
				
				
			</div>
		</div>	
		
		
		<!-- 카테고리별 8개씩 보여줄 부분 -->
		<div class="section3">
			<div class="titleBox-div">
				<p class="titleBox-text" id="ParameterTitle"><%=categoryShowMoreList.get(0).getCategory() %></p>
				<div class="choiceBox-div">
					<select name=choiceBox id=choiceBox>
						<option value="최신순">최신순</option>
						<option value="좋아요순">좋아요순</option>
						<option value="리뷰순">리뷰순</option>	
						<option value="판매량순">판매량순</option>		
					</select>	
				</div>
			</div>
			
			<div class="sectionBox-div" id="Parse_Area">
			<!-- Ajax로 교체할 부분 -->
				<ul class="sectionBox-ul">
				
					<% for(int i=0; i < categoryShowMoreList.size(); i++) {%>
						
						<li class="sectionBox-li">
							<div class="item-div">
								<div class="imgContainer">
								 	<a href="storeProductDetail.pd?id=<%=categoryShowMoreList.get(i).getId()%>">
								 		<div class="imgWrapper">
											<img src="images/store/<%=categoryShowMoreList.get(i).getImageNo1()%>" class="thumbnail-img imghover absoluteImage" width="270px">	
											<img src="images/store/<%=categoryShowMoreList.get(i).getImageNo2()%>" class="thumbnail-img imghover" width="270px">	
										</div>
									</a>
									<!-- <div class="popupSliderMenu">
										<div><img src="images/common/heart.png" style="width: 50px"></div>	
										<div><img src="images/common/cart.png" style="width: 50px"></div>	
									</div> -->
								</div>	
							</div>
						
							<div class="productInfo-div">
								<p style="font-size:20pt"><%=categoryShowMoreList.get(i).getName()%></p>
								<span style="font-size:17pt"><%=categoryShowMoreList.get(i).getPrice() %></span>원
								<p>리뷰수: <%=categoryShowMoreList.get(i).getReviewCount() %></p>
							</div >
						</li>
					<%} %>	
				</ul>
			</div>
		</div>
		
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
	
	<!--풋터-->
	
	<script>
		
			$(document).ready(function () {
				$(".imgContainer").mouseenter(function () {
				    $(this).find(".absoluteImage").css("visibility", "hidden");
				    $(this).find(".popupSliderMenu").css("visibility", "visible");

				});
			    
			     $(".imgContainer").mouseleave(function () {
			    	$(this).find(".absoluteImage").css("visibility", "visible");
				    $(this).find(".popupSliderMenu").css("visibility", "hidden");

			    }); 
			    
			     
			    /* 카테고리 클릭시 보여질 상품 Ajax */ 
			    $(".categoryIcon").click(function() { 
			    	var pTagtext = $(this).find(".pTag").html();
			    	console.log(pTagtext);
			    	
			    	$.ajax({
			    		type : "GET", //전송방식을 지정한다 (POST,GET)
			            url : "storeCategoryData.pd",//호출 URL을 설정한다. GET방식일경우 뒤에 파라미터를 붙여서 사용해도된다.
			            dataType : "html",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
			           
			            data : {"category": pTagtext},
			            
			            error : function(){
			                alert("통신실패!!!!");
			            },
			            
			            success : function(Parse_data){
			            	$("#Parse_Area").html(Parse_data);
			            	$(".titleBox-text").html(pTagtext);
/* 			            	var ParameterTitleText = $("#ParameterTitle").html();    /* document.getElementbyId */					  						    
/* 						    $("#showmoreParameter").attr('href', 'storeCategoryShowMore.pd?category='+pTagtext); */			 			     		            	
			            }
			    	 });
			    });
			    
			    
			    
			     $("#choiceBox").change(function() {
			    	var pTagtext = $(this).closest('.titleBox-div').find(".titleBox-text").html();
			    	console.log(pTagtext);
			    	
			    	var optionTextSelected = $(this).val();
			    	console.log(optionTextSelected);
			   	
				 		/* location.href = 'storeCategoryDataOrderByHeart.pd?category='+pTagtext; */	
				 		
				 	$.ajax({
			    		type : "GET",
			    		url : "storeCategoryDataOrderBy.pd",
			    		datatype : "html",
			    		data : {
			    					"category" : pTagtext,
			    					"selectOption" : optionTextSelected 
			    				},
			    		
			    		error : function(){
			                alert("통신실패!!!!");
			    		},
			    		success : function(Parse_data){
			            	$("#Parse_Area").html(Parse_data);
			            	
			    		}
			    	})
			    	
			    }); 
			     
			});
	</script>
</body>
</html>
