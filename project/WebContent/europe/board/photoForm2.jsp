<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Photo Spot :)</title>
<link rel="stylesheet" href="../../css/list.css">
<script type="text/javascript">
	function listdo(page){
		document.sh.pageNum.value=page;
		document.sh.submit();
	}   

</script>
<style>
 li{
 	list-style: none;
 }
 table{
 	text-align:center;
 	margin:10%;
 }
  table td{
 	margin:10%;
 }
 img{
 	width:35px;
 	height:35px;
}
</style>

</head>
<body>
<form name="f">
<table id="board">
   <c:if test="${boardcnt == 0}">
      <tr>
         <td colspan="5">등록된 게시글이 없습니다.</td>
      </tr>
   </c:if>
      <c:if test="${boardcnt > 0}">
  	 <c:forEach var="b" items="${list}">
  	     <tr><td><a href="phinfo.do?bsection=${b.bsection}&bnum=${b.bnum}"><img src="../board/picture/${b.img}" style="width:400px; height:350px;"></a></tr>
    	 <tr><td><a href="photoForm.do?id=${login}&bnum=${b.bnum}"><img src="../../images/heart.png" style="align:left"></a></td>
    		 <td><a href="storage.do?id=${login}&bnum=${b.bnum}"><img src="../../images/st.png" style="align:left"></a></td></tr>
     </c:forEach>
</c:if>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
	<tr><td colspan="6">
      <c:if test="${pageNum <= 1}">[이전]</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:listdo(${pageNum - 1})">[이전]</a> 
	  </c:if>
    <c:forEach var = "a" begin="${startpage}" end="${endpage}" >
    	<c:if test="${a==pageNum}">[${a}]</c:if>
    	<c:if test="${a!=pageNum}">
    	<a href="javascript:listdo(${a})">[${a}]</a> 
    	</c:if>
   	</c:forEach>
<c:if test="${pageNum >= maxpage}">[다음]</c:if>
<c:if test="${pageNum < maxpage}">
	<a href="javascript:listdo(${pageNum + 1})">[다음]</a> 
</c:if>
</td></tr>
      <tr>
         <td colspan="6" style="text-align: right"><a href="phowrite.do?bsection=4">[글쓰기]</a></td>
      </tr>
</table>
</form>
</body>
</html>