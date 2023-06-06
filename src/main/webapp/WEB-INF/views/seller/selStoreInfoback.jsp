<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>매장정보</title>
    <script
      src="https://kit.fontawesome.com/e59267a363.js"
      crossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="/res/css/reset.css" />
    <!-- navbar CSS -->
    <link rel="stylesheet" href="/res/css/seller/navbar.css" />
    <!-- footer css-->
    <link rel="stylesheet" href="/res/css/seller/footer.css" />
    <link rel="stylesheet" href="/res/css/seller/hh_selStoreInfo.css" />
  </head>
  <body>
    <!-- NAVBAR -->
    <nav class="navbar"></nav>
    <!-- NAVBAR JS -->
    <script src="/res/js/seller/navbar.js"></script>

    <h1 class="store_title">매장 정보</h1>
    <div class="pro_info">
      <form
        id="store_modify"
        class="pro_form"
        action="/seller/selStoreInfo"
        method="post"
        enctype="multipart/form-data"
      >
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrImage">프로필</label>
          </div>
          <div
            class="store_info_contents"
            style="border: solid 1px #dddddd; border-radius: 4px"
          >
            <div class="pro_image_container">
              <div class="pro_image_item empty">
                <div class="empty-text">X</div>
              </div>
            </div>
            <!-- <input type="file" name="usrImage" multiple /> -->
            <input type="text" name="usrImage" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrId">ID</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrId" />
          </div>
        </div>
        <!-- <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrPassword">PASSWORD</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrPassword" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrPassword">PASSWORD 확인</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrPassword" />
          </div>
        </div> -->
        <!-- 1 -->
        <div class="content-text">パスワード</div>
        <input
          id="usrPassword"
          class="write-box"
          name="usrPassword"
          oninput="validateUsrPassword(); checkPasswordEqual()"
          type="password"
        /><span id="usrPasswordMessage"></span>
        <!-- 2 -->
        <div class="content-text">パスワード 確認</div>
        <input
          id="usrPasswordConfirm"
          class="write-box"
          oninput="checkPasswordEqual()"
          type="password"
        /><span id="usrPasswordConfirmMessage"></span>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="selShopname">매장명</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="selShopname" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrName">이름</label>
          </div>
          <div class="store_info_contents_name">
            <input
              type="text"
              disabled
              name="usrFirstname"
              style="width: 248px"
            />
            <input
              type="text"
              disabled
              name="usrLastname"
              style="width: 248px"
            />
          </div>
        </div>

        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrPhone">전화번호</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrPhone" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrEmail">이메일</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrEmail" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrAddress">주소</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrAddress" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="usrDate">가입날짜</label>
          </div>
          <div class="store_info_contents">
            <input type="text" disabled name="usrDate" />
          </div>
        </div>
        <div class="store_info_box">
          <div class="store_info_name">
            <label for="selInfo">매장소개</label>
          </div>
          <div class="store_info_contents">
            <textarea
              id="subject"
              name="selInfo"
              style="height: 200px"
              disabled
            ></textarea>
          </div>
        </div>
        <div class="store_info_submit">
          <button
            id="editButton"
            onclick="event.preventDefault(); enableInputs()"
          >
            수정
          </button>
          <input type="submit" onclick="editSave(event)" value="저장" />
        </div>
      </form>
    </div>
    <div>${error}</div>
    <!-- footer -->
    <footer class="footer_container"></footer>
    <script src="/res/js/seller/footer.js"></script>
    <div class="pro_image_container"></div>
  </body>
  <script src="/res/js/projectUtils.js"></script>
  <script>
    if ('${userInfo}' !== '') {
      userInfo = JSON.parse('${userInfo}');
    }

    let newInfo;
    if ('${newInfo}' !== '') {
      userInfo = JSON.parse('${newInfo}');
    }

    let falseInfo;
    if ('${falseInfo}' !== '') {
      userInfo = '${falseInfo}';
      //alert(falseInfo);
    }
    // 로그인이고 회원가입후가 아닐 시
    if (userInfo !== undefined) {
      changeNavbar(userInfo);
    }
    console.log(userInfo);
    document.getElementsByName('usrId')[0].value = userInfo.usrId;
    document.getElementsByName('usrLastname')[0].value = userInfo.usrLastname;
    document.getElementsByName('usrFirstname')[0].value = userInfo.usrFirstname;
    document.getElementsByName('usrPhone')[0].value = userInfo.usrPhone;
    document.getElementsByName('usrEmail')[0].value = userInfo.usrEmail;
    document.getElementsByName('usrAddress')[0].value = userInfo.usrAddress;
    document.getElementsByName('usrDate')[0].value = userInfo.usrDate;
    document.getElementsByName('selShopname')[0].value = userInfo.selShopname;
    document.getElementsByName('selInfo')[0].value = userInfo.selInfo;

    function enableInputs() {
      document.getElementsByName('usrLastname')[0].disabled = false;
      document.getElementsByName('usrFirstname')[0].disabled = false;
      document.getElementsByName('usrPhone')[0].disabled = false;
      document.getElementsByName('usrEmail')[0].disabled = false;
      document.getElementsByName('usrAddress')[0].disabled = false;
      document.getElementsByName('selShopname')[0].disabled = false;
      document.getElementsByName('selInfo')[0].disabled = false;
    }

    const usrPassword = document.querySelector('#usrPassword');
    const usrPasswordMessage = document.querySelector('#usrPasswordMessage');

    let isValid = [false, false];

    // usrPassword 형식 확인
    function validateUsrPassword() {
      const format =
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
      if (!format.test(usrPassword.value)) {
        usrPasswordMessage.style.color = 'red';
        usrPasswordMessage.innerText =
          '8〜16文字の英字大小文字、数字、特殊文字をご使用ください';
        isValid[0] = false;
        return;
      }
      usrPasswordMessage.style.color = 'green';
      usrPasswordMessage.innerText = '✔安全';
      isValid[0] = true;
      globalValidate();
    }
    // usrPassword 같음 확인
    function checkPasswordEqual() {
      console.log(usrPassword.value);
      console.log(usrPasswordConfirm.value);
      if (
        usrPassword.value !== usrPasswordConfirm.value ||
        usrPasswordConfirm.value.length < 1
      ) {
        usrPasswordConfirmMessage.style.color = 'red';
        usrPasswordConfirmMessage.innerText = 'パスワードが違います';
        isValid[1] = false;
        return;
      }
      if (!isValid[0]) {
        usrPasswordConfirmMessage.innerText = '';
        return;
      }
      usrPasswordConfirmMessage.style.color = 'green';
      usrPasswordConfirmMessage.innerText = '✔';
      isValid[1] = true;
      globalValidate();
    }

    function editSave(event) {
      document.getElementsByName('usrId')[0].disabled = false;
      document.getElementById('store_modify').submit();
    }
  </script>
</html>
