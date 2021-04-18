<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="tzs.TzsDAO" %>
<%@ page import ="tzs.Tzs" %>
<%@ page import ="java.io.PrintWriter" %> <!--  자바스크립트 문장을 사용하기위해 import -->
<%
request.setCharacterEncoding("UTF-8");
%> <!--  건너오는 데이터를 모두 UTF-8로 받기 위한 세팅 -->
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
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}int tzsID = 0;
		if(request.getParameter("tzsID") !=null){
			tzsID = Integer.parseInt(request.getParameter("tzsID"));
		}
		if(tzsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		Tzs tzs = new TzsDAO().getTzs(tzsID);
		if(!userID.equals(tzs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if(request.getParameter("tzsTitle") == null || request.getParameter("tzsContent") == null
					|| request.getParameter("tzsTitle").equals(" ") || request.getParameter("tzsContent").equals(" ")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 존재합니다.')");
				script.println("history.back()"); 
				script.println("</script>");
				} else {
					TzsDAO tzsDAO = new TzsDAO();
					int result = tzsDAO.update(tzsID, request.getParameter("tzsTitle"), request.getParameter("tzsContent"));
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')"); // PK가 userID이기 때문
						script.println("history.back()"); 
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'TZS.jsp'");
						script.println("</script>");
					}
				}
		}
	%>	
</body>
</html>









