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
 
<script type="text/javascript">
   function pwclose() {
	   self.close();
   }
</script>
</head>
<body>
<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90" style="">
				<form class="login100-form validate-form flex-sb flex-w" action="id.me" method="post" name="f" style="text-align:center; vertical:">
					<span class="login100-form-title p-b-51">
						귀하의 PASSWORD는  **${pass} 입니다.
					</span>
					<div class="wrap-input100 validate-input m-b-16" >
						**${pass}
						<span class="focus-input100"></span>
					</div>
					 <input class="login101-form-btn" type="button" value="닫기" onclick="pwclose()" >
				</form>
			</div>
		</div>
	</div>
</body>
</body>
</html>