<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>
<style type="text/css">
</style>
</head>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/join.js"></script>
<link href="styles/join.css" rel="stylesheet" type="text/css">

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>

  <div class="wrap0">
    <section id="joinSection">
      <form name=login action="loginResult.jsp" method="post">
        <table>
          <tr align="center">
            <td colspan="2">
              <h1 style="font-size: 20pt; font-weight: 700">로그인</h1>
              <br>
            </td>
          </tr>
          <tr align="center">
            <td colspan="2">
              <div class="SNSSignUp">SNS계정으로 로그인하기</div>
              <div>
                <img src="images/join/navericon.png" width="40px" align="center" style="padding-right: 10px;">
                <img src="images/join/kakaoicon.png" width="40px" align="center" style="padding-right: 10px;">
                <img src="images/join/googleicon.png" width="40px" align="center">
              </div>
            </td>
          </tr>
          <tr align="center">
            <td colspan="2"></td>
          </tr>
          <tr align="center">
            <td colspan="2">
              <hr />
            </td>
          </tr>
          <tr>
            <td style="width:60px;">
              <span>이메일</span>
            </td>
            <td>
              <div class="emailDiv">
                <div>
                  <input type="text" name="id" maxlength="20" size="40" class="text">
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td style="width:60px;">
              <span>비밀번호</span>
            </td>
            <td>
              <input type="password" name="pw" maxlength="16" size="40" class="text">
            </td>
          </tr>
          <tr align="center">
            <td colspan="2">
            <a href="join.jsp">
                <input type="button" class="button" value="회원가입">
              </a>
              <input type="submit" class="button" value="로그인">
            </td>
          </tr>
        </table>
      </form>
    </section>
  </div>

  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>