<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>ホワイトボックスセラー</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/seller/navbar.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/seller/footer.css" />
        <link rel="stylesheet" href="/res/css/seller/kej_selOrderList.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/seller/navbar.js"></script>
        <div class="ord_list_container">
            <header>
                <div class="ord_title">
                    <div class="ord_list_title">注文リスト</div>
                </div>
            </header>
            <section>
                <div class="Seller_info_table">
                    <table>
                        <tr>
                            <th scope="row">モール</th>
                            <td id="selShopname" colspan="3">shop_name</td>
                        </tr>
                        <tr>
                            <th scope="row">期間</th>
                            <td colspan="3">
                                <div class="Select_Period">
                                    <div class="Select_Period_button">
                                        <!-- 날짜 가져와서 넣어주기 -->
                                        <a onclick="setDate('day', null, null)"><span>今日</span></a>
                                        <a onclick="setDate('week', null, null)"><span>7日</span></a>
                                        <a onclick="setDate('month', null, null)"><span>一か月</span></a>
                                        <a onclick="setDate('halfYear', null, null)"><span>六か月</span></a>
                                    </div>
                                    <div class="Select_Period_Calendar">
                                        <input type="date" id="startDate" /> ~
                                        <input type="date" id="endDate" />
                                        <button onclick="setDate('period', this.parentNode.children[0].value, this.parentNode.children[1].value)">期間設定</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">検索語</th>
                            <td colspan="3">
                                <select class="select_period_box">
                                    <option value="pro_name">商品名</option>
                                    <option value="pro_code">商品コード</option>
                                </select>
                                <input class="select_period_box" type="text" id="search_box_a" onkeypress="if(event.keyCode === 13) { setQuery(); }"/>
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <button type="submit" class="period_sumimitbuttun" onclick="setQuery()">検索</button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="ord_pro_list">
                    <div class="ord_pro_totla">
                        <span>総注文件数</span>
                        <span id="orderListLength">0</span>
                        <span>個</span>
                    </div>
                    <table class="ord_pro_list_title">
                        <tr>
                            <td scope="col">注文日</td>
                            <td scope="col">注文者</td>
                            <td scope="col">商品名</td>
                            <td scope="col">商品情報</td>
                            <td scope="col">商品コード</td>
                            <td scope="col">総決済金額</td>
                            <td scope="col">決済手段</td>
                            <td scope="col">詳細照会</td>
                        </tr>
                    </table>
                    <table class="ord_pro_list_inner" id="ord_default_list"></table>
                    <div style="display: none" id="moreOrderWrap" class="usr_selshop_usr_selshop_proList_3x3">
                        <table class="ord_pro_list_inner" id="ord_more_list"></table>
                    </div>
                </div>
                <div id="more_button">
                    <button id="load" onclick="showMore()">▼ もっと見る</button>
                </div>
            </section>
        </div>
    <!--주문상세 모달-->
        <div id="modal" class="modal-overlay">
            <div class="modal-window">
              <div class="fri_title">
                <div class="close-area">X</div>
                <h2>注文の詳細</h2>
              </div>
              <div class="content">
                <table class="odt_modal_table"></table>
              </div>
            </div>
          </div>
      <!--주문상세 모달 종료-->
    </body>

        <!-- footer -->
    <footer class="footer_container"></footer>
    <script src='/res/js/seller/footer.js'></script>

    <script>
        // let userInfo;
        
        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
        }
        if (userInfo !== undefined) {
		changeNavbar(userInfo);
        const moveSellerProductListButton = document.querySelector('#moveSellerProductListButton');
        moveSellerProductListButton.href = '/seller/productList?proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=10';
	}
        
        let orderList;

        if ('${orderList}' !== '') {
            orderList = JSON.parse('${orderList}');
        }
        document.querySelector('#orderListLength').innerText = orderList.length;

        console.log(userInfo);
        console.log(orderList);
        
        document.querySelector('#selShopname').innerText = userInfo.selShopname;
        
        const defaultOrder = document.querySelector('#ord_default_list');
        const moreOrder = document.querySelector('#ord_more_list');
        
        //페이지 로딩시 실행
        const currentDate = new Date(); // 상세 현재 날짜

        const currentDate2 = new Date(); // 현재 날짜 시간은 0시
        currentDate2.setHours(0, 0, 0, 0);
        
        let parsedStartDate = new Date(currentDate2.getDate() - 7);
        let parsedEndDate = currentDate;
        let query = ''; //undefined
        let queryType = 'pro_name';
        
        makeOrderList();
        // 날짜 필터 함수
        function setDate(type, startDate, endDate) {
            // alert(type);
            console.log(type);
            switch (type) {
                case 'day':
                    console.log('day');
                    parsedStartDate = currentDate2;
                    parsedEndDate = currentDate;
                    console.log(parsedStartDate);
                    console.log(parsedEndDate);
                    makeOrderList();
                    break;
                case 'week':
                    console.log('week');
                    parsedStartDate = new Date(currentDate.getDate() - 7);
                    parsedEndDate = currentDate;
                    makeOrderList();
                    break;
                case 'month':
                    console.log('month');
                    parsedStartDate = new Date(currentDate.getMonth() - 1);
                    parsedEndDate = currentDate;
                    makeOrderList();
                    break;
                case 'halfYear':
                    console.log('halfYear');
                    parsedStartDate = new Date(currentDate.getMonth() - 6);
                    parsedEndDate = currentDate;
                    makeOrderList();
                    break;
                case 'period':
                    console.log('period');
                    parsedStartDate = new Date(startDate);
                    parsedStartDate.setHours(0, 0, 0, 0);
                    parsedEndDate = new Date(endDate);
                    console.log(orderList[0].ordDate);
                    console.log(new Date(orderList[0].ordDate));
                    if (parsedStartDate > parsedEndDate) {
                        alert('選択した日付をもう一度確認してください。');
                        return;
                    }
                    makeOrderList();
                    break;
            }
        }

        // 검색 함수
        const search_box = document.querySelector('#search_box_a');
        search_box.focus();
        const select_period_box = document.querySelector('.select_period_box');
        function setQuery() {
            console.log(search_box.value);
            console.log(select_period_box.value);

            query = search_box.value; //string
            queryType = select_period_box.value;
            makeOrderList();
        }

        function makeOrderList() {
            let defaultOrderHTML = '';
            let moreOrderHTML = '';

            let orderModal = '';

            orderList.forEach((order, index) => {
                let html = '';
                if (             
                    (
                        parsedStartDate <= new Date(order.ordDate)
                        && 
                        new Date(order.ordDate) <= parsedEndDate
                    ) 
                    && 
                    (
                        queryType === 'pro_name' 
                        ? 
                            order.orderDetail.find(
                            (orderDetail) => orderDetail.proName.toUpperCase().includes(query.toUpperCase())
                            ) 
                        :
                            order.orderDetail.find(
                            (orderDetail) => 
                            orderDetail.odtProcode.toString().padStart(4, '0') === query
                        )
                    )        
                ) {
                    html =
                        `
                                <tr>
                                    <td id="ordDate">` +
                        order.ordDate +
                        `</td>
                                    <td id="ordUsrmemid">` +
                        order.ordUsrmemid +
                        `</td>
                                    <td id="proName">` +
                        order.orderDetail[0].proName +
                        `</td>
                                    <td id="proInfo">` +
                        order.orderDetail[0].proInfo +
                        `</td>
                                    <td id="odtProcode">` +
                        order.orderDetail[0].odtProcode.toString().padStart(4, '0') +
                        `</td>
                                    <td id="proPrice">` +
                        order.orderDetail.reduce((sum, orderDetail) => {return sum + orderDetail.proPrice * orderDetail.odtQty }, 0) +
                        `円</td>
                                    <td>ペイパル</td>
                                    <td><button id="btn-modal" onclick="makeModal(` + index + `)">賞品 : ` + order.orderDetail.length + `個</button></td>
                                </tr>
                    `;
                    if (index > 9) {
                        moreOrderHTML += html;
                    } else {
                        defaultOrderHTML += html;
                    }
                }
            });

            defaultOrder.innerHTML = defaultOrderHTML;
            moreOrder.innerHTML = moreOrderHTML;
        }
        
        const modal = document.getElementById('modal');
        function makeModal(index) {
            modal.style.display = 'flex';
            console.log('index: ' + index);
            let order = orderList[index];
            console.log('selected order: ' + order);
            let html = 
            `
                <tr>
                    <th id="modalProName">商品名</th>
                    <th>商品コード</th>
                    <th>数量</th>
                    <th>価格</th>
                    <th>合計金額</th>
                </tr>
            `;
            order.orderDetail.forEach(orderDetail => {
                html += 
                `
                    <tr>
                        <td>` + orderDetail.proName + `</td>
                        <td>` + orderDetail.odtProcode.toString().padStart(4, '0') + `</td>
                        <td>` + orderDetail.odtQty + `個</td>
                        <td>` + orderDetail.proPrice + `円</td>
                        <td>` + orderDetail.proPrice * orderDetail.odtQty  + `円</td>
                    </tr>
                `;
            }); 
            document.querySelector('.odt_modal_table').innerHTML = html;


        }
        let isMoreVisible = false;
        function showMore() {
            isMoreVisible = !isMoreVisible;
            document.querySelector('#moreOrderWrap').style.display = isMoreVisible ? 'block' : 'none';
            document.querySelector('#load').innerText = isMoreVisible ? '▲ 閉じる' : '▼ もっと見る';
        }

        const closeBtn = modal.querySelector('.close-area');
        closeBtn.addEventListener('click', (e) => {
            modal.style.display = 'none';
        });
    </script>
</html>
