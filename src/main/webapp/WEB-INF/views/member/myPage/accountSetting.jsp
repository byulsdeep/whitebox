<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>account settings</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <!-- NAVBAR CSS -->
        <link rel="stylesheet" href="/res/css/member/BI_signUp.css" />
        <link rel="stylesheet" href="/res/css/reset.css" />
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <link rel="stylesheet" href="/res/css/member/BI_signUp.css" />
        <link rel="stylesheet" href="/res/css/member/BI_myPage.css" />
        <!-- notification CSS-->
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <link rel="stylesheet" href="/res/css/member/footer.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>

        <main class="main_fri">
            <section class="section_left">
                <section class="section_profile">
                    <div class="my_profile_box">
                        <img class="my_profile_img" />
                        <!-- 					<img class="my_profile_img" src="/res/img/BI/nino.jpg" /> -->
                    </div>
                    <div class="my_profile">
                        <div class="my_profile_name">
                            <div class="usrLastname"></div>
                            <div class="usrFirstname"></div>
                        </div>
                        <div class="my_profile_list">
                            <a href="/member/myPage/accountSetting">情報修正</a>
                        </div>
                    </div>
                    <div class="my_profile">
                        <div class="my_profile_list">
                            <a href="/member/myPage/friendList">友達リスト</a>
                        </div>
                        <div class="my_profile_list">
                            <a href="/member/myPage/friendRequests">友達要請</a>
                        </div>
                    </div>
                </section>
                <section class="section_list">
                    <ul class="my_list">
                        <li><a href="/member/myPage/giftHistory">ギフトボックス</a></li>
                        <li><a href="/member/myPage/userWishList">欲しいものリスト</a></li>
                        <li><a href="/member/myPage/userWatchList">お気に入りリスト</a></li>
                        <li><a href="/member/myPage/orderHistory">注文内訳</a></li>
                        <li><a href="">プレゼントレビュー</a></li>
                        <li><a href="/member/myPage/userViewHistory">照会リスト</a></li>
                    </ul>
                </section>
            </section>
            <section class="section_content">
                <div class="section_content_sub_title">
                    <h1>会員情報 修正</h1>
                </div>
                <div class="section_content_div1_accountSetting">
                    <form id="updateUserImg">
                        <!-- enctype='multipart/form-data' 사진 파일 전송 시 필요-->
                        <!-- profile img 변경 -->
                        <div class="my_profile_box">
                            <img id="usrImage" width="100px" />
                        </div>
                        <input id="usrImageFile" class="file-button" type="file" name="usrImageFile" onchange="previewUsrImage()" style="height: 25px; margin-top: 100px" />
                        <button class="join-button" onclick="event.preventDefault(); updateUsrImage()" style="width: 100px; margin-top: 100px">変更</button>
                    </form>
                </div>

                <!-- password modify form -->
                <div class="section_content_div2">
                    <div class="section_content_div2_accountSetting">
                        <form id="updateUserPassword" action="/member/myPage/updateUserPassword" method="post">
                            <div class="content-text">ID</div>
                            <input class="write-box" name="" id="usrId" readonly />
                            <!-- 			<input class="write-box" /> -->
                            <div class="content-text">変更パスワード</div>
                            <input class="write-box" name="usrPassword" id="usrPassword" oninput="checkPasswordEqual()" placeholder="パスワード変更" readonly />
                            <div class="content-text">変更パスワード確認</div>
                            <input class="write-box" id="usrPasswordConfirm" oninput="checkPasswordEqual()" placeholder="パスワード変更" readonly />
                            <br />
                            <div class="passwordButtons" style="display: flex; flex-direction: row-reverse; width: 350px">
                                <button class="join-button passModifyButton" type="button" onclick="event.preventDefault(); accountSettingPasswordModify(this)" style="width: 100px">修正</button>
                                <button class="join-button" type="button" onclick="event.preventDefault(); accountSettingPasswordModify(this)" style="width: 100px; display: none; border: none">キャンセル</button>
                                <button id="updateUserPasswordSubmit" class="join-button" type="submit" onclick="event.preventDefault(); updateUserPassword()" style="width: 100px; display: none; background: #dddddd" disabled>変更</button>
                            </div>
                        </form>

                        <!-- userInform modify form -->
                        <form id="updateUserInfo" action="/member/myPage/updateUserInfo" method="post">
                            <div class="content-text">氏 名</div>
                            <input class="write-box2" id="usrLastname" readonly />
                            <input class="write-box2" id="usrFirstname" readonly />
                            <div class="content-text">性別</div>
                            <div class="content-text">
                                <!-- 男<input id="memGenderMale" name="memGender" value="M" type="radio" onchange="validateMemGender()" /> -->
                                <!-- 女<input id="memGenderFemale" name="memGender" value="F" type="radio" onchange="validateMemGender()" /> -->
                                男<input id="memGenderMale" name="memGender" value="M" type="radio" /> 女<input id="memGenderFemale" name="memGender" value="F" type="radio" />
                            </div>
                            <div class="content-text">生年月日</div>
                            <input class="write-box3" id="memBirthyear" maxlength="4" readonly />
                            <select class="write-box3" id="memBirthmonth" readonly>
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
                            <input class="write-box3" id="memBirthday" maxlength="2" readonly />
                            <div class="content-text">電話番号</div>
                            <input class="write-box" id="usrPhone" readonly />
                            <div class="content-text">Eメール</div>
                            <input class="write-box" id="usrEmail" readonly />
                            <div class="content-text">住所</div>
                            <input class="write-box" id="usrAddress" readonly />
                            <div class="content-text">郵便番号</div>
                            <input class="write-box" id="memPostal" readonly />
                            <div class="content-text">加入日時</div>
                            <input class="write-box" id="usrDate" readonly /> <br />
                            <!-- <button id="submit" class="join-button" onclick="">変更</button> -->
                            <!-- <button id="submit" class="join-button" type="submit" onclick="event.preventDefault(); updateUserInfo()">変更</button> -->
                            <div class="userInfoButtons" style="display: flex; flex-direction: row-reverse; width: 350px">
                                <button class="join-button infoModifyButton" type="button" onclick="event.preventDefault(); accountSettingUserInfoModify(this)" style="width: 100px">修正</button>
                                <button class="join-button" type="button" onclick="event.preventDefault(); accountSettingUserInfoModify(this)" style="width: 100px; display: none; border: none">キャンセル</button>
                                <button id="updateUserInfoSubmit" class="join-button" onclick="event.preventDefault(); updateUserInfo()" style="width: 100px; display: none; background: #dddddd">変更</button>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
        </main>
        <!-- notification modal-->
        <div class="notification_modal">
            <div class="notification_modal_top">
                <div class="notification_modal_close_button" onclick="toggleNotification()"><i class="fa-solid fa-xmark"></i></div>
            </div>
            <div class="notification_modal_content">
                <div class="notification_modal_feed">
                    <div class="notification_modal_message_wrap">
                        <div class="notification_modal_profile_image_wrap">
                            <img class="notification_modal_profile_image" src="/res/img/whitebox_logo_p.png" />
                        </div>
                        <div class="notification_modal_message">White Boxへようこそ</div>
                    </div>
                </div>
            </div>
            <div class="notification_modal_return_button" onclick="toggleNotification()">戻る</div>
        </div>
    </body>
    <script src="/res/js/projectUtils.js"></script>
    <script>
        if ('${message}' !== '') {
            alert('${message}');
        }
        // 알림기능
        let userInfo;
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
        }
        if (userInfo !== undefined && userInfo !== null) {
            changeNavbar(userInfo);
        }

        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }
        const main = document.querySelector('.main');
        const my_profile_img = document.querySelector('.my_profile_img');
        const usrImageFile = document.querySelector('#usrImageFile');

        console.log(userInfo);
        my_profile_img.src = userInfo.usrImage;

        if (userInfo.memIssocial === 'T') {
            usrImageFile.remove();
        }

        // profile user 이름 변동
        UserName = () => {
            const lastnameElement = document.querySelectorAll('.usrLastname');
            const firstnameElement = document.querySelectorAll('.usrFirstname');

            lastnameElement.forEach(profile => (profile.textContent = userInfo.usrLastname));
            firstnameElement.forEach(profile => (profile.textContent = userInfo.usrFirstname));
        };
        UserName();
        console.log(userInfo);

        document.querySelector('#usrId').value = userInfo.usrId;
        document.querySelector('#usrLastname').value = userInfo.usrLastname;
        document.querySelector('#usrFirstname').value = userInfo.usrFirstname;
        document.querySelector('#usrPhone').value = userInfo.usrPhone;
        document.querySelector('#usrEmail').value = userInfo.usrEmail;
        document.querySelector('#usrAddress').value = userInfo.usrAddress;
        document.querySelector('#usrImage').src = userInfo.usrImage;
        document.querySelector('#memPostal').value = userInfo.memPostal;
        document.querySelector('#usrDate').value = userInfo.usrDate;
        var memGender = userInfo.memGender;
        document.querySelector('#memGenderMale').checked = memGender === 'M';
        document.querySelector('#memGenderFemale').checked = memGender === 'F';
        document.querySelector('#memBirthyear').value = userInfo.memBirthday.substring(0, 4);
        document.querySelector('#memBirthmonth').value = userInfo.memBirthday.substring(5, 7);
        document.querySelector('#memBirthday').value = userInfo.memBirthday.substring(8, 10);
        document.querySelector('#usrDate').value = userInfo.usrDate;

        function previewUsrImage() {
            console.log(usrImageFile.files[0]);
            const reader = new FileReader();
            reader.onload = () => (usrImage.src = reader.result);
            reader.readAsDataURL(usrImageFile.files[0]);
        }

        function updateUsrImage() {
            const form = document.querySelector('#updateUserImg');
            form.action = 'updateUserImg';
            form.method = 'post';
            form.enctype = 'multipart/form-data';
            // const usrImageFile = document.querySelector('#usrImageFile');
            // form.appendChild(usrImageFile);
            form.submit();
        }
        Object.keys(userInfo).forEach(key => console.log(key + ' : ' + userInfo[key]));

        //비밀번호 수정 / 취소 / 변경
        accountSettingPasswordModify = e => {
            if (e.classList.contains('passModifyButton')) {
                document.querySelector('.passwordButtons').children[0].style.display = 'none';
                document.querySelector('.passwordButtons').children[1].style.display = 'block';
                document.querySelector('.passwordButtons').children[2].style.display = 'block';

                document.querySelector('#usrPassword').readOnly = false;
                document.querySelector('#usrPasswordConfirm').readOnly = false;
            } else {
                document.querySelector('.passwordButtons').children[0].style.display = 'block';
                document.querySelector('.passwordButtons').children[1].style.display = 'none';
                document.querySelector('.passwordButtons').children[2].style.display = 'none';

                document.querySelector('#usrPassword').readOnly = true;
                document.querySelector('#usrPassword').value = '';

                document.querySelector('#usrPasswordConfirm').readOnly = true;
                document.querySelector('#usrPasswordConfirm').value = '';
            }
        };

        //usrPassword 같음 확인
        function checkPasswordEqual() {
            if (document.querySelector('#usrPassword').value !== document.querySelector('#usrPasswordConfirm').value || document.querySelector('#usrPasswordConfirm').value.length < 1) {
                document.querySelector('#usrPassword').style.background = 'red';
                document.querySelector('#updateUserPasswordSubmit').style.backGround = '#dddddd';
                document.querySelector('#updateUserPasswordSubmit').disabled = true;
            } else {
                document.querySelector('#usrPassword').style.background = 'green';
                document.querySelector('#updateUserPasswordSubmit').style.backGround = '#222222';
                document.querySelector('#updateUserPasswordSubmit').disabled = false;
            }
        }

        // 비밀번호 update 관련
        function updateUserPassword() {
            const keys = ['usrId', 'usrPassword'];
            const values = [document.querySelector('#usrId').value, document.querySelector('#usrPassword').value];
            // usrId=ninomiya&usrPassword=asdf
            const formData = makeFormData(keys, values); // pwUpdateSuccess로 돌아감
            console.log(formData);

            sendAjaxPost('updateUserPassword', formData, 'pwUpdateSuccess');
        }
        function pwUpdateSuccess(data) {
            console.log('ただいま');
            console.log(data);
            alert(data);
        }

        // updateUserInfo 수정 / 취소 / 변경
        accountSettingUserInfoModify = e => {
            if (e.classList.contains('infoModifyButton')) {
                document.querySelector('.userInfoButtons').children[0].style.display = 'none';
                document.querySelector('.userInfoButtons').children[1].style.display = 'block';
                document.querySelector('.userInfoButtons').children[2].style.display = 'block';

                document.querySelector('#usrLastname').readOnly = false;
                document.querySelector('#usrFirstname').readOnly = false;
                document.querySelector('#memBirthyear').readOnly = false;
                document.querySelector('#memBirthmonth').readOnly = false;
                document.querySelector('#memBirthday').readOnly = false;
                document.querySelector('#usrPhone').readOnly = false;
                document.querySelector('#usrEmail').readOnly = false;
                document.querySelector('#usrAddress').readOnly = false;
                document.querySelector('#memPostal').readOnly = false;
            } else {
                document.querySelector('.userInfoButtons').children[0].style.display = 'block';
                document.querySelector('.userInfoButtons').children[1].style.display = 'none';
                document.querySelector('.userInfoButtons').children[2].style.display = 'none';

                document.querySelector('#usrLastname').readOnly = true;
                document.querySelector('#usrLastname').value = userInfo.usrLastname;

                document.querySelector('#usrFirstname').readOnly = true;
                document.querySelector('#usrFirstname').value = userInfo.usrFirstname;

                document.querySelector('#memBirthyear').readOnly = true;
                document.querySelector('#memBirthyear').value = userInfo.memBirthday.substring(0, 4);

                document.querySelector('#memBirthmonth').readOnly = true;
                document.querySelector('#memBirthmonth').value = userInfo.memBirthday.substring(5, 7);

                document.querySelector('#memBirthday').readOnly = true;
                document.querySelector('#memBirthday').value = userInfo.memBirthday.substring(8, 10);

                document.querySelector('#usrPhone').readOnly = true;
                document.querySelector('#usrPhone').value = userInfo.usrPhone;

                document.querySelector('#usrEmail').readOnly = true;
                document.querySelector('#usrEmail').value = userInfo.usrEmail;

                document.querySelector('#usrAddress').readOnly = true;
                document.querySelector('#usrAddress').value = userInfo.usrAddress;

                document.querySelector('#memPostal').readOnly = true;
                document.querySelector('#memPostal').value = userInfo.memPostal;
            }
        };

        // updateUserInfo 업데이트 관련
        function updateUserInfo() {
            console.log(document.querySelector('#memBirthyear').value);
            console.log(document.querySelector('#memBirthmonth').value);
            console.log(document.querySelector('#memBirthday').value);

            console.log('..updateUserInfo');
            const keys = ['usrId', 'usrLastname', 'usrFirstname', 'usrPhone', 'usrEmail', 'usrAddress', 'memPostal', 'memGender', 'memBirthday'];
            const values = [document.querySelector('#usrId').value, document.querySelector('#usrLastname').value, document.querySelector('#usrFirstname').value, document.querySelector('#usrPhone').value, document.querySelector('#usrEmail').value, document.querySelector('#usrAddress').value, document.querySelector('#memPostal').value, Array.from(document.getElementsByName('memGender')).find(element => element.checked).value, document.querySelector('#memBirthyear').value + document.querySelector('#memBirthmonth').value + (document.querySelector('#memBirthday').value.length === 1 ? '0' + document.querySelector('#memBirthday').value : document.querySelector('#memBirthday').value)];
            // usrId=ninomiya&usrPassword=asdf
            const formData = makeFormData(keys, values); // usrInfoUpdateSuccess로 돌아감
            console.log(formData);

            sendAjaxPost('updateUserInfo', formData, 'usrInfoUpdateSuccess');
        }
        function usrInfoUpdateSuccess(data) {
            console.log('ただいま');
            console.log(data);
            alert(data);
            if (confirm('情報反映のため再ログインしてください。今再ログインしますか？')) {
                window.location.href = '/login';
            }
        }

        // img update관련
        window.onload = () => {
            if ('${newPath}' !== '') {
                document.body.innerHTML = `<img style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)" src="/res/img/Loading_icon.gif" />`;
                setTimeout(() => {
                    window.location.href = '/member/myPage/accountSetting';
                }, 5000);
            }
        };
    </script>
</html>
