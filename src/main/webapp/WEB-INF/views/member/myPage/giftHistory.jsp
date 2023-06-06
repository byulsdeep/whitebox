<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> -->
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>友達リスト</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- NAVBAR CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <!-- main CSS -->
        <link rel="stylesheet" href="/res/css/member/giftHistory.css" />
        <!-- notification CSS-->
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
    </head>
    <body>
        <nav class="navbar"></nav>
        <script src="/res/js/member/navbar.js"></script>
        <main class="main_fri">
            <section class="section_left">
                <section class="section_profile">
                    <div class="my_profile_box">
                        <img class="my_profile_img" src="/res/img/whitebox_logo_p.png" />
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
                            <a href="/member/myPage/friendList" style="font-size: 15.6px;">友達リスト</a>
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
                <div class="section_content_top">ギフトボックス</div>
                <div class="section_content_present_list">
                    <div class="received_list_wrap">
                        <div class="received_list_title">届いたプレゼント</div>
                        <div class="received_list"></div>
                    </div>
                    <div class="sent_list_wrap">
                        <div class="sent_list_title">送ったプレゼント</div>
                        <div class="sent_list"></div>
                    </div>
                    <div class="self_list_wrap">
                        <div class="self_list_title">自分にしたプレゼント</div>
                        <div class="self_list"></div>
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
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/member/footer.js"></script>
    </body>
    <script src="/res/js/projectUtils.js"></script>
    <script>
        let userInfo;
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            changeNavbar(userInfo);
            document.querySelector('.my_profile_img').src = userInfo.usrImage;
            document.querySelector('.my_profile_name').innerText = userInfo.usrLastname + userInfo.usrFirstname;
        }
        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }
        let sentGiftList, receivedGiftList, selfGiftList;
        if ('${sentGiftList}' !== '') {
            sentGiftList = JSON.parse('${sentGiftList}');
        }
        if ('${receivedGiftList}' !== '') {
            receivedGiftList = JSON.parse('${receivedGiftList}');
        }
        if ('${selfGiftList}' !== '') {
            selfGiftList = JSON.parse('${selfGiftList}');
        }
        console.log(receivedGiftList);
        console.log(sentGiftList);
        console.log(selfGiftList);

        const received_list = document.querySelector('.received_list');
        const sent_list = document.querySelector('.sent_list');
        const self_list = document.querySelector('.self_list');

        if (receivedGiftList !== undefined && receivedGiftList.length > 0) {
            received_list.innerHTML = makeGiftList(receivedGiftList);
        }
        if (sentGiftList !== undefined && sentGiftList.length > 0) {
            sent_list.innerHTML = makeGiftList(sentGiftList);
        }
        if (selfGiftList !== undefined && selfGiftList.length > 0) {
            self_list.innerHTML = makeGiftList(selfGiftList);
        }
        function makeGiftList(list) {
            let html = '';
            list.forEach(gift => {
                html +=
                    `
                        <div class="card_product">
                            <span class="wrap_thumb">
                                <img cuimg="" uselazyloading="" class="img_g" src="` + (gift.productImage.length !== 0 ? gift.productImage[0].pigPath : '/res/img/whitebox_logo_p.png') + `" onerror="loadAlternateImage(this)" />
                            </span>
                            <span class="wrap_info"> <strong> </strong></span><strong><a class="txt_brand">` + gift.proName + `</a> </strong>
                            <div>
                                <a class="txt_product">` + gift.proInfo + `</a>
                            </div>
                            <div><a class="txt_product">` + (
                                        gift.odtOrdmemid !== userInfo.usrId && gift.odtMemrecipient === userInfo.usrId 
                                        ?                       
                                        'FROM. ' + gift.usrLastname + ' ' + gift.usrFirstname
                                        :
                                        gift.odtOrdmemid === userInfo.usrId && gift.odtMemrecipient !== userInfo.usrId
                                        ?
                                        'TO. ' + gift.usrLastname + ' ' + gift.usrFirstname
                                        :
                                        ''
                                ) + `</a></div>
                            <div>` + new Date(gift.odtOrddate).toLocaleString() + `</div>
                        </div>
                    `;
            });
            return html;
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

        // profile user image 변동
        function previewUsrImage() {
            console.log(usrImageFile.files[0]);
            const reader = new FileReader();
            reader.onload = () => (usrImage.src = reader.result);
            reader.readAsDataURL(usrImageFile.files[0]);
        }
    </script>
</html>
