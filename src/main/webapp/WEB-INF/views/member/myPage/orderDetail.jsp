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
        <link rel="stylesheet" href="/res/css/member/BI_myPage.css" />
        <link rel="stylesheet" href="/res/css/member/yeong_myPage.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />

        <link rel="stylesheet" href="/res/css/member/footer.css" />
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
                        <div class="my_profile_name"></div>
                        <div class="my_profile_list">
                            <a href="">情報修正</a>
                        </div>
                    </div>
                    <div class="my_profile">
                        <div class="my_profile_list">
                            <a href="">友達リスト</a>
                        </div>
                        <div class="my_profile_list">
                            <a href="">友達要請</a>
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
                    <div id="orderTitle" class="order_list_title">注文詳細</div>
                    <div class="order_list_top"></div>
                    <div id="orderList" class="order_list_bottom"></div>
                    <div class="order_detail_total">
                        <p>
                            合計：￥
                            <span>12,445</span>
                            税込
                        </p>
                    </div>
                </div>
            </section>
        </main>
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
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            changeNavbar(userInfo);
            document.querySelector('.my_profile_img').src = userInfo.usrImage;
            document.querySelector('.my_profile_name').innerText = userInfo.usrLastname + userInfo.usrFirstname;
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
        let orderDetailList;
        let total = 0;
        if ('${orderDetailList}' !== '') {
            orderDetailList = JSON.parse('${orderDetailList}');
            document.querySelector('#orderTitle').innerText = '注文詳細（${orderData.ordDate}${orderData.ordOststate}）';
        }
        console.log('--');
        console.log(orderDetailList);

        let getOrderList = () => {
            let orderList = '';
            orderDetailList.forEach((e, i) => {
                orderList += '<div class="order_list_item"><div class="order_list_item_top"><div class="order_list_item_top_left"><p>';
                orderList += e.odtMemrecipient;
                orderList += '</p></div></div><a href="';
                orderList += '/product/' + e.proUsrselid + '/' + e.odtProcode;
                orderList += '"><div class="order_list_item_bottom"><div class="order_list_item_bottom_left"><img src="';
                if (e.productImage != null) {
                    e.productImage.forEach((e, i) => {
                        e.pigIsthumbnail == 'T' ? (orderList += e.pigPath) : (orderList += '');
                    });
                }
                orderList += '" alt=""></div><div class="order_list_item_bottom_right"><div class="order_list_item_bottom_right_brand">';
                orderList += e.selShopname;
                orderList += '</div><div class="order_list_item_bottom_right_title">';
                orderList += e.proName;
                orderList += '</div><div class="order_list_item_bottom_right_bottom"><div class="order_list_item_bottom_right_bottom_price">';
                orderList += e.proPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',');
                orderList += '</div><div class="order_list_item_bottom_right_bottom_qty">';
                orderList += e.odtQty;
                orderList += '</div></div></div></a></div></div>';

                total += e.proPrice * e.odtQty;
            });
            document.querySelector('#orderList').innerHTML = orderList;
            document.querySelector('.order_detail_total p span').innerHTML = total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',');
        };

        getOrderList();
    </script>
</html>
