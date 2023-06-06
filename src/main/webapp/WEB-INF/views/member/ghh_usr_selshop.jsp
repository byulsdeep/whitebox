<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>WhiteBox</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/member/navbar.css" />
        <!-- main css-->
        <link rel="stylesheet" href="/res/css/member/kej_index.css" />
        <link rel="stylesheet" href="/res/css/member/notification.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/member/footer.css" />
        <!-- jQuery 라이브러리 -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="/res/css/member/ghh_usr_selshop.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/member/navbar.js"></script>
        <div class="use_selshop_container">
            <div class="usr_selshop_info">
                <div class="usr_selshop_image">
                    <img id="usrImage" class="sel_shop_img" src="/res/img/kej/스타벅스 로고.png" alt="슽아벅스" />
                </div>
                <div class="usr_selshop_coment">
                    <h2 id="selShopname" class="usr_selshop_title">슽아벅스</h2>
                    <span id="selInfo" class="usr_selshop_inner"
                        >안녕하세요. <br />
                        저희는 언제나 신선한 커피를 위해 체계적으로 관리를 하고있습니다.<br />
                    </span>
                </div>
            </div>
            <div class="usr_selshop_ranking">
                <div class="usr_selshop_ranking_title">
                    <div>BEST プレゼント🎁</div>
                </div>
                <ul class="usr_selshop_ranking_List">
                    <!-- <li>
          <div class="card_product">
            <span class="wrap_thumb">
              <img
                cuimg=""
                uselazyloading=""
                class="img_g"
                src="https://img1.kakaocdn.net/thumb/C306x306@2x.q82.fwebp/?fname=https%3A%2F%2Fst.kakaocdn.net%2Fproduct%2Fgift%2Fproduct%2F20230315154042_18142860e30348aa81b257f108b94c26.jpg"
                alt="'숙면선물' 쿤달"
            /></span>
            <span class="wrap_info"
              ><strong class="txt_ranking">1</strong>
              <strong>
                <a class="txt_brand">쿤달(리빙) 필로우미스트</a>
              </strong>
              <div>
                <a class="txt_product"
                  >'숙면선물' 쿤달 릴랙싱 슬립 배럴 아로마 필로우미스트 150ml</a
                >
              </div>
              <div class="txt_price">
                <strong>¥<span class="txt_yen">2,500</span></strong
                ><span class="txt_tax">税込</span>
              </div>
            </span>
          </div>
        </li> -->
                </ul>
                <hr style="width: 1120px" />
            </div>

            <div class="usr_selshop_pro_3x3">
                <div class="usr_selshop_pro_title">
                    <div class="pro_title_text">以外のプレゼントリスト</div>
                </div>
                <!-- 전체 상품-->
                <div class="usr_selshop_usr_selshop_proList_3x3">
                    <ul id="defaultProduct" class="usr_selshop_proList">
                        <!-- <li>
            <div class="card_product">
              <span class="wrap_thumb">
                <img
                  cuimg=""
                  uselazyloading=""
                  class="img_g"
                  src="https://img1.kakaocdn.net/thumb/C306x306@2x.q82.fwebp/?fname=https%3A%2F%2Fst.kakaocdn.net%2Fproduct%2Fgift%2Fproduct%2F20230315154042_18142860e30348aa81b257f108b94c26.jpg"
                  alt="'숙면선물' 쿤달"
              /></span>
              <span class="wrap_info">
                <strong>
                  <a class="txt_brand">쿤달(리빙) 필로우미스트</a>
                </strong>
                <div>
                  <a class="txt_product"
                    >'숙면선물' 쿤달 릴랙싱 슬립 배럴 아로마 필로우미스트
                    150ml</a
                  >
                </div>
                <div class="txt_price">
                  <strong>¥<span class="txt_yen">2,500</span></strong
                  ><span class="txt_tax">税込</span>
                </div>
              </span>
            </div>
          </li> -->
                    </ul>
                </div>
                <!-- 전체 상품 끝 -->
                <!-- 더보기 -->
                <div style="display: none" id="moreProductWrap" class="usr_selshop_usr_selshop_proList_3x3">
                    <ul id="moreProduct" class="usr_selshop_proList"></ul>
                </div>
                <!-- 더보기 끝 -->
                <div id="more_button">
                    <button id="load" onclick="showMore()">▼ もっと見る</button>
                </div>
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
        // <img id="usrImage" src="/res/img/kej/스타벅스 로고.png" alt="슽아벅스" />
        //       </div>
        //       <div class="usr_selshop_coment">
        //         <h2 id="selShopname">슽아벅스</h2>
        //         <span id="selInfo"
        //seller 정보 가져오기
        const sellerInfo = JSON.parse('${sellerInfo}');
        console.log(sellerInfo);

        document.querySelector('#usrImage').src = sellerInfo.usrImage;
        document.querySelector('#selShopname').innerText = sellerInfo.selShopname;
        document.querySelector('#selInfo').innerText = sellerInfo.selInfo;

        // 최고 매출 상품 3가지

        let topThreeProducts;
        if ('${topThreeProducts}' !== '') {
            topThreeProducts = JSON.parse('${topThreeProducts}');
        }
        console.log('topThreeProducts: ');
        console.log(topThreeProducts);

        let topThreeProductsHTML = '';
        topThreeProducts.forEach((product, index) => {
            topThreeProductsHTML +=
                `
      <li><a href ="/product/` +
                sellerInfo.usrId +
                `/` +
                product.proCode +
                `" 
          <div class="card_product">
            <span class="wrap_thumb">
              <img
                cuimg=""
                uselazyloading=""
                class="img_g"
                src="` +
                (product.productImage.find(pig => pig.pigIsthumbnail === 'T') ? product.productImage[0].pigPath : '/res/img/whitebox_logo_p.png') +
                `"
                alt="` +
                (product.productImage.length === 0 ? '강한별빅토리' : product.productImage[0].pigName) +
                `"
            /></span>
            <span class="wrap_info"
              ><strong class="txt_ranking">` +
                (index + 1) +
                `</strong>
              <strong>
                <div class="txt_brand">` +
                product.proName +
                `</div>
              </strong>
              <div>
                <div class="txt_product"
                  >` +
                product.proInfo +
                `</div
                >
              </div>
              <div class="txt_price">
                <strong>¥<span class="txt_yen">` +
                product.proPrice +
                `</span></strong
                ><span class="txt_tax">税込</span>
              </div>
            </span>
          </div>
        </a>
        </li>
      `;
        });

        const usr_selshop_ranking_List = document.querySelector('.usr_selshop_ranking_List');
        usr_selshop_ranking_List.innerHTML = topThreeProductsHTML;

        // 전체 상품

        const productList = JSON.parse('${productList}');
        console.log(productList);

        const defaultProduct = document.querySelector('#defaultProduct');
        const moreProduct = document.querySelector('#moreProduct');
        let defaultProductHTML = '';
        let moreProductHTML = '';

        productList.forEach((product, index) => {
            let html = '';
            html +=
                `
		<li><a href ="/product/` +
                sellerInfo.usrId +
                `/` +
                product.proCode +
                `" 
            <div class="card_product">
              <span class="wrap_thumb">
                <img
                  cuimg=""
                  uselazyloading=""
                  class="img_g"
                  src="` +
                (product.productImage.find(pig => pig.pigIsthumbnail === 'T') ? product.productImage[0].pigPath : '/res/img/whitebox_logo_p.png') +
                `"
                  alt="` +
                (product.productImage.length === 0 ? '강한별빅토리' : product.productImage[0].pigName) +
                `"
              /></span>
              <span class="wrap_info">
                <strong>
                  <div class="txt_brand">` +
                product.proName +
                `</div>
                </strong>
                <div>
                  <div class="txt_product"
                    >` +
                product.proInfo +
                `</
                  >
                </div>
                <div class="txt_price">
                  <strong>¥<span class="txt_yen">` +
                product.proPrice +
                `</span></strong
                  ><span class="txt_tax">税込</span>
                </div>
              </span>
            </div>
            </a>
          </li>
		`;
            if (index > 8) {
                moreProductHTML += html;
            } else {
                defaultProductHTML += html;
            }
        });
        defaultProduct.innerHTML = defaultProductHTML;
        moreProduct.innerHTML = moreProductHTML;

        let isMoreVisible = false;
        function showMore() {
            isMoreVisible = !isMoreVisible;
            document.querySelector('#moreProductWrap').style.display = isMoreVisible ? 'block' : 'none';
            document.querySelector('#load').innerText = isMoreVisible ? '▲ 閉じる' : '▼ もっと見る';
        }
    </script>
</html>
