<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
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
      <c:choose>
        <c:when test="${pageContext.request.method != 'POST'}">
          <input type="hidden" name="isPost" value="false">
        </c:when>
        <c:when
          test="${empty param.id || 
          empty param.emailSelect || 
          empty param.pw || 
          empty param.name || 
          empty param.nickname || 
          empty param.year || 
          empty param.month || 
          empty param.day || 
          empty param.tel || 
          empty param.address || 
          empty param.addressInfo}"
        >
          <input type="hidden" name="isPost" value="false">
        </c:when>
        <c:otherwise>
          <jsp:useBean id="dao" class="classes.MembersDAO" />
          <jsp:useBean id="dto" class="dto.MembersBean" />
          <input type="hidden" name="isPost" value="true">
          <%
          String id = request.getParameter("id") + "@" + request.getParameter("emailSelect");
          String month = request.getParameter("month");
          
          if (month.length() != 2) {
            month = "0" + month;
            }
          String day = request.getParameter("day");
          if (day.length() != 2) {
            day = "0" + day;
            }
          String birthday = request.getParameter("year") + month + day;
          
          Boolean email = false;
          Boolean sns = false;
          Boolean app = false;
          if(("email").equals(request.getParameter("agree3"))){
            email = true;
          }
          if(("sns").equals(request.getParameter("agree4"))){
            sns = true;
          }
          if(("app").equals(request.getParameter("agree5"))){
            app = true;
          }
          
          JSONObject pushList = new JSONObject();
          pushList.put("email", email);
          pushList.put("sns", sns);
          pushList.put("app", app);
          
          String push = pushList.toJSONString();
          
          dto.setId(id);
          dto.setPw(request.getParameter("pw"));
          dto.setName(request.getParameter("name"));
          dto.setNickname(request.getParameter("nickname"));
          dto.setBirthday(birthday);
          dto.setTel(request.getParameter("tel"));
          dto.setAddress1(request.getParameter("address"));
          dto.setAddress2(request.getParameter("addressInfo"));
          dto.setPush(push);
          
          dao.Insert(dto);
          %>
        </c:otherwise>
      </c:choose>

    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
  $(document).ready(function() {
    let isPost = $('input[name=isPost]').val();
    if (isPost != "true") {
      location.href = "fAlert.jsp?value=joinError";
    } else {
      alert("회원가입이 완료되었습니다");
      location.href = "login.jsp";
    }
  });

  window.history.forward();

  function noBack() {
    window.history.forward();
  }
</script>

</html>