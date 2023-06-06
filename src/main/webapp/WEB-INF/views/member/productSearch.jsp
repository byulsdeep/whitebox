<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>WhiteBox</title>
    <link rel="stylesheet" href="/res/css/member/yeong_style.css" />
    <link rel="stylesheet" href="/res/css/reset.css" />
	<link rel="stylesheet" href="/res/css/member/navbar.css" />
    <link rel="stylesheet" href="/res/css/member/footer.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
  </head>
  <body>
    <!-- NAVBAR -->
    <nav class="navbar"></nav>
    <!-- NAVBAR JS -->
    <script src="/res/js/member/navbar.js"></script>
    <div class="product_search_wrap">
      <div class="product_search_wrap_head">
        <div class="product_search_wrap_head_top">
          <label for="product_name">商品名</label><input class="product_search_wrap_head_top_name" type="text" name="product_name">
          
          <label for="product_category">カテゴリー</label>
          <select name="product_category" class="product_search_wrap_head_top_category">
            <option></option>
            <option value="CC">ファッション</option>
            <option value="CE">電子機器</option>
            <option value="CB">誕生日</option>
            <option value="CM">結婚</option>
            <option value="CL">キッズ</option>
            <option value="CH">名品</option>
            <option value="CP">健康</option>
            <option value="CS">軽い贈り物</option>
            <option value="CT">スモールラグジュアリー</option>
            <option value="CC">応援</option>
          </select>
        </div>

        <div class="product_search_wrap_head_bottom">
          <p class="product_search_wrap_head_bottom_price">
            値段
          </p>
          <div slider id="slider-distance">
            <div>
              <div inverse-left style="width:70%;"></div>
              <div inverse-right style="width:70%;"></div>
              <div range style="left:30%; right:40%;"></div>
              <span thumb style="left:30%;"></span>
              <span thumb style="left:60%;"></span>
            </div>
            <input type="range" tabindex="0" value="30" max="100" min="0" step="1" oninput="productSearchRangeInput(this)" />
          
            <input type="range" tabindex="0" value="60" max="100" min="0" step="1" oninput="productSearchRangeInput2(this)" />
          </div>
          <div class="product_search_wrap_head_bottom_price_min">
            <input class="product_search_wrap_head_bottom_price_min_input" type="text" value="">
            <p>円</p>
          </div>
          <div class="product_search_wrap_head_bottom_price_max">
            <input class="product_search_wrap_head_bottom_price_max_input" type="text" value="">
            <p>円</p>
          </div>
          <button class="product_search_wrap_head_button button" onclick="productSearch()">
            検索
          </button>
        </div>
          <div class="product_search_wrap_order">
            <div class="active" onclick="productSearchWrapOrder(this)">新着順</div>
            <div onclick="productSearchWrapOrder(this)">販売順</div>
            <div onclick="productSearchWrapOrder(this)">安い順</div>
            <div onclick="productSearchWrapOrder(this)">高い順</div>
          </div>
        </div>
      <div class="product_search_wrap_content">
        <div>検索して下さい。</div>
      </div>
      <div class="product_search_wrap_content_more" onclick="productSearchContentView()">
        もっと見る
      </div>
    </div>
    <footer class="footer_container"></footer>
    <script src="/res/js/member/footer.js"></script>
  </body>
  <script src="/res/js/member/yeong_main.js"></script>
  <script src="/res/js/projectUtils.js"></script>
  <script>
    let userInfo;
    if ('${userInfo}' !== '') {
      userInfo = JSON.parse('${userInfo}');
      }
  
if (userInfo !== undefined) {
	changeNavbar(userInfo);
}

  </script>
</html>
