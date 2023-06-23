<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%
	String personnelId = request.getParameter("personnelId");
	String postId = request.getParameter("postId");
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

		String command = "Update gonggu set personnelval=personnelval-1 where id=" + postId + ";";
		int rowNum = stmt.executeUpdate(command);

		result = "1";

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

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
				"root", "1234");
		stmt = conn.createStatement();

		String command = "delete from gongguPersonnels where postId='" +postId+ "'and personnelId='"+personnelId+"';";
		int rowNum = stmt.executeUpdate(command);

		result = "1";

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