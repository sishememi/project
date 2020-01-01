<%@page import="project.Board"%>
<%@page import="project.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 수정 :D</title>
<link rel="stylesheet" href="../../css/,">
<script type="text/javascript"
	src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<script>
	function file_delete() {
		document.f.file2.value = "";
		file_desc.style.display = "none"; //파일자체가 사라지진 않는다. 안보여지는것 뿐.
	}
</script>
<style>
.board{
	margin-top:10%;
	border:2px solid white;
	text-align:center;
}
</style>
</head>
<body>
<form action="update.do?bsection=${b.bsection}&bnum=${b.bnum}" method="post" enctype="multipart/form-data" name="f">
		<!--  multipart/form-data => useBean사용불가. -->
	<input type="hidden" name="file2" value="${b.file1}">
		<!-- 기존에 있는 내용을 없앤다. -->
		<table border="1" class="board">
			<tr>
				<th style="width: 20%;">${b.wsection}정보</th>
				<td>작성자 ${login}</td></tr>
				<tr><th>제목</th><td colspan="3"><input type="text" name="subject" style="width:100%" value="${b.subject}"></td></tr>
				<tr><th>내용</th><td colspan="3"><textarea rows="10" name="content" id="content1" style="width:100%">${b.content}</textarea></td>
				<script>CKEDITOR.replace("content",{ 	filebrowserImageUploadUrl : "imgupload.do"});
				</script>
				<tr>
				<th>첨부파일</th>
				<td style="text-align: left"><c:if test="${!empty b.file1}">
						<div id="file_desc">${b.file1}
							<a href="javascript:file_delete()">[첨부파일 삭제]</a>
						</div>
					</c:if> <input type="file" name="file1"></td>
				</tr>
				<tr>
					<td colspan="2"><a href="javascript:document.f.submit()">게시물 수정</a></td>
				</tr>
		</table>
	</form>
</body>
</html>