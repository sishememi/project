<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խñ� ���� :(</title>
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
	<tr><th>�� ��ư�� ������ �Խñ��� �ѹ��� �����˴ϴ�.!</th></tr>
	<tr><td colspan="2"><input type="submit" value="�Խñ� ����"></td></tr>
</table>
</div>
</form>
</body>
</html>