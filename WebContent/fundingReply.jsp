<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="Dateutil" class="util.Dateutil" />
<c:set var="Dateutil" value="${Dateutil}" />

<c:choose>
  <c:when test="${fundingReplyList !=null}">
    <c:forEach var="fundingReply" items="${fundingReplyList}" varStatus="status">
      <div class="replyList">
        <div>${fundingReply.value.getMemberId()}</div>
        <div>${fundingReply.value.getContents()}</div>
        <div>${Dateutil.txtDate(fundingReply.value.getDate())}</div>
      </div>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <div class="replysList">
      <div></div>
      <div>등록된 리뷰가 없습니다</div>
      <div></div>
    </div>
  </c:otherwise>
</c:choose>