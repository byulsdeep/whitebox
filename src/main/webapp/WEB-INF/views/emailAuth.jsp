<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Eメール認証</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>
        <h3></h3>
        <h4>
            <a href="/">ホワイトボックスに戻る</a>
        </h4>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/member/footer.js"></script>
    </body>
    <script>
        const h3 = document.querySelector('h3');
        if ('${result}' === 'true') {
            h3.innerText = 'Eメール認証が成功しました！';
        } else if ('${result}' === '?') {
            h3.innerText = 'すでに認証済みです!';
        } else {
            h3.innerText = 'Eメール認証が失敗しました！';
        }
    </script>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans JP', sans-serif;
            font-size: 15px;
        }
        h3, h4 {
            padding: 35px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</html>
