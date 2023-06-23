<%@page import="java.util.ArrayList"%>
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

<style>
.sectionWrap {
	width: 100%;
}

section {
	width: 900px;
	height: 1289px;
	margin: 0 auto;
	background-color: lightgray;
}

section .sectionTitle {
	width: 100%;
	height: 35px;
	display: flex;
	align-items: flex-end;
	margin: 50px 0 20px 0;
}

section .sectionTitle>div {
	float: left;
}

section .sectionTitle>div:nth-child(1) {
	font-size: 20pt;
	font-weight: 700;
	margin-right: 20px;
}

section input[name=title] {
	border: 1px solid black;
	padding: 10px 30px;
	width: calc(100% - 60px - 2px);
	margin: 10px 0 20px 0;
}

section textarea[name=contents] {
	border: 1px solid black;
	padding: 50px 30px 10px 30px;
	width: calc(100% - 60px - 2px);
	height: 400px;
}

section .submitButton {
	width: 220px;
	margin: 10px auto;
	display: flex;
	justify-content: space-between;
}

section .submitButton input {
	width: 100px;
	height: 40px;
}
</style>

<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
      <div class="sectionTitle">
        <div>글쓰기</div>
      </div>
      <form action="inquiryWrite.fd" method="post" onsubmit="return isLogin()">
        <div>
          <input type="text" name="title" placeholder="제목을 입력해주세요">
          <textarea name="contents" placeholder="내용을 입력해주세요"></textarea>
        </div>
        <div class="submitButton">
          <a href="inquiryList.fd">
            <input type="button" value="취소">
          </a>
          <input type="submit" value="완료">
        </div>
      </form>
    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
  $(document).ready(function() {
    if (isLogin()) {
    } else {
      location.href = 'fAlert.jsp';
    }
  });

  function isLogin() {
    if ($('input[name=isLogin]').val() == "false") {
      return false;
    }
    return true;
  }
  
  window.history.forward();
  function noBack() {
    window.history.forward();
  }
</script>

</html>