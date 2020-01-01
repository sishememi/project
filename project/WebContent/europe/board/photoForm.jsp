<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Photo Spot :)</title>
<link rel="stylesheet" href="../../css/photo.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href='https://fonts.googleapis.com/css?family=Lato:100,300,400,700,900' rel='stylesheet' type='text/css'>
<script type="text/javascript">
	function listdo(page){
		document.sh.pageNum.value=page;
		document.sh.submit();
	}   

</script>
</head>
<body>
<input type="hidden" name="bnum" value="${param.bnum}" >
<input type="hidden" name="img" value="${param.img}" >
<input type="hidden" name="bsection" value="${param.bsection}" >
<table>
<tr><td><h3>Photo</h3></td></tr>
<tr><td><h3>&nbsp;&nbsp;&nbsp;</h3></td></tr>
</table>
<table id="board">
   <c:if test="${boardcnt == 0}">
      <tr>
         <td colspan="5">등록된 게시글이 없습니다.</td>
      </tr>
   </c:if>
     <c:if test="${boardcnt > 0}">
   	 <c:forEach var="b" items="${list}">
	<ul>
		<li>
		<a href="phinfo.do?bsection=${b.bsection}&bnum=${b.bnum}"><img src="../board/picture/${b.img}" class="pic" style="width:250px; height:300px;"></a>
		<div class="hover-box"><p>${b.subject}</p></div>

		 <c:if test="${b.likechk==0}">
    	 <a href="photoForm2.do?id=${login}&bnum=${b.bnum}" title="좋아요  누름">
    	 	<span class="hex-icon-heart">
        <svg>
            <path d="M19,1 Q21,0,23,1 L39,10 Q41.5,11,42,14 L42,36 Q41.5,39,39,40 L23,49 Q21,50,19,49 L3,40 Q0.5,39,0,36 L0,14 Q0.5,11,3,10 L19,1" />
            <path d="M11,17 Q16,14,21,20 Q26,14,31,17 Q35,22,31,27 L21,36 L11,27 Q7,22,11,17" />
        </svg>
    </span></a> 	 
    	 </c:if>
    	 <c:if test="${b.likechk==1}">
    	 <a href="photoForm2.do?id=${login}&bnum=${b.bnum}" title="좋아요 취소">
    	 <span class="hex-icon-heart2">
        <svg>
            <path d="M19,1 Q21,0,23,1 L39,10 Q41.5,11,42,14 L42,36 Q41.5,39,39,40 L23,49 Q21,50,19,49 L3,40 Q0.5,39,0,36 L0,14 Q0.5,11,3,10 L19,1" />
            <path d="M11,17 Q16,14,21,20 Q26,14,31,17 Q35,22,31,27 L21,36 L11,27 Q7,22,11,17" />
        </svg>
    </span></a>
    	 </c:if>
    	 <c:if test="${b.stchk==0}">
    	 <a href="storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&img=${b.img}" title="저장">
    	 <span class="hex-icon-sun">
        <svg>
            <path d="M19,1 Q21,0,23,1 L39,10 Q41.5,11,42,14 L42,36 Q41.5,39,39,40 L23,49 Q21,50,19,49 L3,40 Q0.5,39,0,36 L0,14 Q0.5,11,3,10 L19,1" />
            <circle cx="21" cy="25" r="8" />
            <circle cx="21" cy="25" r="12">
                <animateTransform attributeName="transform" attributeType="XML" type="rotate" from="0 21 25" to="360 21 25" dur="3.5s" repeatCount="indefinite" />
            </circle>
        </svg>
    </span></a>
    	 </c:if>
    	 <c:if test="${b.stchk==1}">
  		 <a href="storage.do?bsection=${b.bsection}&id=${login}&bnum=${b.bnum}&img=${b.img}" title="저장 취소">
  		 <span class="hex-icon-sun2">
        <svg>
            <path d="M19,1 Q21,0,23,1 L39,10 Q41.5,11,42,14 L42,36 Q41.5,39,39,40 L23,49 Q21,50,19,49 L3,40 Q0.5,39,0,36 L0,14 Q0.5,11,3,10 L19,1" />
            <circle cx="21" cy="25" r="8" />
            <circle cx="21" cy="25" r="12">
                <animateTransform attributeName="transform" attributeType="XML" type="rotate" from="0 21 25" to="360 21 25" dur="3.5s" repeatCount="indefinite" />
            </circle>
        </svg>
    </span></a>
    	 </c:if>
			</li>
		</ul>
     </c:forEach>
	<tr><td colspan="6">
      <c:if test="${pageNum <= 1}">이전</c:if>
      <c:if test="${pageNum > 1 }">
      <a href="javascript:listdo(${pageNum - 1})">이전</a> 
	  </c:if>
    <c:forEach var = "a" begin="${startpage}" end="${endpage}" >
    	<c:if test="${a==pageNum}">${a}</c:if>
    	<c:if test="${a!=pageNum}">
    	<a href="javascript:listdo(${a})">${a}</a> 
    	</c:if>
   	</c:forEach>
<c:if test="${pageNum >= maxpage}">다음</c:if>
<c:if test="${pageNum < maxpage}">
	<a href="javascript:listdo(${pageNum + 1})">다음</a> 
</c:if>
</td></tr>
</c:if>
      <tr>
         <td colspan="6" style="text-align: right"><a href="phowrite.do?bsection=4">글쓰기</a></td>
      </tr>
</table>
<form action ="photoForm.do" method="post" name="sh">
<input type="hidden" name="pageNum" value="1">
<input type="hidden" name="bsection" value="${b.bsection}">
<table id="search"><tr><td style="border-width:0px;">
<select name="column">
	<option value="">선택하세요</option>
	<option value="subject">제목</option>
	<option value="name">작성자</option>
	<option value="content">내용</option>
	<option value="subject,name">제목,작성자</option>
	<option value="subject,content">제목,내용</option>
	<option value="name,content">작성자,내용</option></select>
<script>document.sh.column.value="${param.column}";</script>
<input type="text" name="find" value="${param.find}" style="width:50%">
<input type="submit" value="검색"></td>
</tr> 
</table>
</form>
</body>
</html>