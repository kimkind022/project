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

<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
      <input type="hidden" name="value" value="${param.value}">

    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
  $(document).ready(function() {
    let value = $('input[name=value]').val();
    if (value == "joinError") {
      alert("잘못된 접근입니다.메인페이지로 이동합니다1");
      location.href = "index.jsp";
    } else if(value == "orderok") {
      alert("펀딩에 참여되었습니다");
      location.href = "index.jsp";
    }
    
    else {
      alert(value);
      alert("잘못된 접근입니다.메인페이지로 이동합니다2");
      location.href = "index.jsp";
    }
  });

  window.history.forward();
  function noBack() {
    window.history.forward();
  }
</script>

</html>