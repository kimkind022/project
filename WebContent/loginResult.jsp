<%@page import="dto.MembersBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
			response.setCharacterEncoding("utf-8");
			request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="classes.MembersDAO" />
<jsp:useBean id="dto" class="dto.MembersBean" />
<jsp:useBean id="notiDao" class="dao.NoticeDAO" />
<%
  String id = request.getParameter("id");
			String pw = request.getParameter("pw"); // 폼에서 넘어온 아이디,비번

			String loginRs = dao.SelectLogin(id, pw); // 로그인 결과값
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- 주소검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="script/addressFind.js"></script>

<link href="styles/common.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="script/join.js"></script>
<link href="styles/join.css" rel="stylesheet" type="text/css">


<body>
  <!--헤더-->
  <div id="header1"></div>
  <%
    if (loginRs == "ok") {

  				MembersBean mem = new MembersBean();
  				mem = dao.Member(id);

  				String memId = mem.getId();
  				String memPw = mem.getPw();
  				String memNick = mem.getNickname();
  				String memImg = mem.getProfileImage();
  				
  				int notiRead = notiDao.selectListCount(memId);
  				

  				session.setAttribute("ID", id);
  				session.setAttribute("PW", pw);
  				session.setAttribute("NICKNAME", memNick);
  				session.setAttribute("PROFILEIMG", memImg);
  				session.setAttribute("NOTI", notiRead);
  %>

  <script>
      location.href = "index.jsp";
    </script>

  <%
    } else if (loginRs == "pwE") {
      out.println("<script>alert('비밀번호가 일치하지 않습니다.');history.go(-1);</script>");
    } else if (loginRs == "idE") {
      out.println("<script>alert('아이디가 일치하지 않습니다.');history.go(-1);</script>");
    } else if (loginRs == "idN") {
      out.println("<script>alert('아이디를 입력하세요.');history.go(-1);</script>");
    } else if (loginRs == "pwN") {
      out.println("<script>alert('비밀번호를 입력하세요.');history.go(-1);</script>");
    }
  %>


  <!--풋터-->
  <div id="footer1"></div>
</body>
</html>
