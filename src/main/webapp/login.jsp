<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>흔적 남기기 게시판</title>
</head>
<body>
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
				<li><a href="TZS.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">접속하기<span class="caret"></span></a> <!-- caret 아이콘같은 것. -->
						<ul class="dropdown-menu">
							<li class="active"><a href="login.jsp">로그인</a></li> <!-- active는 한개만 존재할 수 있다. -->
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
				</li>
			</ul>
		</div>
		
	</nav>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="js/bootstrap.js"></script>
  
</body>
</html>