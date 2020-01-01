<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� �ۼ�</title>

<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<script type="text/javascript">
function inputcheck(){
	if(f.subject.value==""){
		alert("������ �Է��ϼ���");
		f.subject.focus();
		return;
	}
	if(f.wsection.value==""){
		alert("������ �����ϼ���");
		f.wsection.focus();
		return;
	}
	f.submit();
}
</script>
<style>
th{
	 margin: 3%;
}
table{
	width:100%;
	margin:5%;
	margin-right:auto; 
	margin-left:auto;
}

table tr{
	width:50px;
	text-align:center;
	vertical-align: middle;
	padding:2%;
	border:1px solid #77AAAD;
} 

table td{
	width:300px;
	margin: 3%;
}
form{
	margin-top:2%;
	margin-bottom:2%;

}
</style>
</head>
<body>
<form action="write.do" method="post" enctype="multipart/form-data" name="f">
<input type="hidden" value="${param.bsection}" name="bsection">
	<table>
	<tr><th>���� ����</th>
	 <td>
      	 <select name="wsection">
			<c:set var="arr" value='<%=new String[]{"����","������","������","����Ʈ����","������","��Ż����","������","�� �ܱ���"} %>' />
			<c:forEach var="d" items="${arr}">
				<option value="" selected disabled hidden >����</option>
		   		<option>${d}</option>
		    </c:forEach></select>
    </td> 
	<th>�ۼ���</th><td><input type="text" name="id" value="${login}" readonly></td></tr>
	<tr><th>����</th><td colspan="3"><input type="text" name="subject" style="width:100%"></td></tr>
	<tr><th>����</th><td colspan="3"><textarea rows="10" name="content" style="width:100%"></textarea></td></tr>
	<script>CKEDITOR.replace("content",{ 	filebrowserImageUploadUrl : "imgupload.do"});
	</script>
	<tr><th>÷������</th><td colspan="3"><input type="file" name="file1"></td></tr>
	<tr><td colspan="4" >&nbsp;</td></tr>
	<tr><td colspan="4"><a href="javascript:inputcheck()"> ���</a></td></tr>
</table>
</form>
</body>
</html>