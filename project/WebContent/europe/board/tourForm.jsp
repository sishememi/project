<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Tour Info :)</title>
<link rel="stylesheet" href="../../css/list.css">
<script type="text/javascript">
	function listdo(page){
		document.sh.pageNum.value=page;
		document.sh.submit();
	} 
	function searchlist(wsection) {
		if(wsection=="��ü"){
			location.href='tourForm.do?bsection=1'
		}else {
			location.href='tourForm.do?bsection=${param.bsection}&wsection=' + wsection
		}
	}

</script>
<style>
.searchform1 {
  height: 26px;
  width: 40px;
  bottom:28px;
  left: 150px;
  color: #f8f107;
  background: #ffffff;
  cursor: pointer;
  position:relative;
}
.searchform1:hover{
	color:#fff;
	background: #f8f107;
}
</style>
</head>
<body>
<input type="hidden" name="bnum" value="${param.bnum}" >
<input type="hidden" name="subject" value="${param.subject}" >
<input type="hidden" name="bsection" value="${param.bsection}" >
<input type="hidden" name="wsection" value="${param.wsection}" >
<form action ="tourForm.do?bsection=1" method="post" name="sr">
<table class="board" >
<tr><td colspan="6"><h3>Tour</h3></td></tr>
   <c:if test="${boardcnt == 0}">
      <tr>
         <td colspan="5">��ϵ� �Խñ��� �����ϴ�.</td>
      </tr>
   </c:if>
      <c:if test="${boardcnt > 0}">
      <tr> 
      	 <td>���� ����</td>
      	 <td>
      	 <select name="column" class="nation" onchange="searchlist(this.value)">
			<c:set var="arr" value='<%=new String[]{"��ü","����","������","������","����Ʈ����","������","��Ż����","������","�� �ܱ���"} %>' />
			<c:forEach var="d" items="${arr}">				
		   		<option value="${d}" <c:if test="${param.wsection == d}">selected="selected"</c:if>>${d}</option>
		    </c:forEach></select>
      	 </td>
      </tr>
      <div class="table100-head">
      <tr class="h">
         <th width="8%">��ȣ</th>
         <th width="5%">&nbsp;</th>
         <th width="46%">����</th>
         <th width="15%">�ۼ���</th>
         <th width="20%">�ۼ���</th>
         <th width="11%">��ȸ</th>
      </tr>
      </div>

       <c:forEach var="b" items="${list}">
        <tr class="t"><td>${boardnum}</td> <!-- boardnum : �����ֱ� �� ��ȣ -->
        <c:set var="boardnum" value="${boardnum -1 }" />
      	<td style="size:10px;">${b.wsection}</td>
        <td><a href="info.do?bsection=1&bnum=${b.bnum}" class="sub">${b.subject}</a>
         </td><td>${b.id}</td>
         <td>
         <c:set var="today" value="<%=new java.util.Date() %>" />
         <fmt:formatDate value="${today}" pattern="yyyyMMdd" var="today"/>
          <fmt:formatDate value="${b.regdate}" pattern="yyyyMMdd" var="wrday"/>
          <c:choose>
         	<c:when test="${today-wrday < 1}">
         		<fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
         	</c:when>
         	<c:otherwise>
         		<fmt:formatDate value="${b.regdate}" pattern="yy-MM-dd HH:mm"/>
         	</c:otherwise>
  		  </c:choose>
          </td>
         <td>${b.readcnt}</td></tr>
     </c:forEach>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
	<tr class="page"><td colspan="6">
      <c:if test="${pageNum <= 1}">����</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:listdo(${pageNum - 1})">����</a> 
	  </c:if>
    <c:forEach var = "a" begin="${startpage}" end="${endpage}" >
    	<c:if test="${a==pageNum}">${a}</c:if>
    	<c:if test="${a!=pageNum}">
    	<a href="javascript:listdo(${a})">${a}</a> 
    	</c:if>
   	</c:forEach>
<c:if test="${pageNum >= maxpage}">����</c:if>
<c:if test="${pageNum < maxpage}">
	<a href="javascript:listdo(${pageNum + 1})">����</a> 
</c:if>
</td></tr>
</c:if>
      <tr>
         <td colspan="6" style="text-align: right"><a href="towrite.do?bsection=1" class="b">�۾���</a></td>
      </tr>
</table>
</form>
<form action ="tourForm.do?bsection=1" method="post" name="sh">
<input type="hidden" name="pageNum" value="1">
<table id="search">
<tr><td style="border-width:0px;">
<select name="column" class="column1">
	<option value="">�����ϼ���</option>
	<option value="subject">����</option>
	<option value="name">�ۼ���</option>
	<option value="content">����</option>
	<option value="subject,name">����,�ۼ���</option>
	<option value="subject,content">����,����</option>
	<option value="name,content">�ۼ���,����</option></select>
<script>document.sh.column.value="${param.column}";</script></td>
<td>
<input type="text" name="find" value="${param.find}" >
<input type="submit" class="searchform1" value="�˻�">
</td></tr> 
</table>
</form>

</body>
</html>