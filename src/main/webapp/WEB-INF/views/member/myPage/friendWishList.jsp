<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <link rel="stylesheet" href="/res/css/member/friendWishList.css" />
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
                        <div class="my_profile_name">二宮和也</div>
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
                <div class="section_content_top">
                    <div class="friend_profile_wrap">
                        <div class="friend_profile_image_wrap">
                            <img class="friend_profile_image" src="/res/img/whitebox_logo_p.png" />
                        </div>
                        <h1 class="friend_profile_title"></h1>
                    </div>
                </div>
                <div class="section_content_friend_wish_list"></div>
            </section>
        </main>
        <!-- image modal -->
        <div class="image_modal" onclick="closeModal()">
            <div class="image_modal_content">
                <img id="image_modal_image" />
            </div>
        </div>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/member/footer.js"></script>
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
        let userInfo;
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            // userInfo = JSON.parse('{"usrId":"member","usrPassword":"$2a$10$hXLGBFCtbW2cmOr2kbeLSe6S80vwHPZ/70y0rcXsvi2QpR2uCtu9W","usrEnabled":1,"usrLastname":"member","usrFirstname":"man","usrPhone":"5515","usrEmail":"whitebox-japan@outlook.com","usrAddress":"5 63","usrImage":"/res/img/whitebox_logo_p.png","usrDate":"2023-05-17","authorities":[{"autUsrid":"member","autAuthority":"ROLE_MEMBER"}],"memPostal":"54","memGender":"F","memBirthday":"1994-01-02","isDecoded":true,"memIssocial":"F"}');
        }
        if (userInfo !== undefined) {
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
        document.querySelector('.my_profile_img').src = userInfo.usrImage;
        document.querySelector('.my_profile_name').innerText = userInfo.usrLastname + userInfo.usrFirstname;

        const friend_profile_image = document.querySelector('.friend_profile_image');
        const friend_profile_title = document.querySelector('.friend_profile_title');

        let friendInfo;
        if ('${friendInfo}' !== '') {
            friendInfo = JSON.parse('${friendInfo}');
            console.log(friendInfo);

            friend_profile_image.src = friendInfo.usrImage;
            friend_profile_title.innerText = friendInfo.usrLastname + ' ' + friendInfo.usrFirstname + 'さんのウィッシュリスト';
        }

        const section_content_friend_wish_list = document.querySelector('.section_content_friend_wish_list');

        let friendWishList;
        if ('${friendWishList}' !== '') {
            friendWishList = JSON.parse('${friendWishList}');
            console.log(friendWishList);

            let html = '';
            friendWishList.forEach(item => {
                html +=
                    `
                    <a href="/product/` +
                    item.vhsProusrselid +
                    `/` +
                    item.vhsProcode +
                    `/">
                        <div class="card_product">
                            <span class="wrap_thumb">
                                <img cuimg="" uselazyloading="" class="img_g" src="` +
                    item.productImage.find(pig => pig.pigIsthumbnail === 'T').pigPath +
                    `" />
                            </span>
                            <span class="wrap_info">
                                <strong>
                                    <a class="txt_brand">` +
                    item.proName +
                    `</a>
                                </strong>
                                <div>
                                    <a class="txt_product">` +
                    item.proInfo +
                    `</a>
                                </div>
                                <div class="txt_price">
                                    <strong>
                                        ¥<span class="txt_yen">` +
                    item.proPrice.toLocaleString() +
                    `</span>
                                    </strong>
                                    <span class="txt_tax">税込</span>
                                </div>
                            </span>
                        </div>
                    </a>
                `;
            });
            section_content_friend_wish_list.innerHTML = html;
        }
    </script>
</html>
