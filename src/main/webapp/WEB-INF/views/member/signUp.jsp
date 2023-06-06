<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>ホワイトボックス会員登録</title>
<script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
<link rel='stylesheet' href='/res/css/reset.css' />
<!-- navbar CSS -->
<link rel="stylesheet" href="/res/css/member/navbar.css" />
<!-- footer css-->
<link rel="stylesheet" href="/res/css/member/footer.css" />
<link rel='stylesheet' href='/res/css/member/BI_signUp.css' />
</head>
<body>
	<!-- NAVBAR -->
	<nav class="navbar"></nav>
	<!-- NAVBAR JS -->
	<script src="/res/js/member/navbar.js"></script>
	<!-- MAIN -->
	<div class="main">
		<h1 class="title-text">MEMBER SIGN UP</h1>
		<form action="/memberSignUp" method="post" enctype="multipart/form-data">
			<!-- 0 -->
			<div class="content-text">ID</div>
			<input class="write-box" id="usrId" name="usrId" onchange="validateUsrId()" /><span id="usrIdMessage"></span>
			<!-- 1 -->
			<div id="usrPasswordLabel" class="content-text">パスワード</div>
			<input id="usrPassword" class="write-box" name="usrPassword" oninput="validateUsrPassword(); checkPasswordEqual()" type="password" /><span id="usrPasswordMessage"></span>
			<!-- 2 -->
			<div id="usrPasswordConfirmLabel" class="content-text">パスワード 確認</div>
			<input id="usrPasswordConfirm" class="write-box" oninput="checkPasswordEqual()" type="password" /><span id="usrPasswordConfirmMessage"></span>
			<!-- 3 -->
			<div class="content-text">氏 名</div>
			<input id="usrLastname" class="write-box2" name="usrLastname" oninput="validateUsrNames()" /> 
			<input id="usrFirstname" class="write-box2" name="usrFirstname" oninput="validateUsrNames()" />
			<div id="usrNamesMessage"></div>
			<!-- 4 -->
			<div class="content-text">生年月日</div>
			<input id="memBirthyear" class="write-box3" placeholder="年(4字)" maxlength="4" onchange="validateMembirthday()" /> 
			<select id="memBirthmonth" class="write-box3" onchange="validateMembirthday()">
				<option value="">月</option>
				<option value="01">1</option>
				<option value="02">2</option>
				<option value="03">3</option>
				<option value="04">4</option>
				<option value="05">5</option>
				<option value="06">6</option>
				<option value="07">7</option>
				<option value="08">8</option>
				<option value="09">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select> 
			<input id="memBirthday" class="write-box3" placeholder="日" maxlength="2" onchange="validateMembirthday()" /><span id="memBirthdayMessage"></span>
			<!-- 5 -->
			<div class="content-text">性別</div>
			<div class="content-text">
				男<input id="memGenderMale" name="memGender" value="M" type="radio" onchange="validateMemGender()" /> 女<input id="memGenderFemale" name="memGender" value="F" type="radio" onchange="validateMemGender()" />
			</div>
			<span id="memGenderMessage"></span>
			<!-- 6 -->
			<div class="content-text">電話番号</div>
			<input id="usrPhone" class="write-box" name="usrPhone" type="tel" onchange="validateUsrPhone()" /><span id="usrPhoneMessage"></span>
			<!-- 7 -->
			<div class="content-text">Eメール</div>
			<input id="usrEmail" class="write-box" name="usrEmail" type="email" onchange="validateUsrEmail()" /><span id="usrEmailMessage"></span>
			<!-- 8 -->
			<div class="content-text">住所</div>
			<input id="usrAddress" class="write-box" onchange="validateUsrAddress()" /><span id="usrAddressMessage"></span>
			<div class="content-text">住所詳細</div>
			<input id="usrAddressDetail" class="write-box" onchange="validateUsrAddressDetail()" /><span id="usrAddressDetailMessage"></span>
			<!-- 9 -->
			<div class="content-text">郵便番号</div>
			<input id="memPostal" class="write-box" name="memPostal" onchange="validateMemPostal()" /><span id="memPostalMessage"></span>
			<div class="content-text" id="usrImageLabel">プロフィール写真
        <button class="file-button" onclick="event.preventDefault(); document.querySelector('#usrImageFile').click()">사진 선택</button>
      </div>
			<input id="usrImageFile" style="display: none" type="file" name="usrImageFile" onchange="previewUsrImage()" /><br /> <img id="usrImage" width="100px" />
			<div id="finalMessage"></div>
		</form>
		<button id="submit" class="join-button" onclick="memberSignUp()">加入</button>
	</div>
	<!-- footer -->
	<footer class="footer_container"></footer>
	<script src='/res/js/member/footer.js'></script>
