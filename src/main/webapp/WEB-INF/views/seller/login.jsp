<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>セラーログイン</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/seller/navbar.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/seller/footer.css" />
        <link rel="stylesheet" href="/res/css/seller/login.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/seller/navbar.js"></script>
        <!-- MAIN -->
        <div class="main">
            <h1 class="title-text">SELLER LOGIN</h1>
            <form action="/seller/login" method="post">
                <input class="write-box" name="usrId" placeholder="ID / メールアドレス" />
                <input class="write-box" name="usrPassword" placeholder="Password / パスワード" type="password" />
                <button class="login-button" type="submit">SIGN IN</button>
                <!-- <div class="checkbox_wrap">
                    <a href="">Forgot your ID or Password?</a>
                    <div>
                        <input type="checkbox" />
                        <div>ID Save</div>
                    </div>
                </div> -->
                <div class="content-text" id="message"></div>
            </form>
            <a class="join-button" href="/sellerSignUp">新規会員登録</a>
        </div>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/seller/footer.js"></script>
    </body>
    <script>
        document.querySelectorAll('[name="usrId"]')[0].focus();
        // 로그인 실패 알림
        if ('${message}' !== '') {
            const message = document.querySelector('#message');
            message.innerText = '${message}';
        }
        let welcomeInfo;
        // 회원가입 종료 시 얼러트
        if ('${welcomeInfo}' !== '') {
            welcomeInfo = JSON.parse('${welcomeInfo}');
            alert(welcomeInfo.usrLastname + welcomeInfo.usrFirstname + 'さん登録おめでとうございます！ ログインしてWhiteboxを楽しんでください！');
        }
    </script>
</html>
