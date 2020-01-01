<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html> 
<html lang="en">
<head>
<title>메인:)</title>
<link rel="stylesheet" type="text/css" href="../../style.css"> 
<script type="text/javascript" src="https://www.chartjs.org/dist/2.9.3/Chart.min.js"> </script>
<style>
 .b{
 	margin-right:auto;
 	margin-left:auto;
 }
.single-page .content-wrap .featured-image img {
    padding-right: 10px;
}
.photo{
	width:70%;
	height: 60%;
}
.posted-photo{
	margin-top: 2%;
}
</style>
<script type="text/javascript" src="https://www.chartjs.org/dist/2.9.3/Chart.min.js"></script>
</head>
<sql:setDataSource var="conn1" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/projectdb" user="scott" password="1234"/>
<sql:query var="rs1" dataSource="${conn1}">
SELECT '2' gender, '영국' national,COUNT(*) mem  from member where national like '%영국%'and gender = 2
union all 
SELECT '2','프랑스',count(*) from member where national like '%프랑스%'and gender = 2
union all 
SELECT '2', '스위스',count(*) from member where national like '%스위스%' and gender = 2
union all 
SELECT '2', '오스트리아',count(*) from member where national like '%오스트리아%' and gender = 2
union all 
select '2','스페인',count(*) from member where national LIKE '%스페인%' and gender = 2
union all 
select '2','이탈리아',count(*) from member where national like '%이탈리아%' and gender = 2
union all 
select '2','동유럽',count(*) from member where national like '%동유럽%' and gender = 2
union all 
SELECT '2','그 외',count(*) from member where national like '%그외%' and gender = 2
</sql:query>
<sql:setDataSource var="conn2" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://localhost:3306/projectdb" user="scott" password="1234"/>
<sql:query var="rs2" dataSource="${conn2}">
SELECT '1' gender, '영국' national,COUNT(*) mem  from member where national like '%영국%'and gender = 1
union all 
SELECT '1','프랑스',count(*) from member where national like '%프랑스%'and gender = 1
union all 
SELECT '1', '스위스',count(*) from member where national like '%스위스%' and gender = 1
union all 
SELECT '1', '오스트리아',count(*) from member where national like '%오스트리아%' and gender = 1
union all 
select '1','스페인',count(*) from member where national LIKE '%스페인%' and gender = 1
union all 
select '1','이탈리아',count(*) from member where national like '%이탈리아%' and gender = 1
union all 
select '1','동유럽',count(*) from member where national like '%동유럽%' and gender = 1
union all 
SELECT '1','그 외',count(*) from member where national like '%그외%' and gender = 1
</sql:query>
<body>
<div class="outer-container">
<header class="site-header">
	<div class="container">
		<div class="row">
			<div class="col-12">
				 <nav class="site-navigation">
					<div class="hamburger-menu d-lg-none">
						<span></span> 
						<span></span>
						<span></span> 
						<span></span>
					</div>
			<div class="header-bar-search d-md-none">
				<form>
				<input type="search" placeholder="Search">
				</form>
			</div> 
		</nav> 
	</div>
</div>
</div>
</header>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="swiper-container hero-slider">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="hero-content flex justify-content-center align-items-center flex-column">
							<img src="../../images/eiffeltower.jpg" alt="">
						</div>
					</div>
				<div class="swiper-slide">
				<div class="hero-content flex justify-content-center align-items-center flex-column">
					<img src="../../images/florence.jpg" alt="">
				</div>
			</div>
			<div class="swiper-slide">
				<div class="hero-content flex justify-content-center align-items-center flex-column">
					<img src="../../images/london.jpg" alt="">
				</div>
			</div>
		</div>
		<div class="swiper-pagination"></div>
			<div class="swiper-button-next flex justify-content-center align-items-center">
				<span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 27 44">
				<path d="M27,22L27,22L5,44l-2.1-2.1L22.8,22L2.9,2.1L5,0L27,22L27,22z"></path></svg></span>
			</div>
		<div class="swiper-button-prev flex justify-content-center align-items-center">
			<span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 27 44">
			<path d="M0,22L22,0l2.1,2.1L4.2,22l19.9,19.9L22,44L0,22L0,22L0,22z"></path></svg></span>
		</div>
	</div>
