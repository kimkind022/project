<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="notiDao" class="dao.NoticeDAO" />
<%
  // 알림 업데이트
  int notiRead = notiDao.selectListCount((String) session.getAttribute("ID"));
  session.setAttribute("NOTI", notiRead);
%>

<link href="styles/header.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script/header.js"></script>

<c:choose>
  <c:when test="${empty ID}">
    <input type="hidden" name="isLogin" value="false">
    <c:set var="isLogin" value="false" />
  </c:when>
  <c:otherwise>
    <input type="hidden" name="isLogin" value="true">
    <c:set var="isLogin" value="true" />
  </c:otherwise>
</c:choose>

<div style="width: 100%; height: 91px; position: relative;">
<div class="headerWrap">
  <header id="head">

    <div id="title">
      <a href="index.jsp" class="titleLink">
        <div>
          <img src="images/common/icon.png" id="titleIcon">
        </div>
        <div>
          <p id="logo">오늘의 마켓</p>
        </div>
      </a>
    </div>

    <div id="mainnav">
      <ul>
        <li id="navStoreLink">
          <a href="storeMain.pd?category=과일">스토어</a>
        </li>
        <li id="navCommunityLink">
          <a href="communityMain.cm">커뮤니티</a>
        </li>
        <li id="navFundingLink">
          <a href="fundingMain.fd">펀딩</a>
        </li>
      </ul>
    </div>


    <div class="search">
      <input type="text" name="search" placeholder="검색어를 입력해주세요.">
      <img src="images/common/search.png" id="searchIcon">
    </div>


    <ul id="logInOutNav">
      <c:choose>
        <c:when test="${empty ID}">
          <li>
            <a href="login.jsp">로그인</a>
          </li>
          <li>|</li>
          <li>
            <a href="join.jsp">회원가입</a>
          </li>
          <li>|</li>
          <li>
            <a href="inquiryList.fd">고객센터</a>
          </li>
        </c:when>
        <c:otherwise>
          <li id="loginUser">${NICKNAME}님
            <div id="userMenu">
              <div><a href="vege.user?command=myStory">마이페이지</a> </div>
              <div><a href="vege.user?command=myOrder">나의 쇼핑</a></div>
              <div>
                <a href="inquiryList.fd">고객센터</a>
              </div>
              <div>
                <a href="logoutResult.jsp">로그아웃</a>
              </div>
            </div>
          </li>
          <li>
            <a href="vege.user?command=notice">
              <c:choose>
                <c:when test="${NOTI ne 0}">
                  <img src="images/common/notice3.png" />
                  <c:set var="isLogin" value="false" />
                </c:when>
                <c:otherwise>
                  <img src="images/common/notice.png" />
                  <c:set var="isLogin" value="true" />
                </c:otherwise>
              </c:choose>
            </a>
          </li>
          <li>
    	     <a href="vege.user?command=myHeart_products">
          	  <img src="images/common/heart.png" />
          	 </a>
          </li>
          <li>
            <a href="storeBasket.pd">
              <img src="images/common/cart.png" />
            </a>
          </li>
        </c:otherwise>
      </c:choose>
    </ul>
  </header>
  <hr />

  <div id="subnavBG">
    <nav id="subnav">
      <div id="sNav">
        <ul>
          <li>
            <a href="storeMain.pd?category=과일">홈</a>
          </li>
          <li>
            <a href="storeMain.pd?category=과일">스토어</a>
          </li>
          <li>
            <a href="storeFrequent.pd">자주구매</a>
          </li>
        </ul>
      </div>
      <div id="cNav">
        <ul>
          <li>
            <a href="communityMain.cm">홈</a>
          </li>
          <li>
            <a href="storyList.cm?page=1">스토리</a>
          </li>
          <li>
            <a href="gongguList.cm?page=1">공동구매</a>
          </li>
          <li>
            <a href="communityMain.jsp">우리동네 장터찾기</a>
          </li>
        </ul>
      </div>
      <div id="fNav">
        <ul>
          <li>
            <a href="fundingMain.fd">홈</a>
          </li>
          <li>
            <a href="fundingList.fd">펀딩 전체보기</a>
          </li>
          <li>
            <a href="priceComparison.fd">농산물 가격동향</a>
          </li>

        </ul>
      </div>
    </nav>
    <hr />
  </div>
</div>
</div>