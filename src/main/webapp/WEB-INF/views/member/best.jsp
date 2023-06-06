<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>best</title>
<link rel="stylesheet" href="./res/css/join_BI.css" />
   <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
</head>
<body>
   <!-- NAVBAR -->
   <nav class="navbar"></nav>
   <!-- NAVBAR JS -->
   <script src="res/js/navbar.js"></script>
     <div class="main">
   <h1>BEST プレゼント</h1>
   <ul class="category">
      <li><a href="">全体</a></li>
      <li><a href="">コスメティック</a></li>
      <li><a href="">ファッション</a></li>
      <li><a href="">ペット</a></li>
   </ul>
     <!-- 상품리스트 -->
     {getBestproductList}
   <div id="getBestproductList">${pro_name}</div>
     </div>
</body>
</html>