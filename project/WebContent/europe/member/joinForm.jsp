<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>	
<!DOCTYPE html>
<html lang="en">
<head>
<title>login page ;-)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../../css/util.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<script type="text/javascript">
function inputcheck(){
	if(f.id.value==""){
		alert("아이디를 입력하세요");
		f.id.focus();
		return;
	}
	 if(f.pass.value==""){
			alert("비밀번호를 입력하세요.");
			f.pass.focus();
			return false;
		  }
	if(f.nickname.value==""){
			alert("닉네임을 입력하세요.");
			f.nickname.focus();
			return false;
		}
	if(f.email.value==""){
			alert("email를 입력하세요.");
			f.email.focus();
			return false;
		}
	if(f.year.val()==""){
			alert("출생년도를 선택하세요");
			return false;
		}
	if(f.month.value==""){
			alert("출생년도를 선택하세요");
			return false;
		}
	if(f.day.value==""){
			alert("출생년도를 선택하세요");
			return false;
		}
	if(f.gender.value==""){
			alert("성별을 선택하세요");
			return false;
		}
	if($("input[name='national']").is(":checked"){
			alert("선호하는 나라를 적어도 한개 체크해주세요")
			$("input[name='national']").eq(0).focus();
			return false;
		}
	f.submit();
}
</script>
</head>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90" style="">
				<form class="login100-form validate-form flex-sb flex-w" action="join.me" method="post" name="f">
					<span class="login100-form-title p-b-51"> Join Us! ;-D </span>
				  
 					<table style="table-layout:fixed; margin:auto; text-align:center;" >
					<tr><th width=30%>아이디</th>
					<td width=70%> 
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input100" type="text" name="id" id="id" placeholder="아이디를 입력하세요">
						<span class="focus-input100"></span>  
					</div></td></tr>
					    
					<tr>
					<th>비밀번호</th>
						<td>
						<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
						<input class="input100" type="password" name="pass" id="pass" placeholder="비밀번호를 입력하세요">
						<span class="focus-input100"></span>
					</div></td></tr>
					
					<tr>
						<th>닉네임</th>
						<td>
						<div class="wrap-input100 validate-input m-b-16" data-validate = "nickname is required">
						<input class="input100" type="text" name="nickname"  id="nickname" placeholder="닉네임을 입력하세요">
						<span class="focus-input100"></span>
					</div></td></tr>
					
					<tr>
						<th>email</th>
						<td>
						<div class="wrap-input100 validate-input m-b-16" data-validate = "email is required">
						<input class="input100" type="email" name="email" id="email" placeholder="이메일을 입력하세요">
						<span class="focus-input100"></span>
					</div></td></tr>
					
					<tr>
						<th>생년월일</th>
						<td>
						<div  class="wrap-input101 validate-input m-b-16" data-validate = "email is required" style="margin:auto;">
						<!-- <input class="input100" type="date" name="birth" > -->
						<select name="year" id="year">
						 <c:forEach var="y" begin="1930" end="2019">
							 <option> ${y}</option>
						  </c:forEach>
						  </select>
						  <select name="month" id="month">
						  <c:forEach var="m" begin="1" end="12">
							    <option> ${m}</option>
						  </c:forEach>
						  </select> 
						  <select name="day" id="day">
						   <c:forEach var="d" begin="1" end="31">
						   		<option> ${d}</option>
						  </c:forEach></select><br>
						<span class="focus-input100"></span>
					</div></td></tr>
					<tr> 
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<th>성별</th>
						<td class="wrap-input101 validate-input m-b-16"><input type="radio" name="gender" id="gender" value="1" checked>남&nbsp;
							<input type="radio" name="gender" id="gender" value="2">여</td>
					</tr>
					<tr>
						<th colspan="2" style="font-size:26px; color:#403866">여행지 선택</th>
					</tr>
					<tr>
						<td colspan="2" style="font-size:13px; color:#FF0066">※☆예정된 여행이있으면
						  '출발 예정일'과 '여행지'를<br> 체크해주세요.☆※<br>※★여행계획이 없는경우 선호하는 여행지만 체크해주세요!★※
						</td>
					</tr>
					
					<tr class="wrap-input101 validate-input m-b-16">
						<td colspan="2">여행 출발 예정일(월):&nbsp;
						<select name="travel">
						   <c:forEach var="start" begin="0" end="12">
							 <option value="${start}"> ${start}</option>
						  </c:forEach></select><br>
					</td>
					</tr>    
					<tr class="wrap-input101 validate-input m-b-16">
					<td colspan="2" height=100% id="chkTd">
					<input type="checkbox" name="national"  value="영국" >영국
					<input type="checkbox" name="national"  value="프랑스">프랑스
					<input type="checkbox" name="national"  value="스위스">스위스
					<input type="checkbox" name="national"  value="오스트리아">오스트리아<br>
					<input type="checkbox" name="national"  value="스페인">스페인
					<input type="checkbox" name="national"  value="이탈리아">이탈리아
					<input type="checkbox" name="national"  value="동유럽">동유럽
					<input type="checkbox" name="national"  value="그 외">그 외
					</td>
					</tr> 
					<tr>
					<td colspan="2"> 
					 <div class="container-login100-form-btn m-t-17">
					 <input type="submit" id="btn" class="login100-form-btn" value="Login" onclick="javascript:inputcheck()">
					 </div></td></tr>
				</table> 
				</form>
			</div>
		</div>
	</div>
</body>
</html>