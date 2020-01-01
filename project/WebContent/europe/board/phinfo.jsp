<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 ${b.subject} 상세 보기</title>
<style>
table{
	margin:5%;	
	text-align: center;	
	width:80%;
}
.r{
	width:30px;
	height:30px;
}
</style>
</head>
<body>
<input type="hidden" name="img" value="${param.img}" >
	<table style="margin-left: auto; margin-right: auto;">
		<tr><th><h4>제목&nbsp;&nbsp;${b.subject}</h4></th><td>작성자&nbsp;&nbsp;${login}</td></tr>
		<tr><td colspan="2">${b.wsection} Photo Spot</td></tr>
		<tr><td colspan="2"><img src="../board/picture/${b.img}" style="width:400; height:350;"></td></tr>
		<tr><td colspan="2">${b.content}</td></tr>
		<tr><td colspan="2"></td></tr>
		<tr><th colspan="3"><h3>댓글</h3></th></tr>
		<tr><td colspan="3" style="text-align:right">
		<a href="replyForm.do?bsection=${b.bsection}&bnum=${b.bnum}&id=${login}"><img src="../../images/reply.png" class="r">댓글 작성</a>
		</td></tr>
		<c:forEach var="b" items="${list}">
			<c:if test="${!empty b.comment}">
				<tr><td>${b.id}&nbsp;:&nbsp;&nbsp;${b.comment}&nbsp;&nbsp; <c:if test="${login eq b.id }">
					<a href="#"><img src="../../images/del.png">삭제</a>
					</c:if></td></tr>
			</c:if>
			<c:if test="${empty b.comment || b.id eq 'admin' }">
				<tr><td>등록된 댓글이 없습니다.</td></tr>
			</c:if>
			</c:forEach>
			<tr>
			<td colspan="2" style="text-align: right;">
			<c:if test="${login eq b.id }">
			<a href="<c:if test="${b.bsection==4}">updateForm.do?bsection=4&bnum=${b.bnum}</c:if>">수정</a> 
			</c:if>
			<c:if test="${login eq b.id || login eq 'admin'}">
			<a href="<c:if test="${b.bsection==4}">deleteForm.do?bsection=4&bnum=${b.bnum}</c:if>">삭제</a> 
			</c:if>
			</td>	
		</tr> 
		<tr>
			<td colspan="2" style="text-align:right;">
				<a href="<c:if test="${b.bsection==1}">tourForm.do?bsection=1</c:if>
						 <c:if test="${b.bsection==2}">restaurantForm.do?bsection=2</c:if>
						 <c:if test="${b.bsection==3}">etcForm.do?bsection=3</c:if>
						 <c:if test="${b.bsection==4}">photoForm.do?bsection=4</c:if>" style="text-align:right">목록</a>
			</td>
		</tr>
	</table>
</body>
</html>