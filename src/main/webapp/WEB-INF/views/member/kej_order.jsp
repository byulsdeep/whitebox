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
        <!-- main css-->
        <link rel="stylesheet" href="/res/css/member/kej_order.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>
        <div class="order_container">
            <div class="order_title">注文商品</div>
            <!-- 배송정보 (이메일 / 전화번호) -->
            <div class="order_infobox">
                <div class="order_box_title">
                    <span><b>お届け先</b></span>
                    <!-- <span><b>お届け先追加</b></span> -->
                </div>
                <div class="inner-line"></div>

                <div class="order_info">
                    <div>本人</div>
                    <div>基本</div>
                </div>
                <br />
                <table class="order_user_info">
                    <tr>
                        <th>お名前</th>
                        <td><input id="usrNames" disabled /></td>
                    </tr>
                    <tr>
                        <th>メールアドレス:</th>
                        <td><input id="usrEmail" disabled /></td>
                    </tr>
                    <tr>
                        <th>住所:</th>
                        <td><input id="usrAddress" disabled /></td>
                    </tr>
                    <tr>
                        <th>郵便番号:</th>
                        <td><input id="memPostal" disabled /></td>
                    </tr>
                    <tr>
                        <th>携帯番号:</th>
                        <td><input id="usrPhone" disabled /></td>
                    </tr>
                </table>

                <div style="text-align: center">(友達に送るギフトのお届け先は友達が確認するので安心してください)</div>
                <div class="order_btn">
                    <a class="ord_info_button" href="/member/myPage/accountSetting">お届け先変更</a>
                </div>
            </div>
            <!-- 상품정보 -->
            <div class="order_pro_info"></div>
            <!--합계 -->
            <div class="order_sum">
                <div class="order_sum_pr">
                    <div><b>合計</b></div>
                    <div><b id="total"></b></div>
                </div>
                <div class="order_sum_info"></div>
            </div>
            <!-- 결제 -->
            <div class="order_pay">
                <div class="order_box_title">
                    <div><b>お支払い方法選択</b></div>
                </div>
                <div class="inner-line"></div>
                <div class="order_pay_inner">
                    <div>
                        <label for="">
                            <input name="paymentType" type="radio" value="paypal" />
                            ペイパル
                        </label>
                    </div>
                </div>
            </div>
            <div class="order_btn">
                <button class="ord_pay_button" onclick="payment()">決済する</button>
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
        let cartInfo;
        if ('${cartInfo}' !== '') {
            cartInfo = JSON.parse('${cartInfo}');
        }
        console.log(cartInfo);

        document.querySelector('#usrNames').value = userInfo.usrLastname + userInfo.usrFirstname;
        document.querySelector('#usrEmail').value = userInfo.usrEmail;
        document.querySelector('#usrAddress').value = userInfo.usrAddress;
        document.querySelector('#memPostal').value = userInfo.memPostal;
        document.querySelector('#usrPhone').value = userInfo.usrPhone;

        const order_pro_info = document.querySelector('.order_pro_info');

        let html = '';
        let sums = [];
        cartInfo.orderDetail.forEach(odt => {
            html +=
                `
                <div class="order_box_title">
                    <b>
                        <div>` +
                odt.selShopname +
                `</div>
                    </b>
                </div>
                <div class="inner-line"></div>
                <div class="order_pro_pr">
                    <div>
                        <img src="` +
                (odt.productImage.length !== 0 ? odt.productImage[0].pigPath : '/res/img/whitebox_logo_p.png') +
                `" alt="` +
                odt.proName +
                `" onerror="loadAlternateImage(this)" />
                    </div>
                    <div>` +
                odt.proName +
                `</div>
                </div>
                <div class="inner-line"></div>
                <div class="order_pro_py">
                    <div><b>支払い金額</b></div>
                    <div><b>` +
                odt.proPrice * odt.odtQty +
                `￥</b></div>
                </div>
                <div class="order_pro_box">
                    <div class="order_pro_inner">
                        <div>商品金額</div>
                        <div>` +
                odt.proPrice +
                `￥</div>
                    </div>
                    <div class="order_pro_inner">
                        <div>選択数量</div>
                        <div>x ` +
                odt.odtQty +
                `個</div>
                    </div>
                    <div class="order_pro_inner">
                        <div>受取人</div>
                        <div>` +
                odt.usrLastname +
                odt.usrFirstname +
                `</div>
                    </div>
                </div>
                `;
            sums.push(odt.proPrice * odt.odtQty);
        });
        order_pro_info.innerHTML = html;

        document.querySelector('#total').innerText = sums.reduce((acc, cur) => acc + cur, 0) + '￥';
        const order_sum_info = document.querySelector('.order_sum_info');

        html = '';

        sums.forEach((item, index) => {
            html +=
                `
                <div class="order_sum_inner">
                    <div>商品金額(` +
                (index + 1) +
                `)</div>
                    <div>` +
                item +
                `￥</div>
                </div>
            `;
        });
        order_sum_info.innerHTML = html;

        function payment() {
            const paymentType = Array.from(document.getElementsByName('paymentType')).find(input => input.checked).value;
            if (paymentType === undefined) {
                alert('お支払い方をご確認ください。');
            } else {
                window.location.href = '/member/payment/' + paymentType;
            }
        }
    </script>
</html>
