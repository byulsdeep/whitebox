<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Insert title here</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <!-- NAVBAR CSS -->
        <link rel="stylesheet" href="/res/css/member/BI_signUp.css" />
        <link rel="stylesheet" href="/res/css/reset.css" />
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <link rel="stylesheet" href="/res/css/member/BI_signUp.css" />
        <link rel="stylesheet" href="/res/css/member/BI_myPage.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />
    </head>
    <body>
        <nav class="navbar"></nav>
        <script src="/res/js/member/navbar.js"></script>

        <main class="main_fri">
            <section class="section_left">
                <section class="section_profile">
                    <div class="my_profile_box">
                        <img class="my_profile_img" />
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
                    <div class="usrLastname"></div>
                    <div class="usrFirstname"></div>
                    様の照会リスト
                </div>
                <!-- 찜 목록 생성 공간 -->
                <div class="section_content_div1_viewHistory"></div>
                <!-- page -->
                <div class="pagination"></div>
                <!-- page끝 -->
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
        /* const usrImageFile = document.querySelector('#usrImageFile'); */

        console.log(userInfo);
        my_profile_img.src = userInfo.usrImage;

        /* if (userInfo.memIssocial === 'T') {
            usrImageFile.remove();
        } */

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

        //페이징
        const currentPage = Number('${param.currentPage}' === '' ? '1' : '${param.currentPage}');
        const pagination = document.querySelector('.pagination');
        const itemsPerPage = 9;
        let userViewHistoryCount;
        if ('${userViewHistoryCount}' !== '') {
            userViewHistoryCount = Number('${userViewHistoryCount}');
        }

        const pageCount = Math.ceil(userViewHistoryCount / itemsPerPage);

        //1페이지가 아닌 경우
        // 첫페이지
        if (currentPage > 1)
            pagination.innerHTML +=
                `
        <a class="first pagination page_button" href="/member/myPage/userViewHistory?currentPage=1&itemsPerPage=9">&lt;&lt;</a>
        <a class="prev pagination page_button" href="/member/myPage/userViewHistory?currentPage=` +
                (currentPage - 1) +
                `1&itemsPerPage=9">&lt;</a>
        `;

        // 중간
        for (let i = 0; i < pageCount; i++) {
            pagination.innerHTML +=
                `
            <a class="pagination page_button` +
                (i + 1 === currentPage ? ` current` : ``) +
                `" href="/member/myPage/userViewHistory?&currentPage=` +
                (i + 1) +
                `&itemsPerPage=9">` +
                (i + 1) +
                `</a>
            `;
        }
        // <a class="pagination current" href="#">2</a>

        // 마지막 페이지가 아닌 경우
        // pageCount = 전체 페이지 개수
        if (currentPage < pageCount)
            pagination.innerHTML +=
                `
        <a class="next pagination page_button" href="/member/myPage/userViewHistory?currentPage=` +
                (currentPage + 1) +
                `&itemsPerPage=9">&gt;</a> 
        <a class="last pagination page_button" href="/member/myPage/userViewHistory?currentPage=` +
                pageCount +
                `&itemsPerPage=9">&gt;&gt;</a>
        `;

        // wishList
        const section_content_div1_viewHistory = document.querySelector('.section_content_div1_viewHistory');

        let userViewHistoryByPage;

        // 유무 확인 if 문으로
        if ('${userViewHistoryByPage}' !== '') {
            userViewHistoryByPage = JSON.parse('${userViewHistoryByPage}');

            let html = ''; // String형 변수로 선언
            for (let i = 0; i < userViewHistoryByPage.length; i++) {
                html +=
                    `
                <div class="card_product1">
                        <a href="/product/` +
                    userViewHistoryByPage[i].vhsProusrselid +
                    `/ ` +
                    userViewHistoryByPage[i].vhsProcode +
                    `/">
                            <span class="wrap_thumb">
                                <img cuimg="" uselazyloading="" class="img_g" src="` +
                    (userViewHistoryByPage[i].productImage.length === 0 ? '/res/img/whitebox_logo_p.png' : userViewHistoryByPage[i].productImage[0].pigPath) +
                    `" />
                            </span>
                            <span class="wrap_info"> <strong> </strong></span></a
                        ><strong><a class="txt_brand">` +
                    userViewHistoryByPage[i].proName +
                    `</a> </strong>
                        <div>
                            <a class="txt_product">` +
                    userViewHistoryByPage[i].proInfo +
                    `</a>
                        </div>
                        <div class="txt_price">
                            <strong> ¥<span class="txt_yen">` +
                    userViewHistoryByPage[i].proPrice +
                    `</span> </strong>
                            <span class="txt_tax">税込</span>
                        </div>
                    </div>
                `;
            }
            section_content_div1_viewHistory.innerHTML = html; // 반복문으로 상품 불러온 것을 저장
        }

        console.log(userViewHistoryByPage);
        console.log(userViewHistoryCount);
    </script>
</html>
