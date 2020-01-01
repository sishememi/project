<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>ID/PASS 찾기</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../../css/util.css">
	<link rel="stylesheet" type="text/css" href="../../css/main.css">  
	<style type="text/css">
		.f{
			vertical-align:middle;
		}
	</style>
</head>  
<body>
<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90" style="">
				<form class="login100-form validate-form flex-sb flex-w" action="login.me" method="post" name="f">		
						<div class="f">
							<a href="idForm.jsp" class="login100-form-btn">
						 	  	ID 찾기
							</a>    
						</div>
						<div class="f">
							<a href="pwForm.jsp" class="login100-form-btn" style="background:#D1B6E1" >
					   			PASSWORD 찾기
							</a>
						</div>
				</form>
			</div>
		</div>
</div>
</body>
</html>