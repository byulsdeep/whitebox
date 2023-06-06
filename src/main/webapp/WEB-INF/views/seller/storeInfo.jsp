<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>매장정보</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
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
        <hr />

        <h1 class="title-text">ストア情報</h1>
        <div class="main">
            <form action="/seller/updateSellerProfileImage" method="post" enctype="multipart/form-data">
                <div class="content-text" id="usrImageLabel">
                    プロフィール写真
                    <span>
                        <button class="file-button" onclick="event.preventDefault(); document.querySelector('#usrImageFile').click()">写真選択</button>
                        <button class="file-button">写真登録</button>
                    </span>
                </div>
                <img id="usrProfile" class="selInfo_profile_image" />
                <input name="usrImageFile" id="usrImageFile" style="display: none" type="file" onchange="previewUsrImage()" />
            </form>

            <form id="store_modify" action="/seller/storeInfo" method="post">
                <input id="usrImage" style="display: none" type="text" name="usrImage" />
                <div class="content-text">加入日</div>
                <input class="write-box" id="usrDate" name="usrDate" disabled />
                <!-- 0 -->
                <div class="content-text">ID</div>
                <input class="write-box" id="usrId" name="usrId" disabled onchange="validateUsrId()" /><span id="usrIdMessage"></span>
                <!-- 1 -->
                <div class="content-text">パスワード</div>
                <input id="usrPassword" class="write-box" name="usrPassword" type="password" disabled oninput="validateUsrPassword(); checkPasswordEqual()" /><span id="usrPasswordMessage"></span>
                <!-- 2 -->
                <div class="content-text">パスワード 確認</div>
                <input id="usrPasswordConfirm" class="write-box" type="password" disabled oninput="checkPasswordEqual()" /><span id="usrPasswordConfirmMessage"></span>
                <!-- 3 -->
                <div class="content-text">氏 名</div>
                <input id="usrLastname" class="write-box2" name="usrLastname" disabled oninput="validateUsrNames()" />
                <input id="usrFirstname" class="write-box2" name="usrFirstname" disabled oninput="validateUsrNames()" />
                <div id="usrNamesMessage"></div>
                <!-- 6 -->
                <div class="content-text">住所</div>
                <input id="usrAddress" class="write-box" disabled name="usrAddress" onchange="validateUsrAddress()" /><span id="usrAddressMessage"></span>
                <!-- 4 -->
                <div class="content-text">電話番号</div>
                <input id="usrPhone" class="write-box" name="usrPhone" type="tel" disabled onchange="validateUsrPhone()" /><span id="usrPhoneMessage"></span>
                <!-- 5 -->
                <div class="content-text">Eメール</div>
                <input id="usrEmail" class="write-box" name="usrEmail" type="email" disabled onchange="validateUsrEmail()" /><span id="usrEmailMessage"></span>
                <!-- 7 -->
                <div class="content-text">Shop Name</div>
                <input class="write-box" id="selShopname" name="selShopname" value="" disabled onchange="validateSelShopname()" /><span id="selShopnameMessage"></span>
                <!-- 8 -->
                <div class="content-text">ストア説明</div>
                <textarea class="write-box" id="selInfo" name="selInfo" style="height: 200px" disabled onchange="validateSelInfo()"></textarea>
                <span id="selInfoMessage"></span>
                <div id="finalMessage"></div>
            </form>
            <button id="editButton" class="join-button" onclick="event.preventDefault(); enableInputs()">修整</button>
            <button id="submit" class="join-button" onclick="editSave()">登録</button>
        </div>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/seller/footer.js"></script>
    </body>
    <script src="/res/js/projectUtils.js"></script>
    <script>
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
		    changeNavbar(userInfo);
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

        let usrProfile = document.querySelector('#usrProfile');
        usrProfile.src = userInfo.usrImage;

        console.log(userInfo);
        document.getElementsByName('usrImage')[0].value = userInfo.usrImage;
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

        const usrId = document.querySelector('#usrId');
        const idMessage = document.querySelector('#usrIdMessage');
        const usrPassword = document.querySelector('#usrPassword');
        const usrPasswordMessage = document.querySelector('#usrPasswordMessage');
        const usrPasswordConfirm = document.querySelector('#usrPasswordConfirm');
        const usrPasswordConfirmMessage = document.querySelector('#usrPasswordConfirmMessage');
        const usrLastname = document.querySelector('#usrLastname');
        const usrFirstname = document.querySelector('#usrFirstname');
        const usrNamesMessage = document.querySelector('#usrNamesMessage');
        const usrPhone = document.querySelector('#usrPhone');
        const usrPhoneMessage = document.querySelector('#usrPhoneMessage');
        const usrEmail = document.querySelector('#usrEmail');
        const usrEmailMessage = document.querySelector('#usrEmailMessage');
        const usrAddress = document.querySelector('#usrAddress');
        const usrAddressMessage = document.querySelector('#usrAddressMessage');
        const usrAddressDetail = document.querySelector('#usrAddressDetail');
        const usrAddressDetailMessage = document.querySelector('#usrAddressDetailMessage');
        const usrImageFile = document.querySelector('#usrImageFile');
        const usrImage = document.querySelector('#usrImage');
        const selShopname = document.querySelector('#selShopname');
        const selShopnameMessage = document.querySelector('#selShopnameMessage');
        const selInfo = document.querySelector('#selInfo');
        const selInfoMessage = document.querySelector('#selInfoMessage');
        const finalMessage = document.querySelector('#finalMessage');
        const form = document.querySelector('form');
        const submit = document.querySelector('#submit');

        const memIssocial = document.createElement('input');
        memIssocial.name = 'memIssocial';
        memIssocial.type = 'hidden';
        memIssocial.value = 'F';
        form.appendChild(memIssocial);

        /* 유효성 확인 */ // ID   PASS   PASSCON NAMES PHONE  EMAIL ADDRESS SHOPN  SHOPINFO
        let isValid = [false, false, false, false, false, false, false, false, false];

        function validateUsrId() {
            const format = /^[a-z0-9_-]{5,24}$/;
            // usrId 형식 확인
            if (!format.test(usrId.value)) {
                idMessage.style.color = 'red';
                idMessage.innerText = '5～20文字の小文字（a～z）、数字、特殊文字（_、-）をご使用ください';
                isValid[0] = false;
                return;
            }
            // usrId 중복확인
            sendAjaxPost('checkUsrIdDuplicate', makeFormData('usrId', usrId.value), 'makeIsDuplicate');
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
            const format = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
            if (!format.test(usrPassword.value)) {
                usrPasswordMessage.style.color = 'red';
                usrPasswordMessage.innerText = '8〜16文字の英字大小文字、数字、特殊文字をご使用ください';
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
            if (usrPassword.value !== usrPasswordConfirm.value || usrPasswordConfirm.value.length < 1) {
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
                usrNamesMessage.innerText = '日本語と英文大小文字をご使用ください（特殊記号、空白使用不可）';
                isValid[3] = false;
                return;
            }
            usrNamesMessage.innerText = '';
            isValid[3] = true;
            globalValidate();
        }
        function validateUsrPhone() {
            usrPhoneMessage.style.color = 'red';
            const format = /^[0-9]+$/;
            if (usrPhone.value.length < 1) {
                usrPhoneMessage.innerText = '必須項目です';
                isValid[4] = false;
                return;
            }
            if (!format.test(usrPhone.value)) {
                usrPhoneMessage.innerText = '電話番号の形式をご確認ください';
                isValid[4] = false;
                return;
            }
            usrPhoneMessage.innerText = '';
            isValid[4] = true;
            globalValidate();
        }
        function validateUsrEmail() {
            usrEmailMessage.style.color = 'red';
            const format = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (usrEmail.value.length < 1) {
                usrEmailMessage.innerText = '必須項目です';
                isValid[5] = false;
                return;
            }
            if (!format.test(usrEmail.value)) {
                usrEmailMessage.innerText = 'Eメールの形式をご確認ください';
                isValid[5] = false;
                return;
            }
            usrEmailMessage.innerText = '';
            isValid[5] = true;
            globalValidate();
        }
        function validateUsrAddress() {
            usrAddressMessage.style.color = 'red';
            const format = /^[A-Za-z0-9\s\-\.,\u3131-\u3163\uac00-\ud7a3\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff]+$/;
            if (usrAddress.value.length < 1) {
                usrAddressMessage.innerText = '必須項目です';
                isValid[6] = false;
                return;
            }
            if (!format.test(usrAddress.value)) {
                usrAddressMessage.innerText = '住所の形式をご確認ください';
                isValid[6] = false;
                return;
            }
            usrAddressMessage.innerText = '';
            isValid[6] = true;
            globalValidate();
        }

        function previewUsrImage() {
            console.log(usrImageFile.files[0]);
            const reader = new FileReader();
            reader.onload = () => (usrProfile.src = reader.result);
            reader.readAsDataURL(usrImageFile.files[0]);
        }

        function validateSelShopname() {
            selShopnameMessage.style.color = 'red';
            if (selShopname.value.length < 1) {
                selShopnameMessage.innerText = '必須項目です';
                isValid[7] = false;
                return;
            }
            selShopnameMessage.innerText = '';
            isValid[7] = true;
            globalValidate();
        }
        function validateSelInfo() {
            selInfoMessage.style.color = 'red';
            if (selInfo.value.innerText < 1) {
                selInfoMessage.innerText = '必須項目です';
                isValid[8] = false;
                return;
            }
            selInfoMessage.innerText = '';
            isValid[8] = true;
            globalValidate();
        }

        function globalValidate() {
            if (isValid.every((value) => value)) {
                finalMessage.innerText = '';
            }
        }
        /* 정보 수정 */
        function editSave() {
            finalMessage.style.color = 'red';
            console.log(isValid);
            if (!isValid.every((value) => value)) {
                finalMessage.innerText = '形式をご確認ください';
                return;
            }
            finalMessage.innerText = '';

            document.querySelectorAll('input').forEach((input) => console.log(input.name !== '' ? input.name + ' : ' + input.value : ''));
            console.log(form.innerHTML);
            form.submit();
        }
        if ('${error}' !== '') {
            finalMessage.style.color = 'red';
            finalMessage.innerText = '形式をご確認ください';
        }
        function editSave(event) {
            document.getElementsByName('usrId')[0].disabled = false;
            document.getElementById('store_modify').submit();
        }
    </script>
</html>
