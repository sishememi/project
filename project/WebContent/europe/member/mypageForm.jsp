<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="euc-kr">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>MyPage :-)</title>
<style>
table{
	margin-top:5%;
	margin-bottom:5%;
	margin-left:auto; margin-right:auto;
	width:45%;
	height: 60%;
}
tr{
	width:40%;
	padding:3%;
}
th{
	border: 6px solid white;
	color:#60c5ba;
	border-radius:25px;
}
td{
	width:60%;
	padding:3%;
}
.td{
	background-color:#feee7d;
	border-radius:25px;
	border:6px solid white;
}
h1{
	margin-top:2%;
	text-align: center;
	color:#ef5285;
	font-weight: 700;
}
.out{
	margin-top:5%;
	margin-bottom:5%;
	border:1px dotted gray;
}
h3{
	text-align: right;
}
.mem:link{
 text-decoration: none;
 color:black;	
}
.mem:visited {
	color:#a5dff9;
}
.mem:hover {
	color:white;
	background-color: #a5dff9;
}
</style>
</head>
<body>
<div class="out">
		<h1>My Info</h1>
		<table style="text-align: center">

			<tr>
				<th>아이디</th>
				<td class="td">${info.id}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td class="td">${info.nickname}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td class="td">${info.gender==1?"남":"여"}</td>
			</tr>
			<tr>
				<th>email</th>
				<td class="td">${info.email}</td>
				</tr>
				<tr>
				<th>생년월일</th>
				<td class="td">${info.birth}</td>
			</tr>
			<tr>
			<th>준비중인 여행 예정일(월)</th>
			<td class="td">${info.travel}월</td>
			</tr>
			<tr>
			<th>선호(예정) 유럽여행지</th>
			<td class="td">${info.national}</td>
			</tr>
			<tr>
			<c:if test="${info.id !='admin' && sessionScope.login != 'admin'}">
 			<td colspan="2" style="text-align: center">
 			<a href="updateForm.me?id=${info.id}">[수정]</a>
			<a href="deleteForm.me?id=${info.id}">[탈퇴]</a></td>
			</c:if>
			</tr>
			
			<tr>
			<td colspan="2" style="text-align: center">
			<c:if test="${sessionScope.login == 'admin' }">
			<h3><a href="memlist.me" class="mem">회원 목록보기</a></h3>
			</c:if>
			</td>
			</tr>
			<c:if test="${sessionScope.login != 'admin' }">
			<tr><td colspan="2"><a href="storageForm.do?id=${login}">보관함</a></td></tr>
			</c:if>
	</table>
</div>
</body>
</html>
