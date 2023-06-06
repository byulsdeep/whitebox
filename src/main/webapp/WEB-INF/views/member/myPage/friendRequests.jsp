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
        <link rel="stylesheet" href="/res/css/member/friendRequests.css" />
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
                    <div class="section_content_top_filter_wrap">
                        <div id="sent_requests_button" class="section_content_top_filter" onclick="toggleRequests(this)">送ったリクエスト</div>
                        <div id="received_requests_button" class="section_content_top_filter" onclick="toggleRequests(this)">届いたリクエスト</div>
                    </div>
                    <div class="section_content_top_search_box_wrap">
                        <div>友達の名前</div>
                        <input id="search_box" onkeypress="if(event.keyCode === 13) { window.location.href = '/member/myPage/friendRequests?query=' + encodeURIComponent(this.value) }" />
                        <i onclick="window.location.href = '/member/myPage/friendRequests?query=' + encodeURIComponent(document.querySelector('#search_box').value)" class="fa-solid fa-magnifying-glass" style="color: #161616"></i>
                    </div>
                </div>
                <div class="no_search_result"></div>
                <div class="section_content_friend_list"></div>
            </section>
        </main>
        <!-- image modal -->
        <div class="image_modal" onclick="closeModal()">
            <div class="image_modal_content">
                <img id="image_modal_image" />
            </div>
        </div>
        <!-- notification modal-->
        <div class="notification_modal">
            <div class="notification_modal_top">
                <div class="notification_modal_close_button" onclick="toggleNotification()"><i class="fa-solid fa-xmark"></i></div>
            </div>
            <div class="notification_modal_content">
                <div class="notification_modal_feed">
                    <div class="notification_modal_message_wrap">
                        <div class="notification_modal_profile_image_wrap">
                            <img class="notification_modal_profile_image" src="/res/img/whitebox_logo_p.png"/>
                        </div>
                        <div class="notification_modal_message">
                            White Boxへようこそ
                        </div>
                    </div>
                </div>
            </div>
            <div class="notification_modal_return_button" onclick="toggleNotification()">戻る</div>
        </div>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/member/footer.js"></script>
    </body>
    <script src='/res/js/projectUtils.js'></script>
    <script>
        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }
     	let acceptMessage;
        if ('${acceptMessage}' !== '') {
            acceptMessage = JSON.parse('${acceptMessage}');
            alert(acceptMessage.usrLastname + ' ' + acceptMessage.usrFirstname + 'さんと友達になりました！');
        }
        let declineMessage;
        if ('${declineMessage}' !== '') {
            alert('${declineMessage}');
        }
        let requestMessage;
        if ('${requestMessage}' !== '') {
            requestMessage = JSON.parse('${requestMessage}');
            alert(requestMessage.usrLastname + ' ' + requestMessage.usrFirstname + 'さんにフレンドリクエストを送りました！');
        }  
        let userInfo;
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
        }
        // userInfo = JSON.parse('{"usrId":"member","usrPassword":"$2a$10$hXLGBFCtbW2cmOr2kbeLSe6S80vwHPZ/70y0rcXsvi2QpR2uCtu9W","usrEnabled":1,"usrLastname":"member","usrFirstname":"man","usrPhone":"5515","usrEmail":"whitebox-japan@outlook.com","usrAddress":"5 63","usrImage":"/res/img/whitebox_logo_p.png","usrDate":"2023-05-17","authorities":[{"autUsrid":"member","autAuthority":"ROLE_MEMBER"}],"memPostal":"54","memGender":"F","memBirthday":"1994-01-02","isDecoded":true,"memIssocial":"F"}');
        if (userInfo !== undefined) {
            changeNavbar(userInfo);
        }
        document.querySelector('.my_profile_img').src = userInfo.usrImage;
        document.querySelector('.my_profile_name').innerText = userInfo.usrLastname + userInfo.usrFirstname;

        let friendRequests;
        if ('${friendRequests}' !== '') {
            friendRequests = JSON.parse('${friendRequests}');
        }
            // friendRequests = JSON.parse('[{"friSender":"member","friReceiver":"member2","friState":"FS","friDate":"2023-05-21 20:34:11","usrEnabled":0,"usrLastname":"Member","usrFirstname":"Two","usrImage":"/res/img/whitebox_logo_p.png","isDecoded":false},{"friSender":"member","friReceiver":"member4","friState":"FC","friDate":"2023-05-21 20:34:19","usrEnabled":0,"usrLastname":"Member","usrFirstname":"Four","usrImage":"/res/img/whitebox_logo_p.png","isDecoded":false},{"friSender":"member3","friReceiver":"member","friState":"FS","friDate":"2023-05-21 20:34:27","usrEnabled":0,"usrLastname":"Member","usrFirstname":"Three","usrImage":"/res/img/whitebox_logo_p.png","isDecoded":false},{"friSender":"member5","friReceiver":"member","friState":"FA","friDate":"2023-05-21 20:34:20","usrEnabled":0,"usrLastname":"Member","usrFirstname":"Five","usrImage":"/res/img/whitebox_logo_p.png","isDecoded":false},{"usrEnabled":0,"usrLastname":"Member","usrFirstname":"Six","usrImage":"/res/img/whitebox_logo_p.png","isDecoded":false}]');
        // console.log(friendRequests);
        const section_content_friend_list = document.querySelector('.section_content_friend_list');

        makeList('received');
        makeList('searched');
        makeList('sent');

        document.querySelector('#search_box').focus();

        const sent = document.querySelectorAll('.sent');
        const received = document.querySelectorAll('.received');
        const searched = document.querySelectorAll('.searched, .already_friend');

        if ('${param.query}' !== '' && searched.length === 0) {
            toggleElements(received, false);
            toggleElements(sent, false);
            document.querySelector('.no_search_result').innerText = '結果がありません';
        }
        
        let sentRequestsCount = 0;
        let receivedRequestsCount = 0;

        function toggleRequests(object) {
            object.style.backgroundColor = object.style.backgroundColor === '' ? 'lightgrey' : '';

            if (object.id === 'sent_requests_button') {
                if (sentRequestsCount++ % 2 === 0) {
                    toggleElements(sent, true);
                    toggleElements(received, false);
                } else {
                    toggleElements(sent, false);
                    toggleElements(received, true);
                }
            } else if (object.id === 'received_requests_button') {
                if (receivedRequestsCount++ % 2 === 0) {
                    toggleElements(received, true);
                    toggleElements(sent, false);
                } else {
                    toggleElements(received, false);
                    toggleElements(sent, true);
                }
            }

            if ('${param.query}' !== '' && searched.length === 0 && sentRequestsCount % 2 === 0 && receivedRequestsCount % 2 === 0) {
                toggleElements(received, false);
                toggleElements(sent, false);
            } else if(sentRequestsCount % 2 === 0 && receivedRequestsCount % 2 === 0) {
                toggleElements(searched, true);
                toggleElements(sent, true);
                toggleElements(received, true);
            } else if (sentRequestsCount % 2 !== 0 && receivedRequestsCount % 2 !== 0) {
                toggleElements(searched, false);
                toggleElements(sent, true);
                toggleElements(received, true);
            } else {
                toggleElements(searched, false);
            }
        }

        function toggleElements(elements, isVisible) {
            
            elements.forEach(element => {
                element.style.display = isVisible ? 'flex' : 'none';
            });
        }

        function makeList(whatKindOfList) {
            let html = '';
            switch (whatKindOfList) {
                case 'received':
                    friendRequests.forEach(friend => {
                        if (friend.friReceiver === userInfo.usrId && friend.friState === 'FS') {
                            html += `
                                <div class="friend_div received">
                                    <div class="friend_profile_wrap">
                                        <div class="friend_profile_image_wrap">
                                            <img class="friend_profile_image" src="` + friend.usrImage + `" onclick="showImage('` + friend.usrImage + `')" />
                                        </div>
                                        <div class="friend_profile_name">` + friend.usrLastname + ` ` + friend.usrFirstname + `</div>
                                        <div class="result_type">さんからフレンドリクエストが届きました！</div>
                                    </div>
                                    <div class="friend_buttons_wrap">
                                        <a class="friend_button" href="/member/myPage/acceptRequest?friSender=` + friend.friSender + `&friReceiver=` + friend.friReceiver+ `&usrLastname=` + friend.usrLastname + `&usrFirstname=` + friend.usrFirstname + `">承諾</a>
                                        <a class="friend_button" href="/member/myPage/declineRequest?friSender=` + friend.friSender + `&friReceiver=` + friend.friReceiver + `">拒否</a>
                                    </div>
                                </div>                   
                            `;
                        }
                    });
                    section_content_friend_list.innerHTML += html;
                    break;
                case 'sent':
                    friendRequests.forEach(friend => {
                        if (friend.friSender === userInfo.usrId && friend.friState === 'FS') {
                            html += `
                                <div class="friend_div sent">
                                    <div class="friend_profile_wrap">
                                        <div class="friend_profile_image_wrap">
                                            <img class="friend_profile_image" src="` + friend.usrImage + `" onclick="showImage('` + friend.usrImage + `')" />
                                        </div>
                                        <div class="friend_profile_name">` + friend.usrLastname + ` ` + friend.usrFirstname + `</div>
                                        <div class="result_type">さんにフレンドリクエストを送りました！</div>
                                    </div>
                                    <div class="friend_buttons_wrap">
                                        <a class="friend_button">承諾待機中</a>
                                    </div>
                                </div>                
                            `;
                        }
                    });
                    section_content_friend_list.innerHTML += html;
                    break;
                case 'searched':
                    friendRequests.forEach(friend => {
                        if (friend.friState === 'FA' || friend.friState === 'FC') {
                            html += `
                                <div class="friend_div already_friend"> 
                                    <div class="friend_profile_wrap">
                                        <div class="friend_profile_image_wrap">
                                            <img class="friend_profile_image" src="` + friend.usrImage + `" onclick="showImage('` + friend.usrImage + `')" />
                                        </div>
                                        <div class="friend_profile_name">` + friend.usrLastname + ` ` + friend.usrFirstname + `</div>
                                        <div class="result_type">(` + friend.friDate.substring(0, 4) + `年` + friend.friDate.substring(5, 7) + `月` + friend.friDate.substring(8, 10) + `日からフレンド)</div>
                                    </div>
                                    <div class="friend_buttons_wrap">
                                        <a class="friend_button">フレンド ✔</a>
                                    </div>
                                </div>                   
                            `;
                        } else if (friend.friState === undefined || friend.friState === null) {
                            html += `
                                <div class="friend_div searched">
                                    <div class="friend_profile_wrap">
                                        <div class="friend_profile_image_wrap">
                                            <img class="friend_profile_image" src="` + friend.usrImage + `" onclick="showImage('` + friend.usrImage + `')" />
                                        </div>
                                        <div class="friend_profile_name">` + friend.usrLastname + ` ` + friend.usrFirstname + `</div>
                                        <div class="result_type">さんとフレンドになろう！</div>
                                    </div>
                                    <div class="friend_buttons_wrap">
                                        <a class="friend_button" href="/member/myPage/sendRequest?myId=` + userInfo.usrId + `&friendId=` + friend.friendId + `&usrLastname=` + friend.usrLastname + `&usrFirstname=` + friend.usrFirstname + `">フレンド 追加</a>
                                    </div>
                                </div>                                
                            `;
                        }
                    });
                    section_content_friend_list.innerHTML += html;                    
                    break;
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
