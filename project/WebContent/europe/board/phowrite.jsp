<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>photo �Խù� ���</title>
<link rel="stylesheet" href="../../css/write.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<style>
table th{
	width:30%;
}
table td{
	width:70%;
}
</style>
<script type="text/javascript">
	function win_upload(){
		var op = "width=500, height=150, left=50,top=150"
		open("pictureForm.jsp","",op)
	}
	
	function inputcheck(){
		if(f.subject.value==""){
			alert("������ �Է��ϼ���");
			f.subject.focus();
			return;
		}
		f.submit();
	}
</script>
</head>
<body>
<form action="write.do" name="f" method="post" enctype="multipart/form-data">
<input type="hidden" name="img" value="" >
<input type="hidden" value="${param.bsection}" name="bsection">
<input type="hidden" value="${param.bnum}" name="bnum">
   <table>
   	  <tr>
   	  <td rowspan="5" valign="middle" style="width:30%">
      <img src="" width="100" height="120" id="pic" name="img"><br>
      <font size="2"><a href="javascript:win_upload()">�������</a></font></td>
      <th>�ۼ���</th><td><input type="text" name="id" value="${login}" readonly></td></tr>
      <tr><th>������ ����� ���� �Է�</th><td colspan="3"><input type="text" name="wsection" style="width:100%"></td></tr>
      <tr><th>����</th><td colspan="3"><input type="text" name="subject" style="width:100%"></td></tr>
      <tr><th colspan="3">����</th></tr>
	  <tr><td colspan="4"><textarea rows="10" name="content" id="content1" style="width:100%"></textarea></td></tr>
	  <script>CKEDITOR.replace("content",{ 	filebrowserImageUploadUrl : "imgupload.do"});
	  </script>
	  <tr><th>÷������</th><td colspan="3"><input type="file" name="file1"></td></tr>
	  <tr><td colspan="4" >&nbsp;</td></tr>
	  <tr><td colspan="4"><a href="javascript:inputcheck()"> ���</a></td></tr>
   </table>
</form>
</body>
</html>