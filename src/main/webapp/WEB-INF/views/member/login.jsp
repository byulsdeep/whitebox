<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>ログイン</title>
    <script
      src="https://kit.fontawesome.com/e59267a363.js"
      crossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="/res/css/reset.css" />
    <!-- navbar CSS -->
    <link rel="stylesheet" href="/res/css/member/navbar.css" />
    <!-- footer css-->
    <link rel="stylesheet" href="/res/css/member/footer.css" />
    <!-- login css -->
    <link rel="stylesheet" href="/res/css/member/kej_login.css" />
  </head>
  <style></style>
  <body>
    <!-- NAVBAR -->
    <nav class="navbar"></nav>
    <!-- NAVBAR JS -->
    <script src="/res/js/member/navbar.js"></script>
    <div class="login_container">
      <div class="login_title">
        <div>MEMBER LOGIN</div>
      </div>
      <!-- <form action="/login" method="post">
			<input name="usrId" value="" />
			<input name="usrPassword" value="" type="password" />
			<input type="submit" />
			<input
			  type="hidden"
			  name="${_csrf.parameterName }"
			  value="${_csrf.token }"
			/>
		  </form> -->
      <div class="login_input">
        <form action="/login" method="post">
          <div class="login_box">
            <input name="usrId" value="" placeholder="ID / メールアドレス" />
            <input
              name="usrPassword"
              value=""
              type="password"
              placeholder="Password / パスワード"
            />
            <button class="member_login-button" type="submit">SIGN IN</button>
            <input
              type="hidden"
              name="${_csrf.parameterName }"
              value="${_csrf.token }"
            />
          </div>
          <div class="id_save">
            <!-- <span>For got your ID or Pass word ?</span> -->
            <span id="message"></span>
            <!-- <div>
              <input type="checkbox" />
              <span>ID Save</span>
            </div> -->
          </div>
        </form>
        <div class="login_box">
          <a class="member_join-button" href="/memberSignUp">新規会員登録</a>
          <a
            class="line"
            href="https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=YOUR_CLIENT_ID_HERE&redirect_uri=http://localhost/oauth/line&state=12345abcde&scope=profile%20email%20openid"
            ><img src="/res/img/kej/linelogo.png" alt="" /> LINEログイン </a
          ><br />
          <a
            class="google"
            href="https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=YOUR_CLIENT_ID_HERE&redirect_uri=http://localhost/oauth/google&state=12345abcde&scope=profile%20email%20openid"
            ><img src="/res/img/kej/google.png" alt="" /> Googleログイン </a
          ><br />
          <a
            class="kakao"
            href="https://kauth.kakao.com/oauth/authorize?client_id=YOUR_CLIENT_ID_HERE&redirect_uri=http://localhost/oauth/kakao&response_type=code"
            ><img src="/res/img/kej/kakaologo.png" alt="" /> Kakaoログイン </a
          ><br />
        </div>
      </div>
    </div>
    <!-- footer -->
    <footer class="footer_container"></footer>
    <script src="/res/js/member/footer.js"></script>
  </body>
  <script>
    document.querySelectorAll('[name="usrId"]')[0].focus();
    // 로그인 실패 알림
    if ('${message}' !== '') {
      document.querySelector('#message').innerText = '${message}';
    }
  </script>
</html>
