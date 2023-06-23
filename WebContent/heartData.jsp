<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  String productId = request.getParameter("productId");
	System.out.println(productId);
%>
<%
	int checkExecute = (int)request.getAttribute("checkExecute");
	System.out.println("위치: heartData.jsp, checkExecute 값: "+checkExecute);
%>
<% out.println(checkExecute); %>
