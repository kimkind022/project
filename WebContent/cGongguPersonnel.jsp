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
	String hasId = null;
	String result = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
				"root", "1234");
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from gongguPersonnels where postId=" + postId + ";");

		boolean b = true;
		
		if(rs.next()){
			 do {
				String personnelGet = rs.getString(2);
	
				if (personnelId.equals(personnelGet)) {
					hasId = "1";
					b = false;
				} else {
					hasId = "0";
				}
			} while (rs.next() && b);
		}
		else{
			hasId = "0";
		}
	} catch (Exception e) {
		System.out.println(e);
	}

	if (hasId == "0") {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
					"root", "1234");
			stmt = conn.createStatement();

			String command = "Update gonggu set personnelval=personnelval+1 where id=" + postId + ";";
			int rowNum = stmt.executeUpdate(command);

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

			String command = "insert into gongguPersonnels values('" + postId + "','" + personnelId + "');";
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
	} else if (hasId=="1"){
		result = "0";
	}
%>
<%=result%>