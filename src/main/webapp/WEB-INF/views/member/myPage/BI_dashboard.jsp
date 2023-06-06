<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <!-- jQuery 라이브러리 -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- NAVBAR CSS -->
        <link rel="stylesheet" href="/res/css/reset.css" />
        <link rel="stylesheet" href="/res/css/member/BI_signUp.css" />
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <link rel="stylesheet" href="/res/css/member/BI_myPage.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />

        <!-- Slick 라이브러리 -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
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
                    <div class="usrLastname"></div>
                    <div class="usrFirstname"></div>
                    様の欲しいものリスト
                </div>
                <!-- 위시 목록 생성 공간 -->
                <div class="section_content_div1_wishList"></div>
                <!--give & take tap-->
                <div class="receive_giftbox">
                    <ul role="tablist" class="tab_receive">
                        <li role="presentation" class="on" id="sentButton" onclick="toggleGiftbox('sent')">
                            <a role="tab" cutiara="" class="link_tab" data-tiara-layer="available tab available" data-tiara-copy="보낸 선물탭"> 贈り物 </a>
                        </li>
                        <li role="presentation" id="receivedButton" onclick="toggleGiftbox('received')">
                            <a role="tab" cutiara="" class="link_tab" data-tiara-layer="unavailable tab unavailable" data-tiara-copy="받은 선물탭"> 貰った物 </a>
                        </li>
                        <!---->
                    </ul>
                </div>
                <!--give & take tap ends here-->
                <!--div2-->
                <div class="section_content_div2">
                    <div class="prdList-rt sent">
                        <ul class="prdList">
                        </ul>
                    </div>
                    <div class="prdList-rt received">
                        <ul class="prdList">
                        </ul>
                    </div>
                </div>
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
    <script>
        function toggleGiftbox(type) {
            if (type === 'sent') {
                document.querySelector('.sent').style.display = 'block';
                document.querySelector('.received').style.display = 'none';
                document.querySelector('#sentButton').className = 'on';
                document.querySelector('#receivedButton').className = '';
            } else {
                document.querySelector('.sent').style.display = 'none';
                document.querySelector('.received').style.display = 'block';
                document.querySelector('#sentButton').className = '';
                document.querySelector('#receivedButton').className = 'on';
            }
        }
        let sentGiftList, receivedGiftList;
        if ('${sentGiftList}' !== '') {
            sentGiftList = JSON.parse('${sentGiftList}');
        }
        if ('${receivedGiftList}' !== '') {
            receivedGiftList = JSON.parse('${receivedGiftList}');
        }
        console.log(sentGiftList);
        console.log(receivedGiftList);

        const sent_list = document.querySelector('.sent').children[0];
        const received_list = document.querySelector('.received').children[0];

        if (sentGiftList !== undefined && sentGiftList.length > 0) {
            sent_list.innerHTML = makeGiftList(sentGiftList);
        }
        if (receivedGiftList !== undefined && receivedGiftList.length > 0) {
            received_list.innerHTML = makeGiftList(receivedGiftList);
        }

        function makeGiftList(list) {
            let html = '';
            list.forEach(gift => {
                html +=
                    `
                            <li>
                                <div class="card_product1">
                                    <span class="wrap_thumb"> <img cuimg="" uselazyloading="" class="img_g" src="` +
                    (gift.productImage.length !== 0 ? gift.productImage[0].pigPath : '/res/img/whitebox_logo_p.png') +
                    `" /></span>
                                    <span class="wrap_info"
                                        ><strong class="txt_ranking">1</strong>
                                        <strong>
                                            <a class="txt_brand">` +
                    gift.proName +
                    `</a>
                                        </strong>
                                        <div>
                                            <a class="txt_product">` +
                    gift.proInfo +
                    `</a>
                                        </div>
                                            <div><a class="txt_product">` +
                    (gift.odtOrdmemid !== userInfo.usrId && gift.odtMemrecipient === userInfo.usrId ? 'FROM. ' + gift.usrLastname + ' ' + gift.usrFirstname : gift.odtOrdmemid === userInfo.usrId && gift.odtMemrecipient !== userInfo.usrId ? 'TO. ' + gift.usrLastname + ' ' + gift.usrFirstname : '') +
                    `</a></div>
                                        <div>` +
                    new Date(gift.odtOrddate).toLocaleString() +
                    `</div>
                                    </span>
                                </div>
                            </li>
                                `;
            });
            return html;
        }
    </script>
    <script>
        const main = document.querySelector('.main');
        const my_profile_img = document.querySelector('.my_profile_img');
        const usrImageFile = document.querySelector('#usrImageFile');

        console.log(userInfo);
        my_profile_img.src = userInfo.usrImage;

/*         if (userInfo.memIssocial === 'T') {
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
                <li>
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
                    <span class="wrap_info">
                        <strong> </strong>
                    </span>
                </a>
                    <strong>
                        <a class="txt_brand">` +
                    userWishListByPage[i].proName +
                    `</a>
                    </strong>
                <div>
                    <a class="txt_product">` +
                    userWishListByPage[i].proInfo +
                    `</a>
                </div>
                <div class="txt_price">
                    <strong>
                        ¥<span class="txt_yen">` +
                    userWishListByPage[i].proPrice +
                    `</span>
                    </strong>
                    <span class="txt_tax">税込</span>
                </div>
            </div>
            </li>
        `;
            }
            section_content_div1_wishList.innerHTML = html; // 반복문으로 상품 불러온 것을 저장
        }

        console.log(userWishListByPage);
    </script>
    <!-- <script>
        // 슬라이드
        $(document).ready(function () {
            $('.section_content_div1_wishList').slick({
                infinite: false,
                slidesToShow: 4,
                slidesToScroll: 1,
                dots: true, // 인디케이터 표시
                autoplay: false,
                centerMode: false,
                centerPadding: '0',
                draggable: true,
                swipeToSlide: true,
                prevArrow: false,
                nextArrow: false,
                responsive: [
                    {
                        breakpoint: 768,
                        settings: {
                            slidesToShow: 1,
                        },
                    },
                ],
            });

            // 스타일 수정 - 1개씩 보여지는 경우 인디케이터 위치 수정
            $('.prdList.slick-initialized.slick-slider .slick-dots').css('bottom', '-40px');
        });
        // 더보기/접기
        $(function () {
            let more = $('#load');
            more.text('▼ 더보기 / 접기');
            const initCount = 1; // 초기 갯수
            let shownCount = initCount;
            $('.prdList-rt').slice(0, shownCount).show();
            $('#load').click(function (e) {
                e.preventDefault();
                if (more.text() === '▼ 더보기 / 접기') {
                    shownCount += initCount; // 클릭시 추가될 갯수
                    $('.prdList-rt:hidden').slice(0, initCount).show();
                    if ($('.prdList-rt:hidden').length === 0) {
                        more.text('▲ 더보기 / 접기');
                    }
                } else {
                    shownCount = initCount; // 초기 갯수로 되돌리기
                    $('.prdList-rt').slice(shownCount).hide();
                    more.text('▼ 더보기 / 접기');
                }
            });
        });
    </script> -->
</html>
