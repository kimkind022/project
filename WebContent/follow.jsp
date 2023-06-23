<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>
<%
	String todo = (String)request.getParameter("todo");
	String memberId = (String)request.getParameter("memberId"); // 작성자
	String followerId = (String)request.getParameter("followerId"); // 팔로워
%>
<%
	Connection conn = null;
	Statement stmt = null;
	String result = null;
	
	if(todo.equals("insert")){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
					"root", "1234");
			stmt = conn.createStatement();
			String command = "insert into follow (memberId, followerId) values('"+memberId+"','"+followerId+"');";
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
	}
	else if(todo.equals("delete")){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
					"root", "1234");
			stmt = conn.createStatement();
			String command = "delete from follow where memberId='"+memberId+"' and followerId='"+followerId+"';";
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
	}
%>

<%=result%>