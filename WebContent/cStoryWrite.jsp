<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>스토리</title>
</head>

<link href="styles/communityStory.css" rel="stylesheet" type="text/css">
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>


<body>

	<c:if test="${empty ID}">
	out.println("<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>")
</c:if>

	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap1">
		<section id="storySection">
			<div class="detailSection">
				<form action='storyWritePro.cm' method='post' id="storyWriteForm"
					enctype="multipart/form-data">
					<div>
						<div>
							<input type='text' name='writeTitle' id="writeTitle"
								maxlength="30" placeholder="제목을 입력해주세요.">
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
						카테고리 <select name="writeCategory" id="writeCategory">
							<option>선택</option>
							<option>레시피</option>
							<option>노하우</option>
							<option>농장소개</option>
							<option>텃밭자랑</option>
						</select>
						<div class="errorTxt"></div>
					</div>
					<div>
						썸네일 이미지<br>
						<br>
						<div class="storyThumbnail"></div>
						<input type="file" name="filename">
						</td>
						<div class="errorTxt"></div>
					</div>
					<div>
						<textarea name="writeContents" id="writeContents" maxlength="3000"
							placeholder="내용을 입력해주세요."></textarea>
					</div>
					<input type='submit' value='작성완료' class="bigbtn2">
				</form>
			</div>
		</section>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>