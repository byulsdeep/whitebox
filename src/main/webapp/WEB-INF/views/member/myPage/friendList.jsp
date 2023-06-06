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
        <link rel="stylesheet" href="/res/css/member/friendList.css" />
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
                    <div class="section_content_top_search_box_wrap">
                        <div>友達の名前</div>
                        <input id="search_box" onkeypress="if(event.keyCode === 13) { makeFriendList(); }" />
                        <i onclick="makeFriendList()" class="fa-solid fa-magnifying-glass" style="color: #161616"></i>
                    </div>
                </div>
                <div class="section_content_friend_list"></div>
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
            // userInfo = JSON.parse('{"usrId":"member","usrPassword":"$2a$10$WadIvd6ItpB2qGWHpsOroejjD9l4olEpz5YwB8.NQpff624Ik11N.","usrEnabled":1,"usrLastname":"lQ8RbwSmbapX+3OvyeCuWg\u003d\u003d","usrFirstname":"9NEOH9994+21fSPCeRqSFQ\u003d\u003d","usrPhone":"2400","usrEmail":"whitebox-japan@outlook.com","usrAddress":"my home dude","usrImage":"/res/img/usrImg/member/IMG_6816.jpg","usrDate":"2023-05-12","authorities":[{"autUsrid":"member","autAuthority":"ROLE_MEMBER"}],"memPostal":"2400","memGender":"M","memBirthday":"1999-01-01","isDecoded":true,"memIssocial":"F"}');
        }
        if (userInfo !== undefined) {
            changeNavbar(userInfo);
        }
        document.querySelector('.my_profile_img').src = userInfo.usrImage;
        document.querySelector('.my_profile_name').innerText = userInfo.usrLastname + userInfo.usrFirstname;
        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }
        let friendList;
        if ('${friendList}' !== '') {
            friendList = JSON.parse('${friendList}');
            // friendList = JSON.parse('[{"friendId":"member4","friDate":"2023-05-22 02:10:37","usrEnabled":0,"usrLastname":"Member","usrFirstname":"Four","usrImage":"/res/img/whitebox_logo_p.png","memGender":"M","memBirthday":"1994-01-01 00:00:00","isDecoded":false},{"friendId":"member5","friDate":"2023-05-22 02:10:38","usrEnabled":0,"usrLastname":"Member","usrFirstname":"Five","usrImage":"/res/img/whitebox_logo_p.png","memGender":"M","memBirthday":"1994-01-01 00:00:00","isDecoded":false}]');
        }
        console.log(friendList);
        const section_content_friend_list = document.querySelector('.section_content_friend_list');

        makeFriendList();

        function makeFriendList() {
            const search_box = document.querySelector('#search_box');
            console.log('making friend list');
            let html = '';
            friendList.forEach(friend => {
                if ((friend.usrLastname + friend.usrFirstname).toUpperCase().includes(search_box.value.toUpperCase()) || (friend.usrFirstname + friend.usrLastname).toUpperCase().includes(search_box.value.toUpperCase()) || (friend.usrFirstname + ' ' + friend.usrLastname).toUpperCase().includes(search_box.value.toUpperCase()) || (friend.usrLastname + ' ' + friend.usrFirstname).toUpperCase().includes(search_box.value.toUpperCase())) {
                    html +=
                        `
                                <div class="friend_div">
                                    <div class="friend_profile_wrap">
                                        <div class="friend_profile_image_wrap">
                                            <img class="friend_profile_image" src="` +
                        friend.usrImage +
                        `" onclick="showImage('` +
                        friend.usrImage +
                        `')" />
                                        </div>
                                        <div class="friend_profile_name">` +
                        friend.usrLastname +
                        ` ` +
                        friend.usrFirstname +
                        `</div>
                                        <div class="result_type">(` +
                        friend.friDate.substring(0, 4) +
                        `年` +
                        friend.friDate.substring(5, 7) +
                        `月` +
                        friend.friDate.substring(8, 10) +
                        `日からフレンド)</div>
                                    </div>
                                    <div class="friend_buttons_wrap">
                                        <a class="friend_button" href="/member/myPage/friendWishList?friendId=` +
                        friend.friendId +
                        `">ウィッシュリスト</a>
                                        <a class="friend_button" href="/" >プレゼントする</a>
                                        <a class="friend_button" onclick="deleteFriend('` +
                        friend.friendId +
                        `')">縁を切る</a>
                                    </div>
                                </div>
                        `;
                }
            });
            section_content_friend_list.innerHTML = html;
        }

        let friendToDelete;
        function deleteFriend(friendId) {
            if (confirm('本当に縁を切るんですか？！')) {
                friendToDelete = friendId;
                sendAjaxPost('/member/myPage/deleteFriend/', 'friendId=' + friendId, 'deleteFriendCallBack');
            }
        }
        function deleteFriendCallBack(success) {
            console.log(success);
            if (success) {
                friendList = friendList.filter(friend => friend.friendId !== friendToDelete);
                makeFriendList();
            }
        }
        function showImage(source) {
            document.querySelector('.image_modal').style.display = 'block';
            document.querySelector('#image_modal_image').src = source;
        }
        function closeModal() {
            console.log('cllicked');
            document.querySelector('.image_modal').style.display = 'none';
        }
    </script>
</html>
