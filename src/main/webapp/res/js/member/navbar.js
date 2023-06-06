const navbar = document.querySelector('.navbar');

window.addEventListener('scroll', ()=>{
	  let nVScroll =
	  document.documentElement.scrollTop || document.body.scrollTop;
	if (nVScroll > 1) {
		navbar.style.boxShadow = "0 5px 5px 0 rgba(0, 0, 0, 0.3)";
	} else {
		navbar.style.removeProperty("box-shadow");
	}
});

const navbarBefore = `
  <div class="navbar_container">
        <div class="navbar_logo">
            <a href="#" class="navbar_toogleBtn">
                <i class="fa-solid fa-bars"></i>
            </a>
            <a href="/">White Box</a>
        </div>
        <ul class="navbar_menu">
            <li><a href="/">Home</a></li>
            <li><a href="">Best</a></li>
            <li><a href="/member/myPage/friendList">友達リスト</a></li>
            <li><a href="/member/myPage/giftHistory">ギフトボックス</a></li>
            <li><a href="">カテゴリー</a></li>
        </ul>
    </div>
    <ul class="navbar_links">
    	<li class="navbar_cart">
        <a href="/member/cart">
          <i class="fa-solid fa-gift" style="color: #161616"></i>
        </a>
			</li>
      <li class="search">
        <i class="fa-solid fa-magnifying-glass" style="color: #161616"></i>
      </li>
      <li class="report">
        <i class="fa-regular fa-bell" style="color: #161616"></i>
      </li>
      <li class="join"><a href="/memberSignUp">会員加入</a></li>
      <li class="login"><a href="/login">ログイン</a></li>
    </ul>
`;

const navbarAfter = `
	  	<div class="navbar_container">
			<div class="navbar_logo">
				<a href="#" class="navbar_toogleBtn">
					<i class="fa-solid fa-bars"></i>
				</a>
				<a href="/">White Box</a>
			</div>
			<ul class="navbar_menu">
          <li><a href="/">Home</a></li>
          <li><a href="">Best</a></li>
          <li><a href="/member/myPage/friendList">友達リスト</a></li>
          <li><a href="/member/myPage/giftHistory">ギフトボックス</a></li>
          <li><a href="">カテゴリー</a></li>
			</ul>
		</div>
		<ul class="navbar_links">
			<li class="navbar_cart">
        <a href="/member/cart">
          <i class="fa-solid fa-gift" style="color: #161616"></i>
        </a>
			</li>
			<li class="search">
				<i class="fa-solid fa-magnifying-glass" style="color: #161616"></i>
			</li>
			<li class="report" onclick="toggleNotification()">
				<i class="fa-regular fa-bell" style="color: #161616"></i>
			</li>
			<li class="login"><a href="/logout">ログオフ</a></li>
			<li><a href="/member/myPage"><div class="navbar_profile_wrap"><img class="navbar_profile_image" /></div></a>
			</li>
		</ul>
`;

navbar.innerHTML = navbarBefore;

let navbar_profile_image;

function changeNavbar(userInfo) {
  navbar.innerHTML = navbarAfter;
  navbar_profile_image = document.querySelector('.navbar_profile_image');
  navbar_profile_image.src = userInfo.usrImage;
}

let notificationVisible = false;
function toggleNotification() {
  notificationVisible = !notificationVisible;
  document.querySelector('.notification_modal').style.display = notificationVisible ? 'flex' : 'none';
  document.querySelector('.fa-bell').className = notificationVisible ? 'fa-solid fa-bell' : 'fa-regular fa-bell';
}
let notificationInfo;
let giftNotificationInfo;

