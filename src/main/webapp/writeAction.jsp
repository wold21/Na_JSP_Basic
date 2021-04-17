<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="tzs.TzsDAO" %> <!--  만든 클래스 임포트 -->
<%@ page import ="java.io.PrintWriter" %> <!--  자바스크립트 문장을 사용하기위해 import -->
<%
request.setCharacterEncoding("UTF-8");
%> <!--  건너오는 데이터를 모두 UTF-8로 받기 위한 세팅 -->
<jsp:useBean id="tzs" class="tzs.Tzs" scope="page"/> <!-- 만든 User를 사용, 스코프 -> 빈즈의 포커스를 정할 수 있다. -->
<jsp:setProperty name="user" property="tzsTitle"/> <!--  login.jsp에서 넘겨준 userID를 그대로 받아서 한명의 user에 정보를 세팅해준다. -->
<jsp:setProperty name="user" property="tzsContent"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<title>흔적 남기기 게시판</title>
</head>
<body>
	<%
	String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			}
			
			if(userID != null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 하세요.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			} else {
				if(tzs.getTzsTitle() == null || tzs.getTzsContent() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력되지 않은 사항이 존재합니다.')");
					script.println("history.back()"); 
					script.println("</script>");
					} else {
						TzsDAO tzsDAO = new TzsDAO();
						int result = tzsDAO.write(tzs.getTzsTitle(), userID, tzs.getTzsContent());
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다.')"); // PK가 userID이기 때문
							script.println("history.back()"); 
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'tzs.jsp'");
							script.println("</script>");
						}
				}
			}

	%>	
</body>
</html>









