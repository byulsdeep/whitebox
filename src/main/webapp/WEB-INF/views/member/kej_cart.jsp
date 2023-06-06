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
        <link rel="stylesheet" href="/res/css/member/kej_cart.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <script src="/res/js/member/kej_cart.js" defer></script>
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>
        <!-- box 시작 -->
        <div class="cart">
            <div class="cart_title">
                <div>カート</div>
            </div>
            <div class="cart_container">
                <div style="display: none" class="cart_menu">
                    <div class="cart_mene_inner">
                        <!-- <input type="checkbox" /> -->
                        <div>全体</div>
                        <div id="odtCount"></div>
                    </div>
                    <a href="/member/emptyCart">
                        <div>全体削除</div>
                    </a>
                </div>
                <div class="cart_Information"></div>
                <div class="cart_sum">
                    <div class="cart_sum_inner">
                        <div>総計</div>
                        <div id="sum"></div>
                    </div>
                </div>
                <div class="cart_btn_Payment">
                    <a href="/member/order">プレゼントする</a>
                </div>
            </div>
        </div>
        <!-- 친구 프로필 선택 모달창 -->
        <div style="display: none" id="modal" class="modal-overlay">
            <div class="modal-window">
                <div class="fri_title">
                    <h2>友達選択</h2>
                    <div>プレゼントを送る友達を選択してください.</div>
                </div>
                <div class="close-area">X</div>
                <div class="content">
                    <!-- 1행 -->
                    <div class="cart_fri">
                        <div class="cart_fri_Information">
                            <input type="radio" />
                            <div class="cart_fri_img">
                                <img src="" alt="" />
                            </div>
                            <div class="cart_fri_name">강한별</div>
                        </div>
                        <div class="cart_fri_Information">
                            <input type="radio" />
                            <div class="cart_fri_img">
                                <img src="" alt="" />
                            </div>
                            <div class="cart_fri_name">권단비</div>
                        </div>
                        <div class="cart_fri_Information">
                            <input type="radio" />
                            <div class="cart_fri_img">
                                <img src="" alt="" />
                            </div>
                            <div class="cart_fri_name">권혁현</div>
                        </div>
                        <div class="cart_fri_Information">
                            <input type="radio" />
                            <div class="cart_fri_img">
                                <img src="" alt="" />
                            </div>
                            <div class="cart_fri_name">김은지</div>
                        </div>
                        <div class="cart_fri_Information">
                            <input type="radio" />
                            <div class="cart_fri_img">
                                <img src="" alt="" />
                            </div>
                            <div class="cart_fri_name">소순영</div>
                        </div>
                        <div class="cart_fri_Information">
                            <input type="radio" />
                            <div class="cart_fri_img">
                                <img src="" alt="" />
                            </div>
                            <div class="cart_fri_name">다람쥐</div>
                        </div>
                    </div>
                    <div class="cart_fri_btn">
                        <button id="updateRecipientButton" class="close-area">選択完了</button>
                        <button id="copyCartButton" style="display: none">同じ商品を他の人にも</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 수량 모달 -->
        <div style="display: none" id="modal_sum" class="modal_sum-overlay">
            <div class="modal_sum-window">
                <div class="title_sum">
                    <h2>数量変更</h2>
                </div>
                <div class="content"></div>
                <div class="cart_pro_num">
                    <input type="button" onclick='count("minus")' value="-" />
                    <div id="result">1</div>
                    <input type="button" onclick='count("plus")' value="+" />
                </div>
                <div class="cart_pro_btn_area">
                    <button class="pro_num_btn" id="close-area_sum">取消</button>
                    <button class="pro_num_btn" id="close-area_sum_info">選択完了</button>
                </div>
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
        document.body.style.opacity = '0';
        window.onload = function () {
            var scrollPosition = sessionStorage.getItem('scrollPosition');
            window.scrollTo(0, scrollPosition);
            document.body.style.opacity = '1';
        };
        let userInfo;
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            //userInfo = JSON.parse('{"usrId":"member_db1","usrPassword":"$2a$10$vJInotHMkCEld9dnIoEizunuZENiDnUwlbKc6Rlnzl36bjXumNQdG","usrEnabled":1,"usrLastname":"Member","usrFirstname":"DBOne","usrPhone":"2400","usrEmail":"whitebox-japan@outlook.com","usrAddress":"1 1","usrImage":"/res/img/whitebox_logo_p.png","usrDate":"2023-05-29","authorities":[{"autUsrid":"member_db1","autAuthority":"ROLE_MEMBER"}],"memPostal":"1","memGender":"F","memBirthday":"2010-01-02","isDecoded":true,"memIssocial":"F"}');

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

        if ('${cartInfo}' !== '' && '${cartInfo}' !== 'null') {
            cartInfo = JSON.parse('${cartInfo}');
            //cartInfo = JSON.parse('{"ordDate":"20230530002040","ordUsrmemid":"member_db1","ordOststate":"OC","ordPaycode":"PN","orderDetail":[{"odtOrddate":"2023-05-30 00:20:40","odtOrdmemid":"member_db1","odtProusrselid":"seller_db1","odtProcode":"1","odtQty":1,"odtMemrecipient":"member_db1","odtGstcode":"GC","selInfo":"洋服屋 出産/キッズ","usrImage":"/res/img/whitebox_logo_p.png","usrLastname":"Member","usrFirstname":"DBOne","proName":"スウェット","proPrice":1000,"proStock":20,"proInfo":"シンプルなスウェットです。","proIsdeleted":"F","productImage":[{"pigProusrselid":"seller_db1","pigProcode":"1","pigCode":"1","pigName":"スウェット1.PNG","pigPath":"/res/img/productImg/seller_db1/1/original/スウェット1.PNG","pigIsthumbnail":"T"}],"currentPage":1,"itemsPerPage":10,"selShopname":"洋服屋"}]}');
        }
        console.log(cartInfo);

        if (cartInfo !== undefined && cartInfo !== 'null') {
            document.querySelector('.cart_menu').style.display = 'flex';
            const odtCount = document.querySelector('#odtCount');
            odtCount.innerText = '(' + cartInfo.orderDetail.length + '/' + cartInfo.orderDetail.length + ')';

            let html = '';
            let sum = 0;
            cartInfo.orderDetail.forEach((odt, index) => {
                html +=
                    `
          <div class="cart_01">
            <div class="cart_01_inner">
              <div>` +
                    odt.selShopname +
                    `</div>
            </div>
            <div onclick='deleteCart(` +
                    index +
                    `)'>X</div>
          </div>
          <div class="division-line"></div>
          <div class="cart_02">
            <!-- <input type="checkbox" /> -->
            <div class="image_wrap"><img class="image" src="` +
                    (odt.productImage.length !== 0 ? odt.productImage[0].pigPath : '/res/img/whitebox_logo_p.png') +
                    `" alt="" onerror="loadAlternateImage(this)" /></div>
            <div>
              ` +
                    odt.proName +
                    `
            </div>
            <div class="cart_btn">
              <button class="btn-modal_sum" onclick='changeQty(` +
                    index +
                    `)'>数量変更</button>
              <button class="btn-modal" onclick='setRecipient(` +
                    index +
                    `)'>受信者選択</button>
              <div class="cart_fri_img"><img class="profileImage" src="` +
                    odt.usrImage +
                    `" alt="" /></div>
              <div class="cart_fri_name">` +
                    (odt.odtMemrecipient === userInfo.usrId ? '自分にプレゼント' : odt.usrLastname + odt.usrFirstname) +
                    `</div>
            </div>
          </div> 
          <div class="division-line"></div>
          <div class="cart_03">
            <div class="cart_03_inner1">
              <div>商品金額</div>
              <div>` +
                    odt.proPrice +
                    `￥</div>
              <div>選択数量</div>
              <div>x ` +
                    odt.odtQty +
                    `個</div>
            </div>
            <div class="cart_03_inner1">
              <div>決済金額</div>
              <div>` +
                    odt.proPrice * odt.odtQty +
                    `￥</div>
            </div>
          </div>
        `;
                sum += odt.proPrice * odt.odtQty;
            });

            document.querySelector('.cart_Information').innerHTML = html;
            document.querySelector('#sum').style.display = 'flex';
            document.querySelector('#sum').innerText = sum + '￥';
        } else {
            document.querySelector('.cart_container').innerHTML = `
            <div>まだ商品がありません。</div>
            `;
        }

        // friend list
        let friendList;
        if ('${friendList}' !== '') {
            friendList = JSON.parse('${friendList}');
            //friendList = JSON.parse('[{"friendId":"member_db2","friDate":"2023-05-29 22:14:49","usrEnabled":0,"usrLastname":"Member","usrFirstname":"DBTwo","usrImage":"/res/img/whitebox_logo_p.png","memGender":"M","memBirthday":"1999-02-02 00:00:00","isDecoded":false},{"friendId":"member_db3","friDate":"2023-05-29 22:14:49","usrEnabled":0,"usrLastname":"Member","usrFirstname":"DBThree","usrImage":"/res/img/whitebox_logo_p.png","memGender":"F","memBirthday":"1989-01-02 00:00:00","isDecoded":false},{"friendId":"member_db1","usrEnabled":0,"usrLastname":"Member","usrFirstname":"DBOne","usrImage":"/res/img/whitebox_logo_p.png","isDecoded":false}]');
        }

        const copyCartButton = document.querySelector('#copyCartButton');
        const updateRecipientButton = document.querySelector('#updateRecipientButton');

        function changeQty(index) {
            document.getElementById('modal_sum').style.display = 'flex';
            const orderDetail = cartInfo.orderDetail[index];
            const result = document.getElementById('result');
            result.innerText = orderDetail.odtQty;
            const updateQty = document.querySelector('#close-area_sum_info');
            updateQty.setAttribute('onclick', 'updateQty(' + index + ')');
        }
        function updateQty(index) {
            const orderDetail = cartInfo.orderDetail[index];
            orderDetail.odtQty = Number(document.getElementById('result').innerText);
            const form = document.createElement('form');
            form.style.display = 'none';
            form.method = 'post';
            form.action = 'updateQty';
            const ignoreList = ['currentPage', 'itemsPerPage', 'proInfo', 'proIsdeleted', 'proName', 'proPrice', 'proStock', 'productImage', 'selInfo', 'selShopname'];
            for (let key in orderDetail) {
                if (ignoreList.includes(key)) {
                    continue;
                }
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = orderDetail[key];
                form.appendChild(input);
            }
            document.body.appendChild(form);
            console.log(form.innerHTML);
            sessionStorage.setItem('scrollPosition', window.scrollY);
            form.submit();
        }
        function deleteCart(index) {
            console.log('deleteCart');
            const orderDetail = cartInfo.orderDetail[index];

            console.log(orderDetail);

            const form = document.createElement('form');
            form.style.display = 'none';
            form.method = 'post';
            form.action = 'deleteCart';
            const ignoreList = ['currentPage', 'itemsPerPage', 'proInfo', 'proIsdeleted', 'proName', 'proPrice', 'proStock', 'productImage', 'selInfo', 'selShopname'];
            for (let key in orderDetail) {
                if (ignoreList.includes(key)) {
                    continue;
                }
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = orderDetail[key];
                form.appendChild(input);
            }
            document.body.appendChild(form);
            console.log(form.innerHTML);
            sessionStorage.setItem('scrollPosition', window.scrollY);
            form.submit();
        }
        function setRecipient(index) {
            document.getElementById('modal').style.display = 'flex';
            const orderDetail = cartInfo.orderDetail[index];
            const odtMemrecipient = orderDetail.odtMemrecipient;
            console.log(odtMemrecipient);
            console.log(document.getElementsByName('odtMemrecipient'));
            Array.from(document.getElementsByName('odtMemrecipient'))
                .filter(element => element.value === odtMemrecipient)
                .forEach(element => element.setAttribute('checked', true));

            if (userInfo.usrId !== odtMemrecipient) {
                copyCartButton.style.display = 'block';
            }
            copyCartButton.setAttribute('onclick', 'copyCart(' + index + ')');
            updateRecipientButton.setAttribute('onclick', 'updateRecipient(' + index + ')');

            let recipients = [];

            if (friendList !== null) {
                console.log(friendList);
                let html = '';
                for (let odt of cartInfo.orderDetail) {
                    if (odt.odtProcode === orderDetail.odtProcode && odt.odtProusrselid === orderDetail.odtProusrselid) {
                        recipients.push(odt.odtMemrecipient);
                    }
                }

                friendList.forEach(friend => {
                    if (!recipients.includes(friend.friendId)) {
                        html +=
                            `
                <div class="cart_fri_Information">
                  <input type="radio" name='odtMemrecipient' value='` +
                            friend.friendId +
                            `' />
                  <div class="cart_fri_img"><img class="profileImage" src="` +
                            friend.usrImage +
                            `" alt="" /></div>
                  <div class="cart_fri_name">` +
                            (friend.friendId === userInfo.usrId ? '自分にプレゼント' : friend.usrLastname + ' ' + friend.usrFirstname) +
                            `</div>
                </div>
          `;
                    }
                });
                if (html.length === 0) {
                    html = '全ての友達を選びました';
                    updateRecipientButton.removeAttribute('onclick');
                    copyCartButton.style.display = 'none';
                }
                document.querySelector('.cart_fri').innerHTML = html;
            }

            if (recipients.includes(userInfo.usrId)) {
                copyCartButton.style.display = 'none';
            }
        }

        function updateRecipient(index) {
            const orderDetail = cartInfo.orderDetail[index];
            console.log(orderDetail);

            const form = document.createElement('form');
            form.style.display = 'none';
            form.method = 'post';
            form.action = 'updateRecipient';
            const ignoreList = ['currentPage', 'itemsPerPage', 'proInfo', 'proIsdeleted', 'proName', 'proPrice', 'proStock', 'productImage', 'selInfo', 'selShopname'];
            for (let key in orderDetail) {
                if (ignoreList.includes(key)) {
                    continue;
                }
                var input = document.createElement('input');
                input.type = 'hidden';
                if (key === 'odtMemrecipient') {
                    input.name = 'oldOdtMemrecipient';
                } else {
                    input.name = key;
                }
                input.value = orderDetail[key];
                form.appendChild(input);
            }

            const checkedRecipients = Array.from(document.getElementsByName('odtMemrecipient')).filter(recipient => recipient.checked === true);

            if (checkedRecipients.length === 0) {
                return; 
            }
            checkedRecipients.forEach(recipient => form.appendChild(recipient));

            document.body.appendChild(form);
            console.log(form.innerHTML);
            sessionStorage.setItem('scrollPosition', window.scrollY);
            form.submit();
        }
        function copyCart(index) {
            const orderDetail = cartInfo.orderDetail[index];
            console.log(orderDetail);

            const form = document.createElement('form');
            form.style.display = 'none';
            form.method = 'post';
            form.action = 'copyCart';
            const ignoreList = ['currentPage', 'itemsPerPage', 'proInfo', 'proIsdeleted', 'proName', 'proPrice', 'proStock', 'productImage', 'selInfo', 'selShopname', 'odtMemrecipient'];
            for (let key in orderDetail) {
                if (ignoreList.includes(key)) {
                    continue;
                }
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = orderDetail[key];
                form.appendChild(input);
            }
            document.body.appendChild(form);
            console.log(form.innerHTML);
            sessionStorage.setItem('scrollPosition', window.scrollY);
            form.submit();
        }
    </script>
</html>
