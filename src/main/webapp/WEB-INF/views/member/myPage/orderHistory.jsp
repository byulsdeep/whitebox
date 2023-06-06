<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <!-- jQuery 라이브러리 -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Slick 라이브러리 -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- NAVBAR CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <link rel="stylesheet" href="/res/css/member/BI_myPage.css" />
        <link rel="stylesheet" href="/res/css/member/yeong_myPage.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />

        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>マイページ</title>
    </head>
    <body>
        <nav class="navbar"></nav>
        <script src="/res/js/member/navbar.js"></script>
        <main class="main_fri">
            <section class="section_left">
                <section class="section_profile">
                    <div class="my_profile_box">
                        <img class="my_profile_img" src="/res/img/BI/nino.jpg" />
                    </div>
                    <div class="my_profile">
                        <div class="my_profile_name">
                            <div class="usrLastname"></div>
                            <div class="usrFirstname"></div>
                        </div>
                        <div class="my_profile_list">
                            <a href="">情報修正</a>
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
                <div class="order_list_wrap">
                    <div class="order_list_title">注文内訳</div>
                    <div class="order_list_top">
                        <div class="order_list_top_left">
                            <input type="date" id="orderDateStart" class="order_list_top_right_search" onchange="getOrderList()" />
                            ~
                            <input type="date" id="orderDateEnd" class="order_list_top_right_search" onchange="getOrderList()" />
                        </div>
                        <div class="order_list_top_right">
                            <div class="order_list_top_right_button" onclick="setDateRange(1)">1ヵ月</div>
                            <div class="order_list_top_right_button" onclick="setDateRange(3)">3ヵ月</div>
                            <div class="order_list_top_right_button" onclick="setDateRange(6)">6ヵ月</div>
                            <div class="order_list_top_right_button" onclick="setDateRange(12)">12ヵ月</div>
                            <div class="order_list_top_right_button" onclick="setDateRange()">すべて</div>
                        </div>
                    </div>
                    <div id="orderList" class="order_list_bottom"></div>
                </div>
            </section>
        </main>
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
        let filterUsrmemid = '';
        let filterStartDate = '1900-01-01';
        let filterEndDate = '2099-12-31';

        let orderList = '';
        let today = new Date();

        let userInfo;

        const main = document.querySelector('.main');
        const my_profile_img = document.querySelector('.my_profile_img');
        const usrImageFile = document.querySelector('#usrImageFile');

        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            my_profile_img.src = userInfo.usrImage;
        }
        //nav 로그인 버튼 로그아웃으로 변경
        const loginButton = document.querySelector('.login');
        loginButton.children[0].innerText = 'ログオフ';
        loginButton.children[0].href = '/logout';
        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }


        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            filterUsrmemid = userInfo.usrId;
        }
        if (userInfo !== undefined && userInfo !== null) {
            changeNavbar(userInfo);
        }

        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            // notificationInfo = JSON.parse('[]');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }


        window.onload = function () {
            getOrderList();
        };

        let openReviewForm = e => {
            let reviewForm = e.parentNode.parentNode.parentNode.querySelector('.order_list_item_review');
            reviewForm.style.display = reviewForm.style.display == 'block' ? 'none' : 'block';
        };

        function drawStar(e) {
            e.parentNode.querySelector('.star span').style.width = e.value * 10 + '%';
        }

        let checkScore = e => {
            if (e.parentNode.querySelector('input').value == 0) {
                alert('評点を付けてください。');
            } else {
                console.log(e.parentNode.querySelector('input').value + ' rest');
                console.log(document.querySelector('#dateStart').value);
                console.log(document.querySelector('#dateEnd').value);
            }
        };

        let setDateRange = e => {
            document.querySelector('#orderDateStart').value = 1 > today.getMonth() + 1 - e ? today.getFullYear() - 1 + '-' + ('0' + (today.getMonth() + 1 + (12 - e))).slice(-2) + '-' + ('0' + today.getDate()).slice(-2) : today.getFullYear() + '-' + ('0' + (today.getMonth() + 1 - e)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
            document.querySelector('#orderDateEnd').value = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);

            if (e == null) {
                document.querySelector('#orderDateStart').value = '';
                document.querySelector('#orderDateEnd').value = '';
            }
            filterStartDate = document.querySelector('#orderDateStart').value;
            filterEndDate = document.querySelector('#orderDateEnd').value;
            getOrderList();
        };

        let getOrderList = () => {
            console.log('getOrderList');
            fetch('http://localhost/mypage/orders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    filterUsrmemid: filterUsrmemid,
                    filterStartDate: filterStartDate,
                    filterEndDate: filterEndDate,
                }),
            })
                .then(response => {
                    if (response.ok) {
                        const clonedResponse = response.clone();
                        return response.json().catch(() => clonedResponse.text());
                    } else {
                        throw new Error('Network response was not ok.');
                    }
                })
                .then(data => {
                    console.log(data);
                    let orderList = '';
                    if (data != null) {
                        data.forEach((e, i) => {
                            orderList += "<div class='order_list_item'><div class='order_list_item_top'><div><p>";
                            orderList += ' ';
                            orderList += "</p></div><div class='order_list_item_top_right'><a href='";
                            orderList += '/member/myPage/order/' + e.ordUsrmemid + '/' + e.ordDate;
                            orderList += "'>注文詳細</a></div></div><a href='";
                            orderList += '/product/' + e.proUsrselid + '/' + e.proCode;
                            orderList += "' class='order_list_item_bottom'><div class='order_list_item_bottom_left'><img src='";
                            orderList += e.productImage[0]?.pigPath !== undefined ? e.productImage[0].pigPath : '/res/img/whitebox_logo_p.png';
                            orderList += "' alt=''></div><div class='order_list_item_bottom_right'><div class='order_list_item_bottom_right_brand'>";
                            orderList += e.proUsrselid;
                            orderList += "</div><div class='order_list_item_bottom_right_title'>";
                            orderList += e.proName;
                            orderList += "</div><div class='order_list_item_bottom_right_bottom'><div class='order_list_item_bottom_right_bottom_price'>";
                            orderList += e.proPrice;
                            orderList += "</div><div class='order_list_item_bottom_right_bottom_qty'>";
                            orderList += e.ordQty;
                            orderList += '</div></div></div></a></div>';
                        });
                    }
                    document.querySelector('#orderList').innerHTML = orderList;
                });
        };
        // profile user 이름 변동
        UserName = () => {
            const lastnameElement = document.querySelectorAll('.usrLastname');
            const firstnameElement = document.querySelectorAll('.usrFirstname');

            lastnameElement.forEach(profile => (profile.textContent = userInfo.usrLastname));
            firstnameElement.forEach(profile => (profile.textContent = userInfo.usrFirstname));
        };
        UserName();
        console.log(userInfo);
    </script>
</html>
