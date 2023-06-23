<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
			response.setCharacterEncoding("utf-8");
			request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/fundingWrite.js"></script>

<style>
section {
	width: 1200px;
	margin: 0 auto;
}

.optionsTable {
	border-spacing: 0;
}

.optionsTable th, .optionsTable td {
	padding: 20px 5px;
}
</style>

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
      <form action="fundingWritePro.fd" method="post" enctype="multipart/form-data" onsubmit="return submitCheck()">
        <table>
          <tr>
            <td>
              <label>카테고리</label>
            </td>
            <td>
              <select name="category">
                <option value="">선택</option>
                <option value="채소">야채</option>
                <option value="과일">과일</option>
                <option value="쌀/곡물">쌀/곡물</option>
                <option value="잼/청류">잼/청류</option>
                <option value="기타">기타</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>
              <label>제목</label>
            </td>
            <td>
              <input type="text" name="title">
            </td>
          </tr>
          <tr>
            <td>
              <label>목표금액</label>
            </td>
            <td>
              <input type="number" name="targetAmount">
              원
            </td>
          </tr>
          <tr>
            <td>
              <label>펀딩 마감일자</label>
            </td>
            <td>
              <input type="datetime-local" name="endDate">
            </td>
          </tr>
          <tr>
            <td>
              <label>썸네일</label>
            </td>
            <td>
              <ul>
                <li>
                  <input type="file" name="thumbnail">
                  <input type="button" name="thumbnailAdd">
                </li>
              </ul>

            </td>
          </tr>
          <tr>
            <td>
              <label>스토리 이미지</label>
            </td>
            <td>
              <input type="file" name="storyImage">
            </td>
          </tr>
          <tr>
            <td>
              <label>리워드 이미지</label>
            </td>
            <td>
              <input type="file" name="rewardsImage">
            </td>
          </tr>
          <tr>
            <td>
              <label>소식 이미지</label>
            </td>
            <td>
              <input type="file" name="newsImage">
            </td>
          </tr>
          <tr>
            <td>
              <label></label>
            </td>
            <td></td>
          </tr>
        </table>
        <table class="optionsTable">
          <tr>
            <td>
              <label>옵션명</label>
              <input type="text" name="options">
            </td>
            <td>
              <label>가격</label>
              <input type="text" name="price">
              원
            </td>
            <td>
              <label>펀딩 가능 최대 수량</label>
              <input type="text" name="limit">
              EA
            </td>
            <td></td>
          </tr>
        </table>
        <input type="button" value="옵션 추가" class="appendButton">
        <br> <br>
        <input type="submit" value="글완성" style="width: 200px; height: 200px; background-color: aqua;">


      </form>
    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>