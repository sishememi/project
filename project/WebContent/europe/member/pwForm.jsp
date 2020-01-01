<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	<title>비밀번호 찾기</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../../css/util.css">
	<link rel="stylesheet" type="text/css" href="../../css/main.css">  
</head>
<body>
<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90" style="">
				<form class="login100-form validate-form flex-sb flex-w" action="pw.me" method="post" name="f" style="text-align:center; vertical:">
					<span class="login100-form-title p-b-51" style="color:#50326b">
						비밀번호 찾기
					</span>

					<div class="wrap-input100 validate-input m-b-16" >
						<input class="input101" type="text" name="id" placeholder="id를 입력하세요.">
						<span class="focus-input101"></span>
					</div>
			
					
					<div class="wrap-input100 validate-input m-b-16" >
						<input class="input101" type="text" name="email" placeholder="이메일을 입력하세요.">
						<span class="focus-input101"></span>
					</div>

					<div class="container-login100-form-btn m-t-17">
					   <input type="submit" class="login100-form-btn" value="찾기" style="background:#D1B6E1">
					</div>
				</form>
			</div>
		</div>
	</div>

</html>