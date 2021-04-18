<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %> 
<%@ page import = "tzs.Tzs" %> 
<%@ page import = "tzs.TzsDAO" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>흔적 남기기 게시판</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int tzsID = 0;
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
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">흔적 남기기 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="TZS.jsp">게시판</a></li>
			</ul>
			<% 
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">접속하기<span class="caret"></span></a> <!-- caret 아이콘같은 것. -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li> <!-- active는 한개만 존재할 수 있다. -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% 	
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">회원관리<span class="caret"></span></a> <!-- caret 아이콘같은 것. -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li> <!-- active는 한개만 존재할 수 있다. -->
					</ul>
				</li>
			</ul>	
			<% 
				}		
			%>
			
		</div>
	</nav>
	<div class ="container">
		<div class ="row">
			<table class = "table table-striped" style="text-align: center; border: 1px solid #dddddd"> <!--  table-striped -> 홀짝마다 색이 조금 다르게 보여짐-->
				<thead> <!-- 컬럼을 보여줌-->
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align:center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%= tzs.getTzsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td> <!--  스크립트문 방어 -->
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= tzs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= tzs.getTzsDate().substring(0, 11) + tzs.getTzsDate().substring(11, 13) + "시" + tzs.getTzsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= tzs.getTzsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td> <!--  nbsp는 html에서 공백으로 치환 됨. -->
					</tr>
				</tbody>
			</table>
			<a href="TZS.jsp" class="btn btn-primary">목록</a>
			<% 
				if(userID != null && userID.equals(tzs.getUserID())){
			%>
					<a href="update.jsp?tzsID=<%= tzsID %>" class="btn btn-primary">수정</a>
					<a href="deleteAction.jsp?tzsID=<%= tzsID %>" class="btn btn-primary">삭제</a>
			<% 
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>









