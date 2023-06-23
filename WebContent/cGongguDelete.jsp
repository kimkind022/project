<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int postId = (Integer) request.getAttribute("postId");
	String nowPage = (String) request.getAttribute("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

	<form name="deleteForm" action="gongguDeletePro.cm?id=<%=postId%>"
		method="post">
		<input type="hidden" name="page" value="<%=nowPage%>" /> <input
			type="hidden" name="memberId" value="${ID}" />
	</form>
	<script type="text/javascript">
		(document).ready(function() {
			function f(){
				
				var result = confirm('게시글을 삭제하시겠습니까?');

				if (result) {
					$("form[name='deleteForm']").submit();
				} else {
					//no
				}
				
			};
			
		});
	</script>

</body>
</html>