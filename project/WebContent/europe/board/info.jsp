<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խñ� ${b.subject} �� ����</title>
<link rel="stylesheet" href="../../css/info.css"> 
<style>
.hd{
	font-size:1.3em;
	font-weight: 300;
	color:#492540;
}
</style>
</head>
<body>
<input type="hidden" name="bsection" value="${param.bsection}">
<input type="hidden" name="bnum" value="${param.bnum}">
<input type="hidden" name="id" value="${param.id}">
<input type="hidden" name="wsection" value="${param.wsection}">
<input type="hidden" name="subject" value="${param.subject}">
<input type="hidden" name="img" value="${param.img}">
<input type="hidden" name="comment" value="${param.comment}">
<div class="out">
<table class="board" boarder="1">
		<tr class="hd">
			<th style="width: 30%;">${b.wsection} ����</th>
			<td style="text-align: center; width: 40%;">${b.subject}</td>
			<td style="text-align: center; width:30%">�ۼ��� ${b.id}</td>
		</tr>
		<tr class="con">
			<th>����</th>
			<td colspan="2">
				${b.content}
			</td>
		</tr>
		<tr>
		<td colspan="3" class="st">
		<c:if test="${b.stchk==0}">
    	<a href="<c:if test="${b.bsection==1}">storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&subject=${b.subject}</c:if>
			 <c:if test="${b.bsection==2}">storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&subject=${b.subject}</c:if>
		     <c:if test="${b.bsection==3}">storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&subject=${b.subject}</c:if>"><div class="i"><img src="../../images/0box.png"title="������ ����"></div></a>
 		</c:if>
		 <c:if test="${b.stchk==1}">
  		<a href="<c:if test="${b.bsection==1}">storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&subject=${b.subject}</c:if>
			 <c:if test="${b.bsection==2}">storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&subject=${b.subject}</c:if>
			 <c:if test="${b.bsection==3}">storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&subject=${b.subject}</c:if>"><div class="i"><img src="../../images/1box.png" title="������ ���"></div></a>
 		</c:if>
		</td></tr>
		<tr class="file">
			<th>÷������</th>
			<td colspan="2">&nbsp; <c:if test="${!empty b.file1}">
  							<a href="file/${b.file1}">${b.file1}</a>
				</c:if>
		</td></tr>
		<tr>
		<td colspan="3">
			<c:if test="${login eq b.id }">
			<p class="p"><a href="<c:if test="${b.bsection==1}">updateForm.do?&bsection=1&bnum=${b.bnum}</c:if>
						 <c:if test="${b.bsection==2}">updateForm.do?bsection=2&bnum=${b.bnum}</c:if>
						 <c:if test="${b.bsection==3}">updateForm.do?bsection=3&bnum=${b.bnum}</c:if>
						 <c:if test="${b.bsection==4}">updateForm.do?bsection=4&bnum=${b.bnum}</c:if>">����</a> 
			</p>
			</c:if>
			<c:if test="${login eq b.id || login eq 'admin'}">
			<p class="p">
			<a href="<c:if test="${b.bsection==1}">deleteForm.do?&bsection=1&bnum=${b.bnum}</c:if>
						 <c:if test="${b.bsection==2}">deleteForm.do?bsection=2&bnum=${b.bnum}</c:if>
						 <c:if test="${b.bsection==3}">deleteForm.do?bsection=3&bnum=${b.bnum}</c:if>
						 <c:if test="${b.bsection==4}">deleteForm.do?bsection=4&bnum=${b.bnum}</c:if>">����</a> 
			</p>
			</c:if>
	</table>
	</div>
	<table class="reply">
	<tr><th>���</th><td colspan="3"><a href="replyForm.do?bsection=${b.bsection}&bnum=${b.bnum}&id=${login}"><img src="../../images/reply.png">��� �ۼ�</a></td></tr>
			<c:forEach var="b" items="${list}">
			<c:if test="${!empty b.comment}">
			<tr class="rep"><td>${b.id}:</td>	
			<td>${b.comment}</td>	
			<td>
			<c:if test="${login eq b.id || b.id eq 'admin'}">
			<a href="deleteForm.do?bsection=${b.bsection}&bnum=${b.bnum}"><img src="../../images/del.png" title="��� ����" class="del"></a>
			</c:if>
		    </td></tr>
			</c:if>
			<c:if test="${empty b.comment}">
				<tr><td>��ϵ� ����� �����ϴ�.</td></tr>
			</c:if>
			</c:forEach>
			<tr>
	</table>
	<table class="list">
	<tr><td>
		<a href="<c:if test="${b.bsection==1}">tourForm.do?bsection=1</c:if>
				 <c:if test="${b.bsection==2}">restaurantForm.do?bsection=2</c:if>
				 <c:if test="${b.bsection==3}">etcForm.do?bsection=3</c:if>
				 <c:if test="${b.bsection==4}">photoForm.do?bsection=4</c:if>">���</a>
	</td></tr>		
	</table>
</body>
</html>