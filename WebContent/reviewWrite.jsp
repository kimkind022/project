<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
					
<% String memberId = (String)session.getAttribute("ID"); %>
<%= memberId %>


    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>리뷰 작성하기</title>
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<link href="styles/common.css" rel="stylesheet" type="text/css">
	<link href="styles/header.css" rel="stylesheet" type="text/css">
	<link href="styles/footer.css" rel="stylesheet" type="text/css">
	
	<style type="text/css">
	
		section{
			width: 700px;
			height: 900px;
	 		margin: 50px auto;
	 		padding-top: 0px;
		}
		table {
			width: 100%;
			border-spacing: 0;
			height: 600px;
			/* border-style: solid;
		 	border-width: 1px;
		 	border-color: black; */
		}
		.title{
			border: 1.5px solid rgb(240, 93, 35);
			border-radius: 5px;
			width: 700px;
			height: 50px;
		}
		
		.contents{
			border: 1.5px solid rgb(240, 93, 35);
			border-radius: 5px;
			width:700px;
			height:400px;
		}
		
		section > table > tr td{
			vertical-align: center ;
		}
		
		.submitbutton{
			height: 45px;
			width: 120px;
			border-width:2px ;
			border-color: #FF7171;
			border-style: solid;
			border-radius: 5px;
			background-color: white;
			color: #FF7171;
			font-weight: bold;
		}	
		.radioShape{
			accent-color:rgb(240, 93, 35);
			width:40px;
			height:20px;
		}
		 	
	</style>
</head>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/header.js"></script>

<body>
	<jsp:include page="header.jsp"/>
	<section>
	<p style="text-align:right">홈 > 스토어 > 글목록 > 리뷰작성</p>
		<h1 style="color:gray;">리뷰작성하기</h1>
		<form action="reviewWritePro.pd" method="post" enctype="multipart/form-data" name="boardform">
			<table>
				<tr>
					<td><input name="file" type="file" required="required" /></td>
				</tr>
				<% int orderId = Integer.parseInt(request.getParameter("orderId"));%>
				<%="getParameter로 가져온 orderId=" + orderId %>
				<% int productId = Integer.parseInt(request.getParameter("id")); %>
				<%=", getParameter로 가져온 productId=" + productId%>
				
				
				
				<input name="orderId" type="hidden" value="<%= orderId %>" readonly>
				<input name="productId" type="hidden" value="<%= productId %>"> 
				
			
				<tr>
					<td style="height:430px">
						 <textarea class="contents" name="contents"rows="20" cols="100" style="resize:none;" placeholder="글 내용을 입력하세요"></textarea>
					</td>
				</tr>
				
				<tr>
					<td height="50px" >
						평점주기 : 
						<input class="radioShape" type="radio" name="rating" value="5" checked>5점&nbsp;&nbsp;
						<input class="radioShape" type="radio" name="rating" value="4" >4점&nbsp;&nbsp;
						<input class="radioShape" type="radio" name="rating" value="3" >3점&nbsp;&nbsp;
						<input class="radioShape" type="radio" name="rating" value="2" >2점&nbsp;&nbsp;
						<input class="radioShape" type="radio" name="rating" value="1" >1점&nbsp;&nbsp;
			  		</td>
				</tr>
				
				<tr>
					<td style="height:50px">
						<center> <input class="submitbutton" type="submit" value="저장하기"> </center>
					</td>
				</tr>	
			</table>
		</form>
	</section>	
	
	
</body>


</html>