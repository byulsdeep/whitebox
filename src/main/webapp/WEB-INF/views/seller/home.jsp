<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>ホワイトボックスセラー</title>
<script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
<link rel='stylesheet' href='/res/css/reset.css' />
<!-- navbar CSS -->
<link rel="stylesheet" href="/res/css/seller/navbar.css" />
<!-- footer css-->
<link rel="stylesheet" href="/res/css/seller/footer.css" />
<link rel='stylesheet' href='/res/css/seller/BYUL_dashboard.css' />
</head>
<body>
	<!-- NAVBAR -->
	<nav class="navbar"></nav>
	<!-- NAVBAR JS -->
	<script src="/res/js/seller/navbar.js"></script>
	<a href='/seller/proRegist'><input type="button" value="상품등록"></a>
	<div class="main">
		<div class="main_top">
			<div class="main_top_left">
				<div class="main_top_left_top">매출 및 판매수량</div>
				<div class="main_top_left_bottom">처리 해야 할 일</div>
			</div>
			<div class="main_top_right">신규 팔로우</div>
		</div>
		<div class="main_bottom">대시보드용 통계</div>
	</div>
</body>
<!-- footer -->
<footer class="footer_container"></footer>
<script src='/res/js/seller/footer.js'></script>
<script>
	let userInfo;
	if ('${userInfo}' !== '') {
		userInfo = JSON.parse('${userInfo}');
	}
	if (userInfo !== undefined) {
		changeNavbar(userInfo);
        const moveSellerProductListButton = document.querySelector('#moveSellerProductListButton');
        moveSellerProductListButton.href = '/seller/productList?proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=10';
	}
</script>
</html>
