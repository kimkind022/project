<%@page import="dto.ProductBeanCategoryCount"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%  ArrayList<ProductBeanCategoryCount> categoryDataList 
			= (ArrayList<ProductBeanCategoryCount>)request.getAttribute("categoryDataList"); %>    

	<ul class="sectionBox-ul">
				
			<% for(int i=0; i < categoryDataList.size(); i++) {%>
				
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