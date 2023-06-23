<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="Dateutil" class="util.Dateutil" />
<c:set var="Dateutil" value="${Dateutil}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<!-- 주소검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="script/addressFind.js"></script>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/mPush.js"></script>
<link href="styles/mypage.css" rel="stylesheet" type="text/css">

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">

    <nav class="mypageNav">
      <div class="mpMainNav">
        <ul>
          <li>
            <a href="vege.user?command=myStory">프로필</a>
          </li>
          <li><a href="vege.user?command=notice">알림</a></li>
          <li><a href="vege.user?command=myOrder">나의 쇼핑</a></li>
          <li><a href="vege.user?command=myFunding">나의 펀딩</a></li>
          <li class="nowpage">
            <a href="vege.user?command=editUserInfo">설정</a>
          </li>
        </ul>
      </div>
      <hr />
    </nav>
    <nav class="mypageNav">
      <div>
        <ul>
          <li>
            <a href="vege.user?command=editUserInfo">회원정보수정</a>
          </li>
          <li class="nowpage">
            <a href="editPushFrom.fd">알림 설정</a>
          </li>
          <li>
            <a href="vege.user?command=editPassword">비밀번호 변경</a>
          </li>
        </ul>
      </div>
      <hr />
    </nav>

    <section id="section770">
    
    <input type="hidden" name="push" email='${pushMap.get("email")}' sns='${pushMap.get("sns")}' app='${pushMap.get("app")}' >
    
      <form>
        <div>
          <p class="font19">이벤트 및 혜택 알림</p>
          <p class="font10">특가, 쿠폰 등 이벤트 정보 수신 동의</p>
        </div>
        <div class="wrap770">
          <div class="switchWrap">
            <span>이메일</span>
            <input type="checkbox" id="switch1" name="email" value="이메일" hidden="hidden">
            <label for="switch1" class="switch_label">
              <span class="onf_btn"></span>
            </label>
          </div>
          <div class="switchWrap">
            <span>문자 메시지</span>
            <div>
              <input type="checkbox" id="switch2" name="sns" value="문자 메시지" hidden="hidden">
              <label for="switch2" class="switch_label">
                <span class="onf_btn"></span>
              </label>
            </div>
          </div>
          <div class="switchWrap">
            <span>앱 PUSH 알림</span>
            <div>
              <input type="checkbox" id="switch3" name="app" value="앱 PUSH 알림" hidden="hidden">
              <label for="switch3" class="switch_label">
                <span class="onf_btn"></span>
              </label>
            </div>
          </div>
        </div>
        <p class="font10">
          쇼핑몰에서 제공하는 신상품 소식/ 할인쿠폰을 무상으로 보내드립니다.<br> 단, 상품 구매 정보는 수신동의 여부 관계없이 발송됩니다.<br> 제공 동의를 하지 않으셔도 서비스
          이용에는 문제가 없습니다.
        </p>
      </form>
    </section>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>

</body>
</html>