let userInfo;
const navbar = document.querySelector('.navbar');

window.addEventListener('scroll', () => {
  let nVScroll = document.documentElement.scrollTop || document.body.scrollTop;
  if (nVScroll > 1) {
    navbar.style.boxShadow = '0 5px 5px 0 rgba(0, 0, 0, 0.3)';
  } else {
    navbar.style.removeProperty('box-shadow');
  }
});

const navbarBefore = `
  <div class="navbar_container">
        <div class="navbar_logo">
            <a href="#" class="navbar_toogleBtn">
                <i class="fa-solid fa-bars"></i>
            </a>
            <a href="/seller/home">White Box</a>
        </div>
        <ul class="navbar_menu">
            <li><a href="/seller/home" id="moveSellerProductListButton">商品リスト</a></li>
            <li><a href="/seller/proRegist">商品登録</a></li>
            <li><a href="/seller/selOrderlist">注文管理</a></li>
            <li><a href="/seller/home">統計情報</a></li>
            <li><a href="/seller/storeInfo">ストア情報</a></li>
        </ul>
    </div>
    <ul class="navbar_links">
      <li class="search">
        <i class="fa-solid fa-magnifying-glass" style="color: #161616"></i>
      </li>
      <li class="report">
        <i class="fa-regular fa-bell" style="color: #161616"></i>
      </li>
      <li class="join"><a href="/sellerSignUp">会員加入</a></li>
      <li class="login"><a href="/sellerLogin">ログイン</a></li>
    </ul>
`;
const navbarAfter = `
	  	<div class="navbar_container">
			<div class="navbar_logo">
				<a href="#" class="navbar_toogleBtn">
					<i class="fa-solid fa-bars"></i>
				</a>
				<a href="/seller/home">White Box</a>
			</div>
			<ul class="navbar_menu">
				<li><a href="/seller/home" id="moveSellerProductListButton">商品リスト</a></li>
				<li><a href="/seller/proRegist">商品登録</a></li>
				<li><a href="/seller/selOrderlist">注文管理</a></li>
				<li><a href="/seller/home">統計情報</a></li>
				<li><a href="/seller/storeInfo">ストア情報</a></li>
			</ul>
		</div>
		<ul class="navbar_links">
			<li class="search">
				<i class="fa-solid fa-magnifying-glass" style="color: #161616"></i>
			</li>
			<li class="report">
				<i class="fa-regular fa-bell" style="color: #161616"></i>
			</li>
			<li class="login"><a href="/seller/logout">ログオフ</a></li>
			<li>
        <a href="/seller/home">
          <div class="navbar_profile_wrap"><img class="navbar_profile_image" /></div>
          </a>
			</li>
		</ul>
`;

navbar.innerHTML = navbarBefore;

let navbar_profile_image;
let moveSellerProductListButton;
function changeNavbar(userInfo) {
  navbar.innerHTML = navbarAfter;
  navbar_profile_image = document.querySelector('.navbar_profile_image');
  navbar_profile_image.src = userInfo.usrImage;
  moveSellerProductListButton = document.querySelector('#moveSellerProductListButton');
  moveSellerProductListButton.href = '/seller/productList?proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=10';

}

