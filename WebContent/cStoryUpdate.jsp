<%@page import="dto.StoryPostsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.StoryPostsDTO"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>수정하기</title>


<link href="styles/communityStory.css" rel="stylesheet" type="text/css">
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>



</head>

<%
	String postId = request.getParameter("id");
	String nowPage = request.getParameter("page");
	StoryPostsDTO article = (StoryPostsDTO) request.getAttribute("article");
%>


<body>

	<c:set var="sessionId" value="${ID }" />
	<c:set var="memberId" value="<%=article.getMemberId()%>" />
	<c:choose>
		<c:when test="${ sessionId ne memberId }">
			out.println("<script>
				alert("잘못된 접근입니다.");
				history.go(-1);
			</script>")
		</c:when>
		<c:otherwise>


			<!--헤더-->
			<jsp:include page="header.jsp"></jsp:include>
			<div class="wrap1">
				<section id="storySection">
					<div class="detailSection">
						<form action="storyUpdatePro.cm?id=<%=article.getId()%>&page=<%=nowPage%>" method='post' id="storyWriteForm" >
							<div>
								<div>
									<input type='text' name='updateTitle' id="writeTitle"
										maxlength="30" placeholder="제목을 입력해주세요."
										value="<%=article.getTitle()%>">
								</div>
								<div class="textLength">
									<div class="textCount">0</div>
									<div class="textTotal">/ 30</div>
								</div>
							</div>
							<div>
								<hr id="hr2" />
								<div class="errorTxt"></div>
							</div>
							<div style="margin: 20px 0;">
							<input type="hidden" value="<%=article.getCategory()%>" name="selectedCategory">
								카테고리 <select name="updateCategory" id="writeCategory">
									<option>선택</option>
									<option>레시피</option>
									<option>노하우</option>
									<option>농장소개</option>
									<option>텃밭자랑</option>
								</select>
								<div class="errorTxt"></div>
							</div>
							<div>
								썸네일 이미지<br> <br>
								<div class="storyThumbnail">
									<div class="thumbnailUpdBG">
										<img src="images/community/<%=article.getThumbnail()%>" style='width:200px;'>
									</div>
								</div>
								</td>
								<div class="errorTxt"></div>
							</div>
							<div>
								<textarea name="updateContents" id="writeContents"
									placeholder="내용을 입력해주세요."><%=article.getContents()%></textarea>
							</div>
							<input type='submit' value='수정완료' class="bigbtn2">
						</form>
					</div>
				</section>
			</div>


		</c:otherwise>
	</c:choose>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>