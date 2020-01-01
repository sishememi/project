<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>login page ;-)</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../../css/util.css">
	<link rel="stylesheet" type="text/css" href="../../css/main.css">  
	<script>
		function find(){
			var nw = open("findForm.jsp","id","width=500,height=500,menubar=no,top=200,left=200")
		}
	</script>
</head>  
<body>
<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90" style="">
				<form class="login100-form validate-form flex-sb flex-w" action="login.me" method="post" name="f" style="text-align:center;">
					<span class="login100-form-title p-b-51">
						Login
					</span>

					 
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input102" type="text" name="id" placeholder="UserId">
						<span class="focus-input102"></span>
					</div>
			
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
						<input class="input102" type="password" name="pass" placeholder="Password">
						<span class="focus-input102"></span>
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="ckb1">
								Remember me
							</label>
						</div>

						<div>
							<a href="joinForm.jsp" class="txt1" style="text-decoration:none">
								<h4>Join</h4>
							</a>    <br>
							<a href="#" class="txt1" onclick="javascript:find()" style="text-decoration:none">
								<h4>Forgot?</h4>
							</a>
						</div>
					</div>

					<div class="container-login100-form-btn m-t-17">
					   <button class="login100-form-btn" value="Login" style="background:#f9c00c">Login</button> 
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="dropDownSelect1"></div>
</body>
</html>