<%@page import="dto.ProductBeanCategoryReviewCount"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%  ArrayList<ProductBeanCategoryReviewCount> categoryReviewCountList 
		= (ArrayList<ProductBeanCategoryReviewCount>)request.getAttribute("categoryHeartCountList"); 		
%>   
    
  <ul class="sectionBox-ul">
	
		<% for(int i=0; i < categoryReviewCountList.size(); i++) {%>
			
			<li class="sectionBox-li">
				<div class="item-div">
					<div class="imgContainer">
					 	<a href="storeProductDetail.pd?id=<%=categoryReviewCountList.get(i).getId()%>">
					 		<div class="imgWrapper">
								<img src="images/store/<%=categoryReviewCountList.get(i).getImageNo1()%>" class="thumbnail-img imghover absoluteImage" width="270px">	
								<img src="images/store/<%=categoryReviewCountList.get(i).getImageNo2()%>" class="thumbnail-img imghover" width="270px">	
							</div>
						</a>
						<div class="popupSliderMenu">
							<div><img src="images/common/heart.png" style="width: 50px"></div>	
							<div><img src="images/common/cart.png" style="width: 50px"></div>	
						</div>
					</div>	
				</div>
			
				<div class="productInfo-div">
					<p style="font-size:20pt"><%=categoryReviewCountList.get(i).getName()%></p>
					<span style="font-size:17pt"><%=categoryReviewCountList.get(i).getPrice() %></span>원
					<p>리뷰수: 2200개</p>
				</div >
			</li>
		<%} %>	
	</ul>