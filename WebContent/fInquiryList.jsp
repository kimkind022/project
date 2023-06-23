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
<title>Insert title here</title>
</head>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/inquiryList.js"></script>
<link href="styles/inquiryList.css" rel="stylesheet" type="text/css">

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="wrap0">
    <div class="sectionWrap2">
      <section>
        <div class="sectionTitle">
          <div>공지사항</div>
          <div>오늘의마켓의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요</div>
        </div>
        <div class="postWrite">
          <input type="button" name="write" value="작성하기">
        </div>
        <table>
          <tr>
            <td>번호</td>
            <td>제목</td>
            <td>작성자</td>
            <td>등록일</td>
          </tr>
          <c:choose>
            <c:when test="${inquiryList !=null && pageInfo.getListCount() > 0}">
              <c:forEach var="inquiryList" items="${inquiryList}" varStatus="status">
                <tr class="item">
                  <td>${inquiryList.getId()}</td>
                  <td>${inquiryList.getTitle()}</td>
                  <td>${NicknameList.get(inquiryList.getMemberId())}</td>
                  <td>${Dateutil.txtDate(inquiryList.getDate())}</td>
                </tr>
                <tr class="hide">
                  <td colspan="3">${inquiryList.getContents()}</td>
                  <td>
                    <c:if test="${inquiryList.getMemberId() eq ID}">
                      <c:url var="inquiryUpdatePro" value="inquiryUpdatePro.fd">
                        <c:param name="id" value="${inquiryList.getId()}"></c:param>
                      </c:url>
                      <a href="${inquiryUpdatePro}">수정</a>
								/
								<c:url var="postDelete" value="inquiryDelete.fd">
                        <c:param name="id" value="${inquiryList.getId()}"></c:param>
                      </c:url>
                      <a href="${postDelete}">삭제</a>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr class="item">
                <td></td>
                <td>등록된 글이 없습니다</td>
                <td></td>
                <td></td>
              </tr>
            </c:otherwise>
          </c:choose>
        </table>


        <ul class="pageList">
          <c:choose>
            <c:when test="${pageInfo.getPage() <= 1}">
              <li>[이전]</li>
            </c:when>
            <c:otherwise>
              <li>
                <a href=inquiryList.fd?page=${pageInfo.getPage()-1}>[이전]</a>
              </li>
            </c:otherwise>
          </c:choose>
          <c:forEach var="pageNum" begin="${pageInfo.getStartPage()}" end="${pageInfo.getEndPage()}" step="1">
            <c:choose>
              <c:when test="${pageNum == pageInfo.getPage()}">
                <li>[${pageNum}]</li>
              </c:when>
              <c:otherwise>
                <li>
                  <a href=inquiryList.fd?page=${pageNum}>[${pageNum}]</a>
                </li>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          <c:choose>
            <c:when test="${pageInfo.getPage() >= pageInfo.getMaxPage()}">
              <li>[다음]</li>
            </c:when>
            <c:otherwise>
              <li>
                <a href="inquiryList.fd?page=${pageInfo.getPage()+1}">[다음]</a>
              </li>
            </c:otherwise>
          </c:choose>
        </ul>

      </section>
    </div>
  </div>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>

</body>
</html>