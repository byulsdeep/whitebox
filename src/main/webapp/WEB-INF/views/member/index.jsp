<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WhiteBox</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <!-- main css-->
        <link rel="stylesheet" href="/res/css/member/kej_index.css" />
        <!-- notification CSS-->
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <!-- main js -->
        <script src="/res/js/member/kej_index.js" defer></script>
        <!-- jQuery 라이브러리 -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Slick 라이브러리 -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>
        <!-- header slider -->
        <header>
            <div class="index_header_section">
                <input type="radio" name="slide" id="header_slide01" checked />
                <input type="radio" name="slide" id="header_slide02" />
                <input type="radio" name="slide" id="header_slide03" />

                <div class="index_header_slidewrap">
                    <ul class="index_header_slidelist">
                        <li>
                            <a>
                                <label for="header_slide03" class="left"></label>
                                <img src="/res/img/kej/index (3).png" />
                                <label for="header_slide02" class="right"></label>
                            </a>
                        </li>
                        <li>
                            <a>
                                <label for="header_slide01" class="left"></label>
                                <img src="/res/img/kej/index (2).png" />
                                <label for="header_slide03" class="right"></label>
                            </a>
                        </li>
                        <li>
                            <a>
                                <label for="header_slide02" class="left"></label>
                                <img src="/res/img/kej/index (1).png" />
                                <label for="header_slide01" class="right"></label>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </header>
        <section>
            <!-- 카테고리 -->
            <div class="index_cat_section">
                <div class="index_cat">
                    <ul>
                        <li>
                            <a href=""><img src="/res/img/kej/130x130(1).png" alt /> </a>
                            <div class="txt">ファッション</div>
                        </li>
                        <li>
                            <a href=""><img src="/res/img/kej/130x130-전자기기.png" alt /> </a>
                            <div class="txt">電子機器</div>
                        </li>

                        <li>
                            <a href=""><img src="/res/img/kej/130x130-생일케익.png" alt /> </a>
                            <div class="txt">誕生日</div>
                        </li>

                        <li>
                            <a href=""><img src="/res/img/kej/130x130이사선물.png" alt /> </a>
                            <div class="txt">結婚/引っ越し祝い</div>
                        </li>

                        <li>
                            <a href=""><img src="/res/img/kej/130x130-키즈.png" alt /> </a>
                            <div class="txt">出産/キッズ</div>
                        </li>

                        <li>
                            <a href=""><img src="/res/img/kej/130x130명품.png" alt /> </a>
                            <div class="txt">ブランド</div>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 베스트상품 -->
            <div class="index_best_pro">
                <div class="site-wrap">
                    <div class="productItem ec-base-product">
                        <div class="xans-element- xans-product xans-product-listmain-1 xans-product-listmain xans-product-1" style="width: 1530px">
                            <li>
                                <div class="section-title">
                                    <h3 class="">
                                        <div style="text-align: left; font-size: 28px; margin-bottom: 5px">BEST 賞品</div>
                                        <div style="text-align: left; font-size: 15px">
                                            誰かにあげるプレゼントを悩んでいませんか？<br />
                                            このような商品はいかがでしょうか
                                        </div>
                                    </h3>
                                </div>
                            </li>
                            <div class="prdList-rt">
                                <ul class="prdList" id="bestProductList"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 추천상품 -->
            <div class="index_recommended_menu">
                <div class="recommended_title">おすすめ ギフト ランキング !!</div>
                <div class="index_recommended_section">
                    <div class="index_rec">
                        <ul>
                            <li>
                                <img id="recommendedFilter1-1" class="recommended_filter_gender active" src="/res/img/kej/recommended1.png" value="default" onclick="recommendedFilter(this); recommendProductToggle(this,0)" />
                                <div class="txt" style="margin-top: 5px">みんなが</div>
                            </li>
                            <li>
                                <img id="recommendedFilter1-2" class="recommended_filter_gender" src="/res/img/kej/recommended2.png" value="F" onclick="recommendedFilter(this); recommendProductToggle(this,1)" />
                                <div class="txt" style="margin-top: 5px">女性が</div>
                            </li>
                            <li>
                                <img id="recommendedFilter1-3" class="recommended_filter_gender" src="/res/img/kej/recommended3.png" value="M" onclick="recommendedFilter(this); recommendProductToggle(this,2)" />
                                <div class="txt" style="margin-top: 5px">男性が</div>
                            </li>
                            <li>
                                <img id="recommendedFilter1-4" class="recommended_filter_gender" src="/res/img/kej/recommended4.png" value="S" onclick="recommendedFilter(this); recommendProductToggle(this,3)" />
                                <div class="txt" style="margin-top: 5px">学生が</div>
                            </li>
                        </ul>
                        <div class="index_pro_menu">
                            <div class="index_pro_list1">
                                <ul>
                                    <li id="recommendedFilter2-1" class="recommended_filter_type active" value="gift" onclick="recommendedFilter(this); recommendProductToggle(this,0)">よく贈る物</li>
                                    <li id="recommendedFilter2-2" class="recommended_filter_type" value="wish" onclick="recommendedFilter(this); recommendProductToggle(this,1)">貰いたい物</li>
                                </ul>
                            </div>
                            <div class="index_pro_list2">
                                <ul>
                                    <li id="recommendedFilter3-1" class="recommended_filter_price active" value="all" onclick="recommendedFilter(this); recommendProductToggle(this,0)">全て</li>
                                    <li id="recommendedFilter3-2" class="recommended_filter_price" value="1" onclick="recommendedFilter(this); recommendProductToggle(this,1)">1000円未満</li>
                                    <li id="recommendedFilter3-3" class="recommended_filter_price" value="2" onclick="recommendedFilter(this); recommendProductToggle(this,2)">1000円~5000円</li>
                                    <li id="recommendedFilter3-4" class="recommended_filter_price" value="3" onclick="recommendedFilter(this); recommendProductToggle(this,3)">5000円以上</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 상품리스트 -->
                <div class="index_recommended_section_list">
                    <div class="proList_3x3 proList" id="proList"></div>
                    <div id="more_button">
                        <button onclick="moreRecommendedProduct(this)" style="width: 150px; background: none; border: 1px solid #222222; line-height: 40px; margin: 0 auto; display: none">▼ もっと見る</button>
                    </div>
                </div>
            </div>
            <!-- 배너 -->
            <div class="index_banner">
                <img src="/res/img/kej/index_ben 1000x200.png" alt="" />
            </div>
        </section>
        <div id="productList" style="width: 1122px; display: grid; grid-template-columns: 1fr 1fr 1fr"></div>
        <!-- footer -->
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
        <footer class="footer_container"></footer>
        <script src="/res/js/member/footer.js"></script>
    </body>
    <script src="/res/js/projectUtils.js"></script>
    <script>
        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }
        let homeProductList;
        if ('${homeProductList}' !== '') {
            homeProductList = JSON.parse('${homeProductList}');
        }
        window.onload = () => {
            loadProductList();
            loadRecommendProduct();
        };

        let filterGender = 'default';
        let filterStudent = 'default';
        let filterMinPrice = 'default';
        let filterMaxPrice = 'default';
        let filterType = 'gift';

        console.log('${welcomeInfo}');
        console.log('${userInfo}');

        //필터 토글
        let recommendedFilter = e => {
            let filterValue = e.id.slice(-4, e.id.length).substr(3, 1);
            switch (e.id.slice(-4, e.id.length).substr(1, 1)) {
                case '1':
                    if (filterValue == '4') {
                        filterGender = 'default';
                        filterStudent = e.getAttribute('value');
                    } else {
                        filterGender = e.getAttribute('value');
                        filterStudent = 'default';
                    }
                    break;
                case '2':
                    filterType = e.getAttribute('value');
                    break;
                case '3':
                    switch (filterValue) {
                        case '1':
                            filterMinPrice = 'default';
                            filterMaxPrice = 'default';
                            break;
                        case '2':
                            filterMinPrice = 'default';
                            filterMaxPrice = '999';
                            break;
                        case '3':
                            filterMinPrice = '1000';
                            filterMaxPrice = '4999';
                            break;
                        case '4':
                            filterMinPrice = '5000';
                            filterMaxPrice = 'default';
                            break;
                    }
                    break;
            }
            loadRecommendProduct();
        };

        let loadProductList = () => {
            let proList = '';
            homeProductList.forEach((e, i) => {
                proList += '<li><a href="';
                proList += 'product/' + e.proUsrselid + '/' + e.proCode;
                proList += '"><div class="card_product"><span class="wrap_thumb"> <img onerror="loadAlternateImage(this)" cuimg="" uselazyloading="" class="img_g" src="';
                e.productImage.forEach((e, i) => {
                    if (e.pigIsthumbnail == 'T') {
                        proList += e.pigPath;
                    }
                });
                proList += '" alt="';
                proList += e.proName;
                proList += '" /></span> <span class="wrap_info"><strong class="txt_ranking' + (i + 1 > 3 ? '2' : '') + '">';
                proList += i + 1;
                proList += '</strong><strong><div class="txt_brand">';
                proList += e.proName;
                proList += '</div></strong><div><div class="txt_product">';
                proList += e.proInfo;
                proList += '</div></div><div class="txt_price"><strong>¥<span class="txt_yen">';
                proList += e.proPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',');
                proList += '</span></strong><span class="txt_tax">税込</span></div></span></div></a></li>';
            });
            document.querySelector('#bestProductList').innerHTML = proList;

            // slick 적용
            $(document).ready(function () {
                $('.prdList').slick({
                    infinite: false,
                    slidesToShow: 3,
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
            //상품리스트 더보기 / 접기
            $(function () {
                let more = $('#load');
                more.text('▼ 더보기 / 접기');
                const initCount = 1; // 초기 갯수
                let shownCount = initCount;
                $('.proList_3x3').slice(0, shownCount).show();
                $('#load').click(function (e) {
                    e.preventDefault();
                    if (more.text() === '▼ 더보기 / 접기') {
                        shownCount += initCount; // 클릭시 추가될 갯수
                        $('.proList_3x3:hidden').slice(0, initCount).show();
                        if ($('.proList_3x3:hidden').length === 0) {
                            more.text('▲ 더보기 / 접기');
                        }
                    } else {
                        shownCount = initCount; // 초기 갯수로 되돌리기
                        $('.proList_3x3').slice(shownCount).hide();
                        more.text('▼ 더보기 / 접기');
                    }
                });
            });
        };

        /* sendAjaxPost("/recommend", makeFormData(filterKeys, filterValues), console.log('테스트')); */
        let loadRecommendProduct = () => {
            fetch('http://localhost/recommends', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    filterGender: filterGender,
                    filterStudent: filterStudent,
                    filterType: filterType,
                    filterMinPrice: filterMinPrice,
                    filterMaxPrice: filterMaxPrice,
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
                    let proList = '';
                    if (data != null) {
                        data.forEach((e, i) => {
                            document.querySelector('#more_button button').style.display = i > 8 ? 'block' : 'none';
                            console.log(i);
                            if(i > 8){
                                proList += '<li style="display:none;"><a href="';
                            }else{
                                proList += '<li><a href="';
                            }
                            proList += 'product/' + e.proUsrselid + '/' + e.proCode;
                            proList += '"><div class="card_product"><span class="wrap_thumb"> <img onerror="loadAlternateImage(this)" cuimg="" uselazyloading="" class="img_g" src="';
                            e.productImage.forEach((e, i) => {
                                if (e.pigIsthumbnail == 'T') {
                                    proList += e.pigPath;
                                }
                            });
                            proList += '" alt="';
                            proList += e.proName;
                            proList += '" /></span> <span class="wrap_info"><strong class="txt_ranking' + (i + 1 > 3 ? '2' : '') + '">';
                            proList += i + 1;
                            proList += '</strong><strong><div class="txt_brand">';
                            proList += e.proName;
                            proList += '</div></strong><div><div class="txt_product">';
                            proList += e.proInfo;
                            proList += '</div></div><div class="txt_price"><strong>¥<span class="txt_yen">';
                            proList += e.proPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',');
                            proList += '</span></strong><span class="txt_tax">税込</span></div></span></div></a></li>';
                        });
                    }
                    document.querySelector('#proList').innerHTML = proList;
                });
        };
        // 상품 더보기
        let moreRecommendedProduct = e => {
            let proList = document.querySelector('#proList').children;
            proList[9] != null && proList[9].style.display != 'none' ? (e.innerText = '▼ もっと見る') : (e.innerText = '▲ 閉じる');

            Array.prototype.forEach.call(proList, (e, i) => {
                if (i >= 9) {
                    e.style.display = e.style.display != 'none' ? 'none' : 'block';
                }
            });
        };

        let recommendProductToggle = (e, i) => {
            let buttons = e.parentNode.parentNode;
            let active = buttons.querySelector('.active');
            active ? active.classList.remove('active') : '';
            e.classList.add('active');
        };

        let userInfo;
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
        }
        let welcomeInfo;
        // 회원가입 종료 시 얼러트
        if ('${welcomeInfo}' !== '') {
            welcomeInfo = JSON.parse('${welcomeInfo}');
            if (welcomeInfo.memIssocial === 'T') {
                alert('加入おめでとうございます！' + welcomeInfo.usrLastname + welcomeInfo.usrFirstname + 'さん！');
            } else {
                alert('加入おめでとうございます！' + welcomeInfo.usrLastname + welcomeInfo.usrFirstname + 'さん！加入Eメールに認証メールを送りました。Whiteboxを楽しむにEメールをご認証ください！');
            }
        }
        // 로그인이고 회원가입후가 아닐 시 또는 처음 소셜 로그인 시
        // 로그인이고 회원가입후가 아닐 시
        if (userInfo !== undefined) {
            changeNavbar(userInfo);
        }
        // 처음 회원가입 후 로그인 후 이메일 미 인증 상태
        if ('${unauthenticated}' === 'true') {
            const message = document.createElement('h3');
            message.innerText = '加入おめでとうございます！' + userInfo.usrLastname + userInfo.usrFirstname + 'さん！加入Eメールに認証メールを送りました。Whiteboxを楽しむにEメールをご認証ください！';
            message.innerText += '認証ができない場合は下のボタンで認証Eメールを再転送することができます。';
            const form = document.createElement('form');
            form.style.display = 'none';
            form.action = '/resendAuthenticationEmail';
            form.method = 'post';
            const button = document.createElement('button');
            button.innerText = 'Eメール再転送';
            form.appendChild(button);
            document.body.appendChild(form);
        }
        // 어떠한 이유로 인증 이메일 전송을 다시 요청 할 시
        if ('${authenicationEmailResent}' === 'true') {
            const message = document.createElement('h3');
            message.innerText = '加入おめでとうございます！' + userInfo.usrLastname + userInfo.usrFirstname + 'さん！加入Eメールに認証メールを送りました。Whiteboxを楽しむにEメールをご認証ください！';
            message.innerText += '認証Eメールを転送しました。';
            const form = document.createElement('form');
            form.style.display = 'none';
            form.action = '/resendAuthenticationEmail';
            form.method = 'post';
            const button = document.createElement('button');
            button.innerText = 'Eメール再転送';
            form.appendChild(button);
            document.body.appendChild(form);
        }
    </script>
</html>
