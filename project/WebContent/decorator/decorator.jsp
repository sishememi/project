<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title><decorator:title /></title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../../css/bootstrap.min.css">
<!-- FontAwesome CSS -->
<link rel="stylesheet" href="../../css/font-awesome.min.css">
<!-- Swiper CSS -->
<link rel="stylesheet" href="../../css/swiper.min.css">
<!-- Styles -->
<link rel="stylesheet" href="../../style.css">
<style>
.btn {
	text-align: center;
	cursor: pointer;
	transition: all 1.0s, color 0.5;
}

.hover1:hover {
	box-shadow: 200px 0 0 0 #ffffb7 inset;
}

.hover2:hover {
	box-shadow: -200px 0 0 0 #ffb7db inset;
}

.hover3:hover {
	box-shadow: 200px 0 200px 0 #cbf5c0 inset;
}

.hover4:hover {
	box-shadow: 0 0 0 200px #bfdbf7 inset;
}
</style>
</head>
<decorator:head />
<body>
	<div class="outer-container">
		<header class="site-header">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="site-branding flex flex-column align-items-center">
							<h1 class="site-title" style="text-align: center">
								<a href="../member/mainForm.me" rel="home">How about Europe?</a>
							</h1>
						</div>
						<!-- .site-branding -->

						<nav class="site-navigation">
							<div class="hamburger-menu d-lg-none">
								<span></span> <span></span> <span></span> <span></span>
							</div>
							<!-- .hamburger-menu -->
							<div class="buttons">
								<ul
									class="flex-lg flex-lg-row justify-content-lg-center align-content-lg-center">
									<li class="current-menu-item"><a
										href="../member/mainForm.me">Home</a></li>
									<li class="btn hover1"><a
										href="../board/tourForm.do?bsection=1">Tour Info</a></li>
									<li class="btn hover2"><a
										href="../board/restaurantForm.do?bsection=2">Restaurant
											Info</a></li>
									<li class="btn hover3"><a
										href="../board/etcForm.do?bsection=3">Etc Info</a></li>
									<li class="btn hover4"><a
										href="../board/photoForm.do?bsection=4&id=${login}">Photo
											Spot</a></li>
									<c:if test="${!sessionScope.login}">
										<li><a href="../member/mypageForm.me?id=${login}"><c:if
													test="${!empty sessionScope.login}">${sessionScope.login}님의 마이페이지</c:if></a></li>
										<c:if test="${login != 'admin' }">
											<li><a href="../board/storageForm.do?id=${login}">Storage
													box</a></li>
										</c:if>
										<li><a href="../member/logout.me"><c:if
													test="${!empty sessionScope.login}"></c:if>로그아웃</a></li>
									</c:if>
								</ul>
							</div>
						</nav>
						<!-- .site-navigation -->
					</div>
					<!-- .col -->
				</div>
				<!-- .row -->
			</div>
			<!-- .container -->
		</header>
		<!-- .site-header -->
		<div>
			<decorator:body />
		</div>
	</div>
	<!-- .outer-container -->
	<footer class="sit-footer">
		<div class="footer-bar">
			<div class="outer-container">
				<div class="container-fluid">
					<div class="row justify-content-between">
						<div class="col-12 col-md-6">
							<div class="footer-copyright">
								<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
								<p>
									Copyright &copy;
									<script>
										document
												.write(new Date().getFullYear());
									</script>
									All rights reserved | This page is made <i
										class="fa fa-heart-o" aria-hidden="true"></i> by <a
										href="https://colorlib.com" target="_blank">Simi</a>
								</p>
								<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							</div>
							<!-- .footer-copyright -->
						</div>
						<!-- .col-xl-4 -->

					</div>
					<!-- .row -->
				</div>
				<!-- .container-fluid -->
			</div>
			<!-- .outer-container -->
		</div>
		<!-- .footer-bar -->
	</footer>
	<!-- .sit-footer -->

	<script type='text/javascript' src='../../js/jquery.js'></script>
	<script type='text/javascript' src='../../js/swiper.min.js'></script>
	<script type='text/javascript' src='../../js/custom.js'></script>

</body>
</html>