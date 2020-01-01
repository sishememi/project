<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 삭제 :(</title>
<style>
	div{
		text-align: center;
	}
	table{
		text-align:center;
		margin-right:auto;
		margin-left:auto; 
		margin-bottom:3%;   
	}
	img{
		margin:5%
	}
</style>
</head>
<body>
<form action="delete.do?" name="f" method = "post">
<input type="hidden" name="id" value="${param.id}">
<input type="hidden" name="bnum" value="${param.bnum}">
<input type="hidden" name="bsection" value="${param.bsection}">
<div>
<img src="../../images/war.jpg" >
<table>
	<tr><th>이 버튼을 누르면 게시글은 한번에 삭제됩니다.!</th></tr>
	<tr><td colspan="2"><input type="submit" value="게시글 삭제"></td></tr>
</table>
</div>
</form>
</body>
</html>