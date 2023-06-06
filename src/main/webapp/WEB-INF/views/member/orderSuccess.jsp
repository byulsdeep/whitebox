<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Document</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <!-- main CSS -->
        <link rel="stylesheet" href="/res/css/member/orderSuccess.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>
        <div class="main">
            <h1>注文が完了しました</h1>
            <a href="/member/myPage/orderHistory">注文目録へ</a>
            <a href="/">WhiteBoxへ戻る</a>
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
    </script>
</html>