</body>
<script src="/res/js/projectUtils.js"></script>
<script>
  const usrId = document.querySelector('#usrId');
  const idMessage = document.querySelector('#usrIdMessage');
  const usrPasswordLabel = document.querySelector('#usrPasswordLabel');
  const usrPassword = document.querySelector('#usrPassword');
  const usrPasswordMessage = document.querySelector('#usrPasswordMessage');
  const usrPasswordConfirmLabel = document.querySelector('#usrPasswordConfirmLabel');
  const usrPasswordConfirm = document.querySelector('#usrPasswordConfirm');
  const usrPasswordConfirmMessage = document.querySelector('#usrPasswordConfirmMessage');
  const usrLastname = document.querySelector('#usrLastname');
  const usrFirstname = document.querySelector('#usrFirstname');
  const usrNamesMessage = document.querySelector('#usrNamesMessage');
  const memBirthdayMessage = document.querySelector('#memBirthdayMessage');
  const memBirthyear = document.querySelector('#memBirthyear');
  const memBirthmonth = document.querySelector('#memBirthmonth');
  const memBirthday = document.querySelector('#memBirthday');
  const memGenderMale = document.querySelector('#memGenderMale');
  const memGenderFelmale = document.querySelector('#memGenderFelmale');
  const memGenderMessage = document.querySelector('#memGenderMessage');
  const usrPhone = document.querySelector('#usrPhone');
  const usrPhoneMessage = document.querySelector('#usrPhoneMessage');
  const usrEmail = document.querySelector('#usrEmail');
  const usrEmailMessage = document.querySelector('#usrEmailMessage');
  const usrAddress = document.querySelector('#usrAddress');
  const usrAddressMessage = document.querySelector('#usrAddressMessage');
  const usrAddressDetail = document.querySelector('#usrAddressDetail');
  const usrAddressDetailMessage = document.querySelector('#usrAddressDetailMessage');
  const memPostal = document.querySelector('#memPostal');
  const memPostalMessage = document.querySelector('#memPostalMessage');
  const usrImageFile = document.querySelector('#usrImageFile');
  const usrImage = document.querySelector('#usrImage');
  const finalMessage = document.querySelector('#finalMessage');
  const form = document.querySelector('form');
  const submit = document.querySelector('#submit');
  const date = new Date();
  const shortMonths = ['04', '06', '09', '11'];
  
  /* 유효성 확인 */ // ID   PASS  PASSCON  NAMES  BIRTH  GENDER PHONE EMAIL  ADDRESS POSTAL
  let isValid = [false, false, false, false, false, false, false, false, false, false];

  //소셜, 일반 로그인 구분 위해 authority field 활용
  // 2023-05-08 소셜 계정 구분 필드 테이블에 추가 
  const memIssocial = document.createElement('input');
  memIssocial.name = 'memIssocial';
  memIssocial.type = 'hidden';
  memIssocial.value = 'F';
  form.appendChild(memIssocial); 
  
  /* 소셜 로그인 */
  if ('${memberInfo}' !== '') {
	  
    const memberInfo = JSON.parse('${memberInfo}');
	  
    memIssocial.value = 'T';

    isValid[0] = true; // Id
    isValid[1] = true; // Password
    isValid[2] = true; // PasswordConfirm
    isValid[7] = true; // Email
	
    usrPasswordLabel.remove();
	usrPassword.remove();
	usrPasswordMessage.remove();
	usrPasswordConfirmLabel.remove();
	usrPasswordConfirm.remove();
	usrPasswordConfirmMessage.remove();

    document.querySelector('#usrId').value = memberInfo.usrId;
    document.querySelector('#usrId').setAttribute('readonly', true);
    document.querySelector('#usrId').style.backgroundColor = 'lightgrey';

    document.querySelector('#usrEmail').value = memberInfo.usrEmail;
    document.querySelector('#usrEmail').setAttribute('readonly', true);
    document.querySelector('#usrEmail').style.backgroundColor = 'lightgrey';

      
    
    const usrImageS = document.createElement('input');
    usrImageS.name = 'usrImage';
    usrImageS.type = 'hidden';
    usrImageS.value = memberInfo.usrImage;
    form.appendChild(usrImageS); 
    
    usrImage.src = memberInfo.usrImage;
    usrImageFile.remove();
  } 

  function validateUsrId() {
    const format = /^[a-z0-9_-]{5,24}$/;
    // usrId 형식 확인
    if (!format.test(usrId.value)) {
      idMessage.style.color = 'red';
      idMessage.innerText =
        '5～20文字の小文字（a～z）、数字、特殊文字（_、-）をご使用ください';
      isValid[0] = false;
      return;
    }
    // usrId 중복확인
    sendAjaxPost(
      'checkUsrIdDuplicate',
      makeFormData('usrId', usrId.value),
      'makeIsDuplicate'
    );
  }
  function makeIsDuplicate(data) {
    let idMessage = document.querySelector('#usrIdMessage');
    if (data) {
      idMessage.style.color = 'red';
      idMessage.innerText = '使用できないIDです';
      isValid[0] = false;
      return;
    }
    idMessage.style.color = 'green';
    idMessage.innerText = '使用できるIDです';
    isValid[0] = true;
    globalValidate();
  }
  // usrPassword 형식 확인
  function validateUsrPassword() {
    const format =
      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
    if (!format.test(usrPassword.value)) {
      usrPasswordMessage.style.color = 'red';
      usrPasswordMessage.innerText =
        '8〜16文字の英字大小文字、数字、特殊文字をご使用ください';
      isValid[1] = false;
      return;
    }
    usrPasswordMessage.style.color = 'green';
    usrPasswordMessage.innerText = '✔安全';
    isValid[1] = true;
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
      isValid[2] = false;
      return;
    }
    if (!isValid[1]) {
      usrPasswordConfirmMessage.innerText = '';
      return;
    }
    usrPasswordConfirmMessage.style.color = 'green';
    usrPasswordConfirmMessage.innerText = '✔';
    isValid[2] = true;
    globalValidate();
  }
  // usrFirstname usrLastname 형식 확인
  function validateUsrNames() {
    const format = /^[가-힣ぁ-んァ-ン一-龥a-zA-Z]+$/;
    usrNamesMessage.style.color = 'red';
    if (!format.test(usrLastname.value) || !format.test(usrFirstname.value)) {
      usrNamesMessage.innerText =
        '日本語と英文大小文字をご使用ください（特殊記号、空白使用不可）';
      isValid[3] = false;
      return;
    }
    usrNamesMessage.innerText = '';
    isValid[3] = true;
    globalValidate();
  }

  function validateMembirthday() {
	  console.log('here')
    memBirthdayMessage.style.color = 'red';
    if (memBirthyear.value.length !== 4) {
      memBirthdayMessage.innerText = '生まれた年の4桁を正確に入力してください';
      isValid[4] = false;
      return;
    }
    console.log(Number(memBirthmonth.value))
    console.log(date.getMonth())
    console.log(Number(date.getMonth()))
    
    if (
    	Number(memBirthyear.value) > date.getFullYear() ||
    	(Number(memBirthyear.value) === date.getFullYear() && Number(memBirthmonth.value) > date.getMonth() + 1) ||
    	(Number(memBirthyear.value) === date.getFullYear() && Number(memBirthmonth.value) === date.getMonth() + 1 && Number(memBirthday.value) > date.getDay())	
    		
    ) {
      memBirthdayMessage.innerText = '未来から来ましたね。 ^^';
      isValid[4] = false;
      return;
    }
    if (Number(memBirthyear.value) < Number(date.getFullYear()) - 100) {
      memBirthdayMessage.innerText = '本当ですか？？？？';
      isValid[4] = false;
      return;
    }
    if (
      Number(memBirthday.value) > 31 ||
      (shortMonths.includes(memBirthmonth.value) && Number(memBirthday.value) > 30) ||
      (memBirthmonth.value === '02' && Number(memBirthday.value) > 29) ||
      (Number(memBirthyear.value) % 4 !== 0 && memBirthmonth.value === '02' && Number(memBirthday.value) > 28) ||	  
      Number(memBirthday.value) < 1
    				  ) {
      memBirthdayMessage.innerText = '生年月日をもう一度確認してください';
      isValid[4] = false;
      return;
    }
    isValid[4] = true;
    memBirthdayMessage.innerText = '';
    globalValidate();
  }
  function validateMemGender() {
    memGenderMessage.style.color = 'red';
    if (!memGenderMale.checked && !memGenderFemale.checked) {
      memGenderMessage.innerText = '性別をご選択ください';
      isValid[5] = false;
      return;
    }
    memGenderMessage.innerText = '';
    isValid[5] = true;
    globalValidate();
  }
  function validateUsrPhone() {
    usrPhoneMessage.style.color = 'red';
    const format = /^[0-9]+$/;
    if (usrPhone.value.length < 1) {
      usrPhoneMessage.innerText = '必須項目です';
      isValid[6] = false;
      return;
    }
    if (!format.test(usrPhone.value)) {
      usrPhoneMessage.innerText = '電話番号の形式をご確認ください';
      isValid[6] = false;
      return;
    }
    usrPhoneMessage.innerText = '';
    isValid[6] = true;
    globalValidate();
  }
  function validateUsrEmail() {
    usrEmailMessage.style.color = 'red';
    const format = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (usrEmail.value.length < 1) {
      usrEmailMessage.innerText = '必須項目です';
      isValid[7] = false;
      return;
    }
    if (!format.test(usrEmail.value)) {
      usrEmailMessage.innerText = 'Eメールの形式をご確認ください';
      isValid[7] = false;
      return;
    }
    usrEmailMessage.innerText = '';
    isValid[7] = true;
    globalValidate();
  }
  function validateUsrAddress() {
    usrAddressMessage.style.color = 'red';
    const format = /^[A-Za-z0-9\s\-\.,\u3131-\u3163\uac00-\ud7a3\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff]+$/;
    if (usrAddress.value.length < 1) {
      usrAddressMessage.innerText = '必須項目です';
      isValid[8] = false;
      return;
    }
    if (!format.test(usrAddress.value)) {
      usrAddressMessage.innerText = '住所の形式をご確認ください';
      isValid[8] = false;
      return;
    }
    usrAddressMessage.innerText = '';
    isValid[8] = true;
    globalValidate();
  }
  function validateUsrAddressDetail() {
    usrAddressDetailMessage.style.color = 'red';
    const format = /^[A-Za-z0-9\s\-\.,\u3131-\u3163\uac00-\ud7a3\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff]+$/;
    if (usrAddressDetail.value.length < 1) {
      usrAddressDetailMessage.innerText = '';
      isValid[8] = false;
      return;
    }
    if (!format.test(usrAddressDetail.value)) {
      usrAddressDetailMessage.innerText = '住所の形式をご確認ください';
      isValid[8] = false;
      return;
    }
    usrAddressDetailMessage.innerText = '';
    isValid[8] = true;
    globalValidate();
  }
  function validateMemPostal() {
    memPostalMessage.style.color = 'red';
    const format = /^[0-9\-]+$/;
    if (memPostal.value.length < 1) {
      memPostalMessage.innerText = '必須項目です';
      isValid[9] = false;
      return;
    }
    if (!format.test(memPostal.value)) {
      memPostalMessage.innerText = '郵便番号の形式をご確認ください';
      isValid[9] = false;
      return;
    }
    memPostalMessage.innerText = '';
    isValid[9] = true;
    globalValidate();
  }
	function previewUsrImage() {
		console.log(usrImageFile.files[0]);
		const reader = new FileReader();
		reader.onload = () => usrImage.src = reader.result;
		reader.readAsDataURL(usrImageFile.files[0]);
	}
  function globalValidate() {
    if (isValid.every(value => value)) {
      finalMessage.innerText = '';
    }
  }
  /* 일반 회원 가입 */
  function memberSignUp() {
    finalMessage.style.color = 'red';
    console.log(isValid);
     if (!isValid.every(value => value)) {
      finalMessage.innerText = '形式をご確認ください';
      return;
    }
    finalMessage.innerText = '';
    const usrAddressS = document.createElement('input');
    usrAddressS.name = 'usrAddress';
    usrAddressS.type = 'hidden';
    usrAddressS.value = usrAddress.value + ' ' + usrAddressDetail.value;
    form.appendChild(usrAddressS);
    const memBirthdayS = document.createElement('input');
    memBirthdayS.name = 'memBirthday';
    memBirthdayS.type = 'hidden';
    memBirthdayS.value = memBirthyear.value + memBirthmonth.value + 
    (memBirthday.value.length < 2 ? '0' + memBirthday.value : memBirthday.value);
    form.appendChild(memBirthdayS);

    document.querySelectorAll('input').forEach(input => console.log(input.name !== '' ? input.name + ' : ' + input.value : ''));
    form.submit();
  }
  if ('${error}' !== '') {
    finalMessage.style.color = 'red';
    finalMessage.innerText = '形式をご確認ください';
  }
</script>
</html>
