<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<title>흔적 남기기 게시판</title>
</head>
<body>
	<%
		session.invalidate(); // 현재 이 페이지에 접속하게 되면 가지고 있던 세션권한을 빼앗기게 됨.
		
	%>
	<script>
		location.href ='main.jsp';
	</script>
</body>
</html>









