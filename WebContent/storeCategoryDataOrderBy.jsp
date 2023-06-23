<%@page import="dto.ProductBeanCategoryCount"%>
<%@page import="dto.ProductBeanCategoryHeartCount"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%  ArrayList<ProductBeanCategoryCount> categoryOrderByList 
		= (ArrayList<ProductBeanCategoryCount>)request.getAttribute("categoryOrderByList"); 
		
%>
  
  
  <ul class="sectionBox-ul">
		<% for(int i=0; i < categoryOrderByList.size(); i++) {%>
			<li class="sectionBox-li">
				<div class="item-div">
					<div class="imgContainer">
					 	<a href="storeProductDetail.pd?id=<%=categoryOrderByList.get(i).getId()%>">
					 		<div class="imgWrapper">
								<img src="images/store/<%=categoryOrderByList.get(i).getImageNo1()%>" class="thumbnail-img imghover absoluteImage" width="270px">	
								<img src="images/store/<%=categoryOrderByList.get(i).getImageNo2()%>" class="thumbnail-img imghover" width="270px">	
							</div>
						</a>
						<div class="popupSliderMenu">
							<div><img src="images/common/heart.png" style="width: 50px"></div>	
							<div><img src="images/common/cart.png" style="width: 50px"></div>	
						</div>
					</div>	
				</div>
			
				<div class="productInfo-div">
					<p style="font-size:20pt"><%=categoryOrderByList.get(i).getName()%></p>
					<p>리뷰수: <%=categoryOrderByList.get(i).getReviewCount()%></p>
					<span style="font-size:17pt"><%=categoryOrderByList.get(i).getPrice() %></span>원
				</div >
			</li>
		<%} %>	
	</ul>