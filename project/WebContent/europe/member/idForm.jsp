<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	<title>아이디 찾기</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../../css/util.css">
	<link rel="stylesheet" type="text/css" href="../../css/main.css"> 
</head>
<body>
<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90" style="">
				<form class="login100-form validate-form flex-sb flex-w" action="id.me" method="post" name="f" style="text-align:center; vertical:">
					<span class="login100-form-title p-b-51">
						아이디 찾기
					</span>

					<div class="wrap-input100 validate-input m-b-16" >
						<input class="input100" type="text" name="email" placeholder="이메일을 입력하세요.">
						<span class="focus-input100"></span>
					</div>
			
					
					<div class="wrap-input100 validate-input m-b-16" >
						<input class="input100" type="text" name="birth" placeholder="생년월일을 입력하세요. 예)1996-04-08">
						<span class="focus-input100"></span>
					</div>

					<div class="container-login100-form-btn m-t-17">
					   <input type="submit" class="login100-form-btn" value="찾기">
					</div>
					<br>
				</form>
			</div>
		</div>
	</div>

</html>