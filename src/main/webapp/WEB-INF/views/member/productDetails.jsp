<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WhiteBox</title>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <link rel="stylesheet" href="/res/css/member/yeong_style.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <nav class="navbar"></nav>
        <script src="/res/js/member/navbar.js"></script>
        <div class="product_detail_wrap">
            <div class="product_detail_head">
                <div class="product_detail_image">
                    <div class="product_detail_image_head">
                        <img id="product_detail_image_head" src="" alt="" />
                    </div>
                    <div class="product_detail_image_list">
                        <div id="productImage1"></div>
                        <div id="productImage2"></div>
                        <div id="productImage3"></div>
                        <div id="productImage4"></div>
                    </div>
                </div>
                <div class="product_detail_head_content">
                    <form action="" method="post">
                        <div class="product_detail_head_content_top">
                            <p id="proName"></p>
                            <div>
                                <p>★★★★☆</p>
                                <p>[ 3000件 プレゼントレビュー ]</p>
                            </div>
                        </div>
                        <div class="product_detail_head_content_mid">
                            <div>
                                <img src="/res/img/YEONG/product_detail_head_content_mid_seller.svg" />
                                <span id="proUsrselid"></span>
                            </div>
                            <div>
                                数量
                                <input type="number" name="number" value="1" onchange="productDetailQuantityCheck(this)" />
                            </div>
                            <div id="proPrice"></div>
                        </div>
                        <div class="product_detail_head_content_bot">
                            <div>
                                <button class="product_detail_button button">ウィッシュリスト</button>
                                <button class="product_detail_button button">お気に入り</button>
                            </div>
                            <button class="product_detail_button button" onclick="event.preventDefault(); insertCart()">ギフトカートに入れる</button>
                            <button class="product_detail_button button">私にプレゼント</button>
                            <button class="product_detail_button button">友達へのプレゼント</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="product_detail_content">
                <div class="product_detail_content_head">
                    <div class="product_detail_content_head_wrap">
                        <div class="product_detail_content_head_nav active" onclick="productDetailChangeContent(this, 0)">商品説明</div>
                        <div class="product_detail_content_head_nav" onclick="productDetailChangeContent(this, 1)">プレゼントレビュー</div>
                        <div class="product_detail_content_head_nav" onclick="productDetailChangeContent(this, 2)">詳細情報</div>
                    </div>
                </div>
                <div class="product_detail_content_product_description product_detail_content_item active">
                    <img src="/res/img/YEONG/product_detail_content_product_description.png" alt="" />
                </div>

                <div class="product_detail_content_product_review product_detail_content_item">
                    <div class="product_detail_content_product_review_list">
                        <div class="product_detail_content_product_review_item">
                            <div class="product_detail_content_product_review_item_head">
                                <img src="/res/img/YEONG/product_detail_content_product_review_item.png" />
                                <div class="product_detail_content_product_review_item_info">
                                    <p>★★★★☆</p>
                                    <h4>明智 光秀</h4>
                                    <span>2023. 05. 09.</span>
                                </div>
                            </div>
                            <div class="product_detail_content_product_review_item_content">
                                美味しかったです。ただ想像より小さい。<br />
                                一口で食べれちゃいそうですが、もったいないので数口で味わって食べました。
                            </div>
                            <img src="/res/img/YEONG/product_detail_content_product_review_other.svg" />
                        </div>

                        <div class="product_detail_content_product_review_item">
                            <div class="product_detail_content_product_review_item_head">
                                <img src="/res/img/YEONG/product_detail_content_product_review_item.png" />
                                <div class="product_detail_content_product_review_item_info">
                                    <p>★★★★☆</p>
                                    <h4>明智 光秀</h4>
                                    <span>2023. 05. 09.</span>
                                </div>
                            </div>
                            <div class="product_detail_content_product_review_item_content">
                                美味しかったです。ただ想像より小さい。<br />
                                一口で食べれちゃいそうですが、もったいないので数口で味わって食べました。
                            </div>
                            <img src="/res/img/YEONG/product_detail_content_product_review_other.svg" />
                        </div>

                        <div class="product_detail_content_product_review_item">
                            <div class="product_detail_content_product_review_item_head">
                                <img src="/res/img/YEONG/product_detail_content_product_review_item.png" />
                                <div class="product_detail_content_product_review_item_info">
                                    <p>★★★★☆</p>
                                    <h4>明智 光秀</h4>
                                    <span>2023. 05. 09.</span>
                                </div>
                            </div>
                            <div class="product_detail_content_product_review_item_content">
                                美味しかったです。ただ想像より小さい。<br />
                                一口で食べれちゃいそうですが、もったいないので数口で味わって食べました。<br />
                                美味しかったです。ただ想像より小さい。<br />
                                一口で食べれちゃいそうですが、もったいないので数口で味わって食べました。<br />
                                美味しかったです。ただ想像より小さい。<br />
                                一口で食べれちゃいそうですが、もったいないので数口で味わって食べました。<br />
                                美味しかったです。ただ想像より小さい。<br />
                                一口で食べれちゃいそうですが、もったいないので数口で味わって食べました。<br />
                            </div>
                            <img src="/res/img/YEONG/product_detail_content_product_review_other.svg" />
                        </div>
                    </div>
                </div>

                <div class="product_detail_content_product_detail product_detail_content_item">
                    <p id="proInfo">餡については、赤い小豆餡を使う地域と白餡を使う地域に大別される。また、餡を使わずに苺のみを入れるものや、苺と生クリームを入れるものなどがあり、多様性に富む。生鮮食品であるイチゴ果実を使用するため、冬から春にかけての季節限定商品として売り出されることが多い。イチゴから次第に水気が出て餡が水っぽくなったり、水気が餅から漏れ出したりしやすいことから、比較的日持ちが短い。</p>
                </div>
            </div>
        </div>
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
    <script src="/res/js/member/yeong_main.js"></script>
    <script src="/res/js/projectUtils.js"></script>
    <script>
        let userInfo;
        if ('${userInfo}' !== '') {
            console.log('works?');
            userInfo = JSON.parse('${userInfo}');
            console.log(userInfo);
            changeNavbar(userInfo);
            console.log('works?');
        }
        if ('${notificationInfo}' !== '') {
            notificationInfo = JSON.parse('${notificationInfo}');
            makeNotification();
        }
        if ('${giftNotificationInfo}' !== '') {
            giftNotificationInfo = JSON.parse('${giftNotificationInfo}');
            makeGiftNotification();
        }
        function insertCart() {
            if (userInfo !== null && userInfo !== undefined) {
                const keys = ['odtProusrselid', 'odtProcode'];
                const values = [productInfo.proUsrselid, productInfo.proCode];
                // odtProusrselid=seller&odtProcode=3
                const formData = makeFormData(keys, values);
                sendAjaxPost('/insertCart', formData, 'insertCartCallBack');
            } else {
                alert('先にログインをしてください');
            }
        }
        function insertCartCallBack(data) {
            console.log(data);
            alert(data);
        }

        // 商品情報
        const productInfo = JSON.parse('${productInfo}');
        console.log(productInfo);

        document.querySelector('#proName').innerText = productInfo.proName;
        document.querySelector('#proUsrselid').innerText = productInfo.selShopname;
        document.querySelector('#proUsrselid').onclick = function () {
            let url = 'http://localhost/usr_selshop/' + productInfo.proUsrselid;
            let exec = document.createElement('a');
            exec.setAttribute('href', url);
            exec.click();
        };
        document.querySelector('#proInfo').innerText = productInfo.proInfo;
        document.querySelector('#proPrice').innerText = '¥' + productInfo.proPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',') + ' 税込';
        productInfo.productImage.forEach((e, i) => {
            if (e['pigIsthumbnail'] == 'T') document.querySelector('#product_detail_image_head').src = e['pigPath'];
            if (document.querySelector('#productImage' + (i + 1) + '') !== null) {
                document.querySelector('#productImage' + (i + 1) + '').innerHTML = '<img src="' + e['pigPath'] + '" alt="' + e['pigName'] + '" />';

                document.querySelector('#productImage' + (i + 1) + '').addEventListener('click', function () {
                    document.querySelector('#product_detail_image_head').src = e['pigPath'];
                    console.log(e['pigPath']);
                });
            }
        });
        /* for(let e in productInfo.productImage){
	  console.log(':: ' + document.querySelector('#productImage' + (e + 1) + ''));
	  document.querySelector('#productImage'+e+'').src = productInfo.productImage[e].pigPath;
	  console.log(productInfo.productImage[e].pigName);
  } */

        /* Object.entries(productInfo.productImage).map((e,i) => {
	  console.log(e.pigName + " : " + i);
  }); */

        productDetailQuantityCheck = e => {
            if (Number(e.value) < 1) {
                alert('1より少ない数字は入力出来ません');
                e.value = 1;
            } else if (Number(e.value) > Number(productInfo.proStock)) {
                alert('現在注文可能在庫数は' + productInfo.proStock + '個です。');
                e.value = productInfo.proStock;
            }
            console.log(e.value);
        };

        productDetailChangeContent = (e, i) => {
            let buttons = e.parentNode;
            let active = buttons.querySelector('.active');
            active ? active.classList.remove('active') : '';
            e.classList.add('active');

            document.querySelector('.product_detail_content_item.active').classList.remove('active');
            document.querySelectorAll('.product_detail_content_item').item(i).classList.add('active');
        };
    </script>
</html>