</div>
</div>
	<div class="col-12 col-lg-3" style="float:right">
		<div class="sidebar">
		<div class="posted-photo"><h4>Travel Preferred nation</h4> </div>
			<div class="posted-photo"><h6>Preference(W)</h6></div>
			<div id="container" style="width: 75%; height:80%">
			<canvas id="canvas1" width="200" height="250"></canvas>
			</div>
		</div>
 		<div class="sidebar">
 			<div class="posted-photo"><h6>Preference(M)</h6></div>
			<div id="container" style="width: 75%; height:80%">
			<canvas id="canvas2" width="200" height="250"></canvas>
			</div>
			<script type="text/javascript">
				var randomColorFactor = function(){
					return Math.round(Math.random()* 255); //0~255색상
				}
								
				var randomColor = function(opacity){
					return "rgba(" + randomColorFactor() + "," + randomColorFactor() + "," + randomColorFactor() + ","
									+ (opacity || '.3') + ")";};
				var config1 = {
						type:'pie',
						data :  {
							datasets : [{
								data: [<c:forEach items="${rs2.rows}" var="m"> "${m.mem}",</c:forEach>], /* 화면에 출력해야하ㅏ는 데이터*/
								backgroundColor:[<c:forEach items="${rs2.rows}" var="m"> randomColor(1),</c:forEach>],}],/*randomColor(1) 투명도, 배경색상 지정*/
								labels:[<c:forEach items="${rs2.rows}" var="m"> "${m.national}",</c:forEach>] /* label 컬럼 , db에서는 이름?*/
							},
						options:{reponsive:true}
							};
				
				var config2 = {
						type:'pie',
						data :  {
							datasets : [{
								data: [<c:forEach items="${rs1.rows}" var="m"> "${m.mem}",</c:forEach>], /* 화면에 출력해야하ㅏ는 데이터*/
								backgroundColor:[<c:forEach items="${rs1.rows}" var="m"> randomColor(1),</c:forEach>],}],/*randomColor(1) 투명도, 배경색상 지정*/
								labels:[<c:forEach items="${rs1.rows}" var="m"> "${m.national}",</c:forEach>] /* label 컬럼 , db에서는 이름?*/
							},
						options:{reponsive:true}
							};
					
						window.onload=function(){
							var ctx2 = document.getElementById("canvas2").getContext("2d");
							new Chart(ctx2,config1);
							var ctx1 = document.getElementById("canvas1").getContext("2d");
							new Chart(ctx1,config2);			
						}
				</script>
		</div> 
						<!-- .sidebar -->
	</div>
		<div class="container single-page">
			<div class="row">
				<div class="col-12 col-lg-9" style="float:left">
					<div class="content-wrap">
						<header class="entry-header">
							<div class="posted-photo">Popular Photo Spot</div>
						</header><!-- .entry-header -->
						<figure class="featured-image">
							<c:forEach var="b" items="${mainlist}" begin="0" end="1">
								<img src="../board/picture/${b.img}" class="photo">
							</c:forEach>
						</figure><!-- .featured-image -->
					</div><!-- .content-wrap -->
				</div>
				<div class="col-12 col-lg-9">
					<div class="content-wrap">   
						<header class="entry-header">
							<div class="posted-photo">Recommendation Site</div>
						</header>  
							<div class="link">
							<table  style="margin-right:auto; margin-left:auto;">
							 <tr><td><figure class="featured-banner">
								<div class="banner">
									<a href="http://www.skyscanner.co.kr" target="_blank"><img src="../../images/bann1.png" ></a>
								</div>
							</figure>
							</td><td><figure class="featured-banner">
								<div class="banner">
									<a href="https://http://www.airbnb.co.kr" target="_blank"><img src="../../images/bann2.png" ></a>
								</div>
							</figure>
							</td><tr>
							 
							<tr><td>
							<figure class="featured-banner">
								<div class="banner">
									<a href="https://www.myrealtrip.com" target="_blank"><img src="../../images/bann3.png" ></a>
								</div>
							</figure>
							</td><td><figure class="featured-banner">
								<div class="banner">
									<a href="https://www.skyscanner.co.kr" target="_blank"><img src="../../images/bann4.png" ></a>
								</div>  
							</figure>
							</td></tr>
							</table>
							</div>
							<!-- .featured-image -->
						</div>         
						<!-- .content-wrap -->
					</div>
					<!-- .col -->

					<!-- .col -->
</div>
				<!-- .row -->
</div>
			<!-- .container -->
</div>
		<!-- .outer-container -->
</div>
<script type='text/javascript' src='../../js/jquery.js'></script>
<script type='text/javascript' src='../../js/swiper.min.js'></script>
<script type='text/javascript' src='../../js/custom.js'></script>
</body>
</html>