function makeNotification() {
    console.log('make notification starts')
    let html = '';
    let i = 0;
    notificationInfo.forEach((notification, index) => {
        if (notification.friState === 'FA') {
            html += `
                <div class="notification_modal_feed">
                    <div class="notification_modal_message_wrap">
                        <div class="notification_modal_profile_image_wrap">
                            <img class="notification_modal_profile_image" src="` + notification.usrImage + `"/>
                        </div>
                        <div class="notification_modal_message">
                            ` + notification.usrLastname + ` ` + notification.usrFirstname + ` さんとフレンドになりました!
                        </div>
                    </div>    
                        <div class="notification_modal_buttons_wrap">
                            <button onclick="confirmRequestAjax(` + index + `)" class="notification_modal_button">確認</button>
                        </div>
                </div>                
            `;
        } else if (notification.friState === 'FS') {
            html += `
                <div class="notification_modal_feed">
                    <div class="notification_modal_message_wrap">
                        <div class="notification_modal_profile_image_wrap">
                            <img class="notification_modal_profile_image" src="` + notification.usrImage + `"/>
                        </div>
                        <div class="notification_modal_message">
                            ` + notification.usrLastname + ` ` + notification.usrFirstname + ` さんからフレンドリクエストが届きました!
                        </div>
                    </div>   
                    <div class="notification_modal_buttons_wrap">
                        <button onclick="acceptRequestAjax(` + index + `)" class="notification_modal_button">承諾</button>
                        <button onclick="declineRequestAjax(` + index + `)" class="notification_modal_button">拒否</button>
                    </div>
                </div>                  
            `;
        }
        i = index;
        console.log(i)
        console.log(index)
    });
    document.querySelector('.notification_modal_content').innerHTML = html;
    if (notificationInfo.length === 0) {
        document.querySelector('.notification_modal_content').innerHTML = 
        `
            <div class="notification_modal_feed">
                <div class="notification_modal_message_wrap">
                    <div class="notification_modal_profile_image_wrap">
                        <img class="notification_modal_profile_image" src="/res/img/whitebox_logo_p.png" />
                    </div>
                    <div class="notification_modal_message">White Boxへようこそ</div>
                </div>
            </div>        
        `;
    }
    console.log('make notification ends')
}
function makeGiftNotification() {
    console.log('make giftNotification starts')
    let html = '';
    let i = 0;
    giftNotificationInfo.forEach((notification, index) => {
            html += `
                <div class="notification_modal_feed">
                    <div class="notification_modal_message_wrap">
                        <div class="notification_modal_profile_image_wrap">
                            <img class="notification_modal_profile_image" src="` + notification.usrImage + `"/>
                        </div>
                        <div class="notification_modal_message">
                            ` + notification.usrLastname + ` ` + notification.usrFirstname + ` さんからプレゼントが届きました!
                        </div>
                    </div>    
                        <div class="notification_modal_buttons_wrap">
                            <button onclick="confirmGift(` + index + `)" class="notification_modal_button">ギフトボックスへ</button>
                        </div>
                </div>                
            `;
        i = index;
        console.log(i)
        console.log(index)
    });
    document.querySelector('.notification_modal_content').innerHTML += html;
    console.log('make notification ends')
}
function confirmGift(index) {
    const notification = giftNotificationInfo[index];
    const keys = ['odtOrddate', 'odtOrdmemid', 'odtProusrselid', 'odtProcode', 'odtMemrecipient'];
    const values =[notification.odtOrddate, notification.odtOrdmemid, notification.odtProusrselid, notification.odtProcode, notification.odtMemrecipient];
    console.log('formData:')
    console.log(makeFormData(keys, values));
    sendAjaxPost('/member/myPage/confirmGiftAjax', makeFormData(keys, values), 'moveToGiftBox');
}
function moveToGiftBox() {
    window.location.href = '/member/myPage/giftHistory/';
}
function acceptRequestAjax(index) {
    const notification = notificationInfo[index];
    const keys = ['friSender', 'friReceiver'];
    const values = [notification.friSender, notification.friReceiver];
    sendAjaxPost('/member/myPage/acceptRequestAjax', makeFormData(keys, values), 'resetNotificationInfo');
}
function declineRequestAjax(index) {
    const notification = notificationInfo[index];
    const keys = ['friSender', 'friReceiver'];
    const values = [notification.friSender, notification.friReceiver];
    sendAjaxPost('/member/myPage/declineRequestAjax', makeFormData(keys, values), 'resetNotificationInfo');
}
function confirmRequestAjax(index) {
    const notification = notificationInfo[index];
    const keys = ['friSender', 'friReceiver'];
    const values = [notification.friSender, notification.friReceiver];
    sendAjaxPost('/member/myPage/confirmRequestAjax', makeFormData(keys, values), 'resetNotificationInfo');
}
function resetNotificationInfo(data) {
    console.log('oroginal data:')
    console.log(notificationInfo)
    console.log('returned data:')
    console.log(data);
    notificationInfo = data;
    console.log('replaced notification info: ')
    console.log(notificationInfo)
    makeNotification();
    makeGiftNotification();
    console.log('reset notification ended')
}