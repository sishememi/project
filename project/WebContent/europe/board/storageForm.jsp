<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Storage :)</title>
<style>
.st{
	margin-top:3%;
	margin-bottom:3%;
}
table{
	text-align: center;
	margin-top: 2%;
	margin-bottom: 2%;
	padding: 2%;
}
.h{
	margin-top:7%;
 	margin-left: auto;
	margin-right: auto;
	text-align: center;
}
img{
	width:40px;
	height: 45px;
}

.t1{
	float: left;
	margin:2%;
}
.t2{
	float:left;
	margin:2%;
}
.t3{
	float:left;
	margin:2%;
}
.t4{

	margin:3%;
}
.t{
	color:#ffda8e;
	font-weight: 700;
}
.r{
	color:#fab1ce;
	font-weight: 700;
}
.e{
	color:#a8dba8;
	font-weight: 700;
}
.p{
	color:#A593E0;
	font-weight: 700;
}
.a{
  text-decoration: none;
  color:#566270;
}
</style>
</head>
<body>
<input type="hidden" name="subject" value="${param.subject}">
<input type="hidden" name="img" value="${param.img}">
<input type="hidden" name="bnum" value="${param.bnum}">
<input type="hidden" name="bsection" value="${param.bsection}">
<div class="st">
	<div class="h">
		<H3>STORAGE HOME</H3>
	</div>		
	<div class="t1">
		<table>
		<tr><td colspan="4"><h2 class="t">Tour</h2></td></tr>
		<tr><th>번호</th><th>제목</th><th>작성자</th></tr>
		<c:forEach var="b" items="${tlist}">
			<tr>
			<td>
				<div class="card h-100">
					<div class="card-body">
						${b.bnum}
					</div>
				</div>
			</td>
			<td>
				<div class="card h-100">
					<div class="card-body">
						<a href="info.do?bsection=${b.bsection}&bnum=${b.bnum}" title="게시물 보기" class="a">${b.subject}</a>
					</div>
				</div>
			</td>
			<td>
				<div class="card h-100">
					<div class="card-body">
						${b.id}
					</div>
				</div>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<div class="t2">
	<table >
		<tr><td colspan="4"><h2 class="r">Restaurant</h2></td></tr>
		<tr><th>번호</th><th>제목</th><th>작성자</th></tr>
		<c:forEach var="b" items="${rlist}">
			<tr>
			<td>
				<div class="card h-100">
					<div class="card-body">
						${b.bnum}
					</div>
				</div>
			</td>
			<td>
				<div class="card h-100">
					<div class="card-body">
						<a href="info.do?bsection=${b.bsection}&bnum=${b.bnum}" title="게시물 보기" class="a">${b.subject}</a>
					</div>
				</div>
			</td>
			<td>
				<div class="card h-100">
					<div class="card-body">
						${b.id}
					</div>
				</div>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<div class="t3">
	<table>
		<tr><td colspan="4"><h2 class="e">Etc</h2></td></tr>
		<tr><th>번호</th><th>제목</th><th>작성자</th></tr>
		<c:forEach var="b" items="${elist}">
			<tr>
			<td>
				<div class="card h-100">
					<div class="card-body">
						${b.bnum}
					</div>
				</div>
			</td>
			<td>
				<div class="card h-100">
					<div class="card-body">
						<a href="info.do?bsection=${b.bsection}&bnum=${b.bnum}" title="게시물 보기" class="a">${b.subject}</a>
					</div>
				</div>
			</td>
			<td>
				<div class="card h-100">
					<div class="card-body">
						${b.id}
					</div>
				</div>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<div class="t4">
	<table>
		<tr><td colspan="2"><h2 class="p">Photo</h2></td></tr>
		<c:forEach var="b" items="${plist}">
			<tr>
			<td colspan="2">
				<div class="card h-100">
					<div class="card-body">
						<a href="phinfo.do?bsection=4&bnum=${b.bnum}" title="게시물 보기" class="a"><img src="../board/picture/${b.img}"></a>
						<div><br>작성자:&nbsp;${b.id}</div>
					</div>
				</div>
			</td>
			</tr>
			<tr>
			</tr>
		</c:forEach>
	</table>	
	</div> 
</div>
</body>
</html>