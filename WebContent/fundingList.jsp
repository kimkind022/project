<%@page import="dto.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="Dateutil" class="util.Dateutil" />
<c:set var="Dateutil" value="${Dateutil}" />

<c:set var="listCount" value="${pageInfo.getListCount()}" />
<c:set var="nowPage" value="${pageInfo.getPage()}" />
<c:set var="maxPage" value="${pageInfo.getMaxPage()}" />
<c:set var="startPage" value="${pageInfo.getStartPage()}" />
<c:set var="endPage" value="${pageInfo.getEndPage()}" />

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>펀딩 게시판</title>
</head>

<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/fundingList.js"></script>
<link href="styles/fundingList.css" rel="stylesheet" type="text/css">

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <section>
      <div class="pageTitle">펀딩 목록</div>
      <div class="categoryIcon">
      <input type="hidden" name="status3Value" value="${pageStatus.getStatus3()}">
      <div>
          <div class="iconDiv" id="all">
            <img src=images/common/zoomin.png onerror="this.onerror=null; this.src='images/common/noimg.png';">
          </div>
          <div class="categoryText">전체</div>
        </div>
        <div>
          <div class="iconDiv" id="vegetable">
            <img src=images/common/vegetable.png onerror="this.onerror=null; this.src='images/common/noimg.png';">
          </div>
          <div class="categoryText">채소</div>
        </div>
        <div>
          <div class="iconDiv" id="fruit">
            <img src=images/common/fruit.png onerror="this.onerror=null; this.src='images/common/noimg.png';">
          </div>
          <div class="categoryText">과일</div>
        </div>
        <div>
        <div class="iconDiv" id="grain">
          <img src=images/common/grain.png onerror="this.onerror=null; this.src='images/common/noimg.png';">
        </div>
        <div class="categoryText">곡류</div>
      </div>
      <div>
        <div class="iconDiv" id="jam">
          <img src=images/common/jam.png onerror="this.onerror=null; this.src='images/common/noimg.png';">
        </div>
        <div class="categoryText">잼/청류</div>
      </div>
      <div>
        <div class="iconDiv" id="showmore">
          <img src=images/common/showmore.png onerror="this.onerror=null; this.src='images/common/noimg.png';">
        </div>
        <div class="categoryText">기타</div>
      </div>
  </div>
  <div class="writeButton" style="display: none;">
    <input type="button" name="write" value="글쓰기">
  </div>
  <div class="statusSelect">

    <input type="hidden" name="status2Value" value="${pageStatus.getStatus2()}">
    <select name=status2>
      <option value="startDateDesc">최신순</option>
      <option value="minPriceAsc">낮은가격순</option>
      <option value="sumCostDesc">펀딩액순</option>
      <option value="endDateAsc">마감일순</option>
    </select>

    <input type="hidden" name="statusValue" value="${pageStatus.getStatus()}">
    <select name=status>
      <option value="all">전체</option>
      <option value="proceeding">진행중</option>
      <option value="ended">종료된</option>
    </select>
  </div>
  <ul class="postList">
    <c:choose>
      <c:when test="${fundingList !=null && listCount > 0}">
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
              <div class="price">
                <c:choose>
                  <c:when test="${empty fundingList.getMinPrice()}">
                      등록된 리워드가 없습니다
                  </c:when>
                  <c:otherwise>
                    <fmt:formatNumber value="${fundingList.getMinPrice()}"
                      groupingUsed="true"
                    />
                    <label>원  부터</label>
                  </c:otherwise>
                </c:choose>

              </div>
              <div class="sellerId">${fundingList.getSellersBean().getNickname()}
                <label>업체</label>
              </div>
              <div class="gage">
                <c:set var="gage"
                  value="${100 * fundingList.getSumCost() div fundingList.getTargetAmount()}"
                 />
                <c:if test="${gage > 100}">
                  <c:set var="gege" value="100%"></c:set>
                </c:if>
                <span style="width: calc(${gage}%);"></span>
              </div>
              <div class="last">
                <div class="left">
                  <div class="gagePer">
                    <fmt:formatNumber value="${gage}" pattern="##################" />
                    %
                  </div>
                  <div class="totalCost">
                    <fmt:formatNumber value="${fundingList.getSumCost()}"
                      pattern="###,###,###,###,###,###"
                    />
                    원
                  </div>
                </div>
                <div class="right">
                  <c:set var="endDate" value="${Dateutil.txtDate(fundingList.getEndDate())}" />
                  <c:choose>
                    <c:when test="${fn:contains(endDate, '후')}">
                      <div class="endDate">${endDate}마감</div>
                    </c:when>
                    <c:otherwise>
                      <div class="endDate">종료</div>
                    </c:otherwise>
                  </c:choose>
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
  <div class="addButton">
    <input type="hidden" name="nowPage" value="${pageInfo.getPage()}">
    <button type="button" class="listAdd">
      <div>더보기</div>
      <div class="postCount"></div>
      <div>/</div>
      <div class="listCount">${pageInfo.getListCount()}</div>
    </button>
  </div>
  </section>

  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>