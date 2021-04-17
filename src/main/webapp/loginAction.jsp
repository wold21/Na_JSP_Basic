<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %> <!--  만든 클래스 임포트 -->
<%@ page import ="java.io.PrintWriter" %> <!--  자바스크립트 문장을 사용하기위해 import -->
<% request.setCharacterEncoding("UTF-8"); %> <!--  건너오는 데이터를 모두 UTF-8로 받기 위한 세팅 -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- 만든 User를 사용, 스코프 -> 빈즈의 포커스를 정할 수 있다. -->
<jsp:setProperty name="user" property="userID"/> <!--  login.jsp에서 넘겨준 userID를 그대로 받아서 한명의 user에 정보를 세팅해준다. -->
<jsp:setProperty name="user" property="userPassword"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<title>흔적 남기기 게시판</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); // 자바 빈즈의 값, -2 ~ 1까지의 값이 담기게 될 것이다.
		
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()"); // 로그인 페이지로 사용자 리다이렉션
			script.println("</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()"); 
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()"); 
			script.println("</script>");
		}
	%>
	%>
		
</body>
</html>









