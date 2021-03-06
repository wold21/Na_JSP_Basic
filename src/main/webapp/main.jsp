<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "tzs.Tzs" %>
<%@ page import = "tzs.TzsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>흔적 남기기 게시판</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 0;
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
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="TZS.jsp">게시판</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>흔적 남기기 프로젝트</h1>
				<p>사이버 망령 그룹에 흔적을 남겨봅시다.</p>
				<p><a class="btn btn-primary btn-pull" href="https://github.com/wold21" role="button">제작자 - GitHub</a></p>
			</div>
		</div>
	</div>
	<div class ="container">
		<table class = "table table-striped" style="text-align:center;" border: 1px solid #dddddd> <!--  table-striped -> 홀짝마다 색이 조금 다르게 보여짐-->
			<thead> <!-- 컬럼을 보여줌-->
				<tr>
					<th style="background-color: #eeeeee; text-align:center;">번호</th>
					<th style="background-color: #eeeeee; text-align:center;">제목</th>
					<th style="background-color: #eeeeee; text-align:center;">작성자</th>
					<th style="background-color: #eeeeee; text-align:center;">작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					TzsDAO tzsDAO = new TzsDAO();
					ArrayList<Tzs> list = tzsDAO.getList(pageNumber);
					for(int i=0; i <list.size(); i++){
				%>
				<tr>
					<td><%= list.get(i).getTzsID() %></td>
					<td><a href="view.jsp?tzsID=<%= list.get(i).getTzsID()%>"><%= list.get(i).getTzsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getTzsDate().substring(0, 11) + list.get(i).getTzsDate().substring(11, 13) + "시" + list.get(i).getTzsDate().substring(14, 16) + "분" %></td>
				</tr>
				<% 
					}
				%>
			</tbody>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="js/bootstrap.js"></script>
	
		
</body>
</html>









