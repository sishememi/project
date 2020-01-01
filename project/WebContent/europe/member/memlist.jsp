<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 목록</title>
<style>
table{
	margin-top:7%;
	margin-bottom:3%;
	width:80%;
	margin-right: auto;
	margin-left: auto;
	text-align: center;
}
td{
	padding:2%;
	margin-right: 2%;
	border-radius: 20px;
	border:2px solid white;
}
th{
	padding:1%;
	border-radius: 20px;
	border:2px solid white;
}
h2{
	text-align: center;
}
.h{
	background-color: #004e66;
	color:#e1eef6;
}
.hh{
	background-color: #ff5f2e;
	color:#e1eef6;
}
.hhh{
	background-color: #fcbe32;
	color:#e1eef6;
}
</style>
</head>
<body>
<table border="1">
<tr class="h"><th colspan="5"><h2>회원 목록 관리</h2></th></tr>
<tr class="hh"><th>아이디</th><th>이름</th><th>성별</th><th>이메일</th><th>회원 삭제</th></tr>
<c:forEach var="b" items="${list}"><!-- 리스트 하나하나가 객체. -->
       <tr class="hhh"><td><a href="mypageForm.me?id=${b.id}">${b.id}</a></td> <!-- href="info.jsp?id=m.getId() info.jsp로 가서 id구분-->
       <td>${b.id}</td>
       <td>${b.gender==1?"남":"여" }</td>
       <td>${b.email}</td>
       <td>
		<c:if test="${b.id != 'admin'}">
		<a href="delete.me?id=${b.id}">강제탈퇴</a>
  		</c:if> 
  		</td></tr>
</c:forEach>
</table>
</body>
</html>
