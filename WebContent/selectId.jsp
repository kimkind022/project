
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>

<%
  String id = request.getParameter("id");
%>

<%
  Connection conn = null;
  Statement stmt = null;
  String result = null;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
        "root", "1234");
    stmt = conn.createStatement();
    String command = "select * from members where id = '" + id + "';";
    ResultSet rs = stmt.executeQuery(command);
    if (rs.next()) {
      result =
          "<div style='color:red'>이미 사용중인 이메일입니다</div><input type='hidden' value='false' name='idOverlap'>";

    } else {
      result =
          "<div style='color:green'>사용 가능한 이메일입니다.</div><input type='hidden' value='true' name='idOverlap'>";
    }
  } catch (Exception e) {
    out.println(e);
  } finally {
    try {
      stmt.close();
    } catch (Exception e) {
      out.println(e);
    }
    try {
      conn.close();
    } catch (Exception e) {
      out.println(e);
    }

  }
%>

<%=result%>




