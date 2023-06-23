<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="isLike" value="${!empty ID && heartsList.containsKey(ID)}" />
<c:choose>
  <c:when test="${heartsList.containsKey(ID)}">
    <img class="likeIcon" src="images/common/heart3.png">
  </c:when>
  <c:otherwise>
    <img class="likeIcon" src="images/common/heart2.png">
  </c:otherwise>
</c:choose>
<div>${heartsList.size()}명</div>