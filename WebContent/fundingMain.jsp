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
<meta charset="utf-8">
<title>MAIN</title>
</head>

<jsp:include page="common.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="slick/slick.css" />
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
<script type="text/javascript" src="slick/slick.min.js"></script>

<link href="styles/fundingMain.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script/fundingMain.js"></script>

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
      <div id="leftRow">
        <div class="fundingAD">
          <div class='fade'>
            <div>
              <img src="images/index/slider1.png">
            </div>
            <div>
              <img src="images/index/slider2.png">
            </div>
            <div>
              <img src="images/index/slider3.png">
            </div>
          </div>
        </div>
        
        <!-- 1번째줄 -->
        <c:set var="fundingList" value="${resentView}" />
        <c:if test="${fundingList != null}">
          <div class="sortRow">
            <div class="containerTitle">최근 본 프로젝트</div>
            <ul class='<c:if test="${fundingList.size() > 3}">multiple-items</c:if>'>
              <c:forEach var="fundingList" items="${fundingList}" varStatus="status">
                <li>
                  <div class="fundingPost">

                    <div class="thumbnail">
                      <a href=fundingDetail.fd?id=${fundingList.getId()}>
                        <img src=images/funding/${fundingList.getThumbnail()}
                          onerror="this.onerror=null; this.src='images/common/noimg.png';"
                        >
                      </a>
                    </div>
                    <div class="title">
                      <a href=fundingDetail.fd?id=${fundingList.getId()}> ${fundingList.getTitle()} </a>
                    </div>
                    <c:set var="gage" value="${100 * fundingList.getSumCost() div fundingList.getTargetAmount()}" />
                    <div class="last">
                      <div class="left">
                        <div class="gagePer">
                          <fmt:formatNumber value="${gage}" pattern="##################" />
                          %
                        </div>
                      </div>
                      <div>ᆞ</div>
                      <div class="right">
                        <div class="sellerId">
                          ${fundingList.getSellersBean().getNickname()}
                          <label>업체</label>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </div>
        </c:if>
        
        <!-- 2번째줄 -->
        <div class="fundingDeadline">
          <div class="containerTitle">마감임박 프로젝트</div>
          <div class="allShow" id="endDateAsc">전체보기</div>
          <ul class="multiple-items">
            <c:set var="fundingList" value="${endDateAsc}" />
            <c:choose>
              <c:when test="${fundingList != null}">
                <c:forEach var="fundingList" items="${fundingList}" varStatus="status">
                  <li>
                    <div class="fundingPost">

                      <div class="thumbnail">
                        <a href=fundingDetail.fd?id=${fundingList.getId()}>
                          <img src=images/funding/${fundingList.getThumbnail()}
                            onerror="this.onerror=null; this.src='images/common/noimg.png';"
                          >
                        </a>
                      </div>
                      <div class="title">
                        <a href=fundingDetail.fd?id=${fundingList.getId()}> ${fundingList.getTitle()} </a>
                      </div>
                      <c:set var="gage" value="${100 * fundingList.getSumCost() div fundingList.getTargetAmount()}" />
                      <div class="last">
                        <div class="left">
                          <div class="gagePer">
                            <fmt:formatNumber value="${gage}" pattern="##################" />
                            %
                          </div>
                        </div>
                        <div>ᆞ</div>
                        <div class="right">
                          <div class="sellerId">
                            ${fundingList.getSellersBean().getNickname()}
                            <label>업체</label>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <li>
                  <div class="fundingPostEmpty">등록된 글이 없습니다</div>
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>

        <!-- 3번째줄 -->
        <div class="sortRow">
          <div class="containerTitle">신규 프로젝트</div>
          <div class="allShow" id="startDateDesc">전체보기</div>
          <ul class="multiple-items">
            <c:set var="fundingList" value="${startDateDesc}" />
            <c:choose>
              <c:when test="${fundingList != null}">
                <c:forEach var="fundingList" items="${fundingList}" varStatus="status">
                  <li>
                    <div class="fundingPost">
                      <div class="thumbnail">
                        <a href=fundingDetail.fd?id=${fundingList.getId()}>
                          <img src=images/funding/${fundingList.getThumbnail()}
                            onerror="this.onerror=null; this.src='images/common/noimg.png';"
                          >
                        </a>
                      </div>
                      <div class="title">
                        <a href=fundingDetail.fd?id=${fundingList.getId()}> ${fundingList.getTitle()} </a>
                      </div>
                      <c:set var="gage" value="${100 * fundingList.getSumCost() div fundingList.getTargetAmount()}" />
                      <div class="last">
                        <div class="left">
                          <div class="gagePer">
                            <fmt:formatNumber value="${gage}" pattern="##################" />
                            %
                          </div>
                        </div>
                        <div>ᆞ</div>
                        <div class="right">
                          <div class="sellerId">
                            ${fundingList.getSellersBean().getNickname()}
                            <label>업체</label>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <li>
                  <div class="fundingPostEmpty">등록된 글이 없습니다</div>
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>
      </div>

      <div id="rightRow">
        <!-- 우측 -->
        <div class="fundingRanking">
          <div class="containerTitle">실시간 랭킹</div>
          <div class="allShow" id="sumCostDesc">전체보기</div>
          <ul>
            <c:set var="fundingList" value="${sumCostDesc}" />
            <c:choose>
              <c:when test="${fundingList != null}">
                <c:forEach var="fundingList" items="${fundingList}" varStatus="status">
                  <li>
                    <div class="fundingPost">
                      <div class="thumbnail">
                        <a href=fundingDetail.fd?id=${fundingList.getId()}>
                          <img src=images/funding/${fundingList.getThumbnail()}
                            onerror="this.onerror=null; this.src='images/common/noimg.png';"
                          >
                        </a>
                      </div>
                      <c:choose>
                        <c:when test="${status.count < 4}">
                          <div class="num" style="color: rgb(240, 93, 35);">${status.count}</div>
                        </c:when>
                        <c:otherwise>
                          <div class="num">${status.count}</div>
                        </c:otherwise>
                      </c:choose>
                      <div class="contents">
                        <div class="title">
                          <a href=fundingDetail.fd?id=${fundingList.getId()}> ${fundingList.getTitle()} </a>
                        </div>
                        <c:set var="gage" value="${100 * fundingList.getSumCost() div fundingList.getTargetAmount()}" />
                        <div class="last">
                          <div class="left">
                            <div class="gagePer">
                              <fmt:formatNumber value="${gage}" pattern="##################" />
                              %
                            </div>
                          </div>
                          <div>ᆞ</div>
                          <div class="right">
                            <div class="sellerId">
                              ${fundingList.getSellersBean().getNickname()}
                              <label>업체</label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <li>
                  <div class="fundingPostEmpty">등록된 글이 없습니다</div>
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>
      </div>

    </section>
  </div>

  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>

</html>