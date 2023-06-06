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
                    様の欲しいものリスト
                </div>
                <!-- 위시 목록 생성 공간 -->
                <div class="section_content_div1_wishList"></div>
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
            // notificationInfo = JSON.parse('[]');
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
        let userWishListCount;
        if ('${userWishListCount}' !== '') {
            userWishListCount = Number('${userWishListCount}');
            // userWishListCount = Number('12');
        }

        const pageCount = Math.ceil(userWishListCount / itemsPerPage);

        //1페이지가 아닌 경우
        // 첫페이지
        if (currentPage > 1)
            pagination.innerHTML +=
                `
        <a class="first pagination page_button" href="/member/myPage/userWishList?currentPage=1&itemsPerPage=9">&lt;&lt;</a>
        <a class="prev pagination page_button" href="/member/myPage/userWishList?currentPage=` +
                (currentPage - 1) +
                `1&itemsPerPage=9">&lt;</a>
        `;

        // 중간
        for (let i = 0; i < pageCount; i++) {
            pagination.innerHTML +=
                `
            <a class="pagination page_button` +
                (i + 1 === currentPage ? ` current` : ``) +
                `" href="/member/myPage/userWishList?&currentPage=` +
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
        <a class="next pagination page_button" href="/member/myPage/userWishList?currentPage=` +
                (currentPage + 1) +
                `&itemsPerPage=9">&gt;</a> 
        <a class="last pagination page_button" href="/member/myPage/userWishList?currentPage=` +
                pageCount +
                `&itemsPerPage=9">&gt;&gt;</a>
        `;

        // wishList
        const section_content_div1_wishList = document.querySelector('.section_content_div1_wishList');

        let userWishListByPage;

        // 유무 확인 if 문으로
        if ('${userWishListByPage}' !== '') {
            userWishListByPage = JSON.parse('${userWishListByPage}');
            // userWishListByPage = JSON.parse('[{"vhsProusrselid":"testmart","vhsProcode":"12","vhsDate":"2023-05-24 03:59:12","proName":"우산","proPrice":1750,"proStock":0,"proInfo":"비","productImage":[{"pigProusrselid":"testmart","pigProcode":"12","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"9","vhsDate":"2023-05-24 03:31:11","proName":"셔츠","proPrice":1750,"proStock":0,"proInfo":"셔츠입니다","productImage":[{"pigProusrselid":"testmart","pigProcode":"9","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"11","vhsDate":"2023-05-24 03:31:11","proName":"지갑","proPrice":750,"proStock":0,"proInfo":"사이후","productImage":[{"pigProusrselid":"testmart","pigProcode":"11","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"10","vhsDate":"2023-05-24 03:31:11","proName":"옷","proPrice":1250,"proStock":0,"proInfo":"옷이다","productImage":[{"pigProusrselid":"testmart","pigProcode":"10","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"5","vhsDate":"2023-05-24 03:21:43","proName":"1달러","proPrice":110,"proStock":0,"proInfo":"달러","productImage":[{"pigProusrselid":"testmart","pigProcode":"5","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"8","vhsDate":"2023-05-24 03:21:43","proName":"양말","proPrice":750,"proStock":0,"proInfo":"메에에","productImage":[{"pigProusrselid":"testmart","pigProcode":"8","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"7","vhsDate":"2023-05-24 03:21:43","proName":"모자","proPrice":9050,"proStock":0,"proInfo":"엄마와 아들","productImage":[{"pigProusrselid":"testmart","pigProcode":"7","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"6","vhsDate":"2023-05-24 03:21:43","proName":"가방","proPrice":2750,"proStock":0,"proInfo":"가방이다","productImage":[{"pigProusrselid":"testmart","pigProcode":"6","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10},{"vhsProusrselid":"testmart","vhsProcode":"3","vhsDate":"2023-05-24 03:21:42","proName":"우산","proPrice":1750,"proStock":0,"proInfo":"비","productImage":[{"pigProusrselid":"testmart","pigProcode":"3","pigCode":"1","pigName":"testmart","pigPath":"https://placeimg.com/360/350/animals","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10}]');

            let html = ''; // String형 변수로 선언
            for (let i = 0; i < userWishListByPage.length; i++) {
                html +=
                    `
                <div class="card_product1">
                        <a href="/product/` +
                    userWishListByPage[i].vhsProusrselid +
                    `/ ` +
                    userWishListByPage[i].vhsProcode +
                    `/">
                            <span class="wrap_thumb">
                                <img cuimg="" uselazyloading="" class="img_g" src="` +
                    (userWishListByPage[i].productImage.length === 0 ? '/res/img/whitebox_logo_p.png' : userWishListByPage[i].productImage[0].pigPath) +
                    `" />
                            </span>
                            <span class="wrap_info"> <strong> </strong></span></a
                        ><strong><a class="txt_brand">` +
                    userWishListByPage[i].proName +
                    `</a> </strong>
                        <div>
                            <a class="txt_product">` +
                    userWishListByPage[i].proInfo +
                    `</a>
                        </div>
                        <div class="txt_price">
                            <strong> ¥<span class="txt_yen">` +
                    userWishListByPage[i].proPrice +
                    `</span> </strong>
                            <span class="txt_tax">税込</span>
                        </div>
                    </div>
                `;
            }
            section_content_div1_wishList.innerHTML = html; // 반복문으로 상품 불러온 것을 저장
        }

        console.log(userWishListByPage);
        console.log(userWishListCount);
    </script>
</html>
