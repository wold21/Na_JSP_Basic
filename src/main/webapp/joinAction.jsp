<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %> <!--  만든 클래스 임포트 -->
<%@ page import ="java.io.PrintWriter" %> <!--  자바스크립트 문장을 사용하기위해 import -->
<% request.setCharacterEncoding("UTF-8"); %> <!--  건너오는 데이터를 모두 UTF-8로 받기 위한 세팅 -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- 만든 User를 사용, 스코프 -> 빈즈의 포커스를 정할 수 있다. -->
<jsp:setProperty name="user" property="userID"/> <!--  login.jsp에서 넘겨준 userID를 그대로 받아서 한명의 user에 정보를 세팅해준다. -->
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<title>흔적 남기기 게시판</title>
</head>
<body>
	<%
	
		if(user.getUserID() == null ||user.getUserPassword() == null ||user.getUserName() == null ||
				user.getUserGender() == null ||user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 항목이 존재합니다.')");
			script.println("history.back()"); 
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('해당 아이디가 존재합니다.')"); // PK가 userID이기 때문
				script.println("history.back()"); 
				script.println("</script>");
			} else {
				session.setAttribute("userID", user.getUserID()); // 세션값 부여
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	
		
	%>	
</body>
</html>









