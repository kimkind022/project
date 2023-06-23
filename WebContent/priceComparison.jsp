<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="common.jsp"></jsp:include>

<!-- 그래프 표시 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style type="text/css">
section {
	width: 900px;
	margin: 0px auto;
	padding: 40px 0;
}

section select {
	width: 100px;
	height: 30px;
	margin-right: 20px;
	border-radius: 5px;
	border: 1px solid gray;
}

section input[type=date] {
	width: 100px;
	height: 30px;
	margin-right: 20px;
	border-radius: 5px;
	border: 1px solid gray;
}

section .optionName {
	width: 75px;
}

.sectionTop {
	padding: 30px;
	width: calc(100% - 60px);
	display: flex;
	justify-content: space-between;
	background-color: #EAEAEA;
	margin-bottom: 40px;
}

.sectionTop .sectionLeft>div {
	margin-bottom: 30px;
}

.sectionTop .sectionLeft>div:last-child {
	margin-bottom: 0;
}

.itemChoose {
	display: flex;
}

.itemChoose>div {
	display: flex;
}

.dateChoose {
	display: flex;
}

.dateChooseButton {
	width: 320px;
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	display: flex;
	margin-left: -40px;
}

.dateChooseButton input[type=button] {
	width: 70px;
	height: 30px;
	border: 1px solid #EAEAEA;
}

input[name=priceSearch] {
	width: 100px;
	height: 100%;
	border: 1px solid gray;
}

#priceExcel {
	width: 900px;
}

.excelContents {
	width: 100%;
	height: 500px;
	display: none;
}

.excelChart {
	display: none;
	height: 470px;
	overflow-y: scroll;
}

#priceExcel table {
	border: 0;
	border-spacing: 0px;
	width: 100%;
	text-align: center;
}

#priceExcel table td {
	border: 1px solid black;
	width: 25%;
	height: 35px;
}

#priceExcel table tr:first-child {
	font-weight: 700;
}

#priceExcel table tr:first-child {
	position: sticky;
	top: 0;
}

#priceExcel table tr:first-child td {
	height: 50px;
	background-color: #EAEAEA;
}
</style>

<script type="text/javascript" src="script/priceComparison.js"></script>

</head>

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
      <div class="sectionTop">
        <div class="sectionLeft">
          <div class="itemChoose">
            <div>
              <div class="optionName">대분류</div>
              <select name="p_itemcategorycode">
                <option value="all">선택</option>
                <option value="100">식량작물</option>
                <option value="200">채소류</option>
                <option value="300">특용작물</option>
                <option value="400">과일류</option>
              </select>
            </div>
            <div>
              <div class="optionName">소분류</div>
              <select name="p_itemcode">
                <option value=all>선택</option>
              </select>
            </div>
          </div>
          <div class="dateChoose">
            <div class="optionName">시작일자</div>
            <input type="date" name="p_startday">
            <div class="optionName">종료일자</div>
            <input type="date" name="p_endday">

          </div>
        </div>
        <div class="dateChooseButton">
          <input type="button" value="1개월" name="oneMonth" class="dateButton">
          <input type="button" value="3개월" name="threeMonth" class="dateButton">
          <input type="button" value="6개월" name="sixMonth" class="dateButton">
          <input type="button" value="1년" name="oneYear" class="dateButton">
        </div>
        <div class="sectionRight">
          <input type="button" value="검색" name="priceSearch">
        </div>
      </div>

      <div id="priceExcel">
        <div class="excelTitle">조회된 결과가 없습니다</div>
        <div class="excelContents"></div>
        <div class="excelChart">
          <table>
            <tr>
              <td>조회일자</td>
              <td>금액</td>
              <td>전일대비등락가</td>
              <td>전일대비등락율</td>
            </tr>
          </table>
        </div>
      </div>
    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>