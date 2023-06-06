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
        <link rel="stylesheet" href="/res/css/seller/navbar.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/seller/footer.css" />
        <link rel="stylesheet" href="/res/css/seller/BYUL_productList.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/seller/navbar.js"></script>
        <div class="main">
            <div class="title">商品リスト</div>
            <div class="product_count">全体0件</div>

            <div class="search_wrap">
                <div class="search_by_name">
                    <div>商品名</div>
                    <div>
                        <input class="search_box" name="query" placeholder="商品名または内容をご入力ください" onkeypress="if(event.keyCode === 13) { selectProductByPageAndQuery(); }" />
                    </div>
                </div>
                <div class="search_by_category">
                    <div>商品カテゴリ</div>
                    <div>
                        <select class="search_box" name="proCatcode">
                            <option value="">カテゴリをご宣託ください</option>
                            <option value="CC">ファション</option>
                            <option value="CE">電子機器</option>
                            <option value="CB">誕生日</option>
                            <option value="CM">結婚/新築祝い</option>
                            <option value="CK">出産/キッズ</option>
                            <option value="CL">名品</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="search_button_wrap">
                <button id="search_button" onclick="selectProductByPageAndQuery()">検索</button>
                <button id="reset_button" onclick="reset()">リセット</button>
            </div>
            <table class="product_list_table"></table>
            <div class="page_buttons_wrap"></div>
        </div>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/seller/footer.js"></script>
        <!-- modal starts here -->
        <div class="modal">
            <div class="modal_top_bar">
                <div class="modal_top_bar_title">商品情報</div>
                <div class="modal_top_bar_exit_button" onclick="closeModal()">
                    <i class="fa-solid fa-x"></i>
                </div>
            </div>
            <div class="modal_content">
                <div class="modal_product_img_info">
                    <div class="modal_product_img">
                        <!-- card starts here -->
                        <div class="card_product">
                            <span class="wrap_thumb">
                                <img cuimg="" uselazyloading="" class="img_g" src="https://img1.kakaocdn.net/thumb/C306x306@2x.q82.fwebp/?fname=https%3A%2F%2Fst.kakaocdn.net%2Fproduct%2Fgift%2Fproduct%2F20230315154042_18142860e30348aa81b257f108b94c26.jpg" alt="'숙면선물' 쿤달" />
                            </span>
                            <span class="wrap_info">
                                <!-- <strong class="txt_ranking">1</strong> -->
                                <strong>
                                    <a class="txt_brand">쿤달(리빙) 필로우미스트</a>
                                </strong>
                                <div>
                                    <a class="txt_product">'숙면선물' 쿤달 릴랙싱 슬립 배럴 아로마 필로우미스트 150ml</a>
                                </div>
                                <div class="txt_price">
                                    <strong> ¥<span class="txt_yen">2,500</span> </strong>
                                    <span class="txt_tax">税込</span>
                                </div>
                            </span>
                        </div>
                        <!-- card ends here -->
                        <div class="modal_product_non_thumbnail_images"></div>
                    </div>
                    <div class="modal_product_info">
                        <form action="updateProduct" method="post">
                            <div class="modal_product_info_top">
                                <table>
                                    <tr>
                                        <th>商品コード</th>
                                        <th>カテゴリ</th>
                                        <th>商品名</th>
                                        <th>価格</th>
                                        <th>在庫</th>
                                    </tr>
                                    <tr>
                                        <td><input id="modal_product_info_proCode" class="modal_product_info_input" disabled /></td>
                                        <td>
                                            <select id="modal_product_info_catName" class="modal_product_info_input" disabled>
                                                <option value="CC">ファション</option>
                                                <option value="CE">電子機器</option>
                                                <option value="CB">誕生日</option>
                                                <option value="CM">結婚/新築祝い</option>
                                                <option value="CK">出産/キッズ</option>
                                                <option value="CL">名品</option>
                                            </select>
                                        </td>
                                        <td><input id="modal_product_info_proName" class="modal_product_info_input" disabled /></td>
                                        <td><input type="number" id="modal_product_info_proPrice" class="modal_product_info_input" disabled /></td>
                                        <td><input type="number" id="modal_product_info_proStock" class="modal_product_info_input" disabled /></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="modal_product_info_bottom">
                                <textarea id="modal_product_info_proInfo" disabled></textarea>
                            </div>
                        </form>
                        <div class="modal_product_info_button_wrap">
                            <button class="modal_product_info_button" onclick="enableUpdate()">修正</button>
                            <button style="display: none" class="modal_product_info_button" onclick="updateProduct()">保存</button>
                            <button class="modal_product_info_button" onclick="closeModal()">戻る</button>
                            <button class="modal_product_info_button" onclick="deleteProduct()">削除</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal ends here -->
    </body>
    <script src="/res/js/projectUtils.js"></script>
    <script>
        // 검색 기능
        function selectProductByPageAndQuery() {
            window.location.href = '/seller/productList?query=' + document.querySelectorAll('[name="query"]')[0].value + '&proCatcode=' + document.querySelectorAll('[name="proCatcode"]')[0].value + '&proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=' + itemsPerPage;
        }

        // 초기화 기능
        function reset() {
            window.location.href = '/seller/productList?proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=10';
        }

        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
        }
        console.log(userInfo);
        // 로그인이고 회원가입후가 아닐 시
        if (userInfo !== undefined) {
            // navbar 변경
            changeNavbar(userInfo);
            // navbar의 상품리스트 버튼에 주소 부여
        }

        // 브라우저 주소창에서 검색어, 카테고리 정보가 "있으면" 가져와서 검색창과 카테고리창을 갱신해줌.
        // 검색요청 할 때 페이지가 리로드 돼서 검색창과 카테고리창 내용이 초기화됨.
        // 그래서 검색창과 카테고리창에 값을 다시 넣어줌.
        const query = '${param.query}'; // 검색어
        const proCatcode = '${param.proCatcode}'; // 카테고리
        const searchBox1 = document.querySelectorAll('.search_box')[0]; // 검색창
        const searchBox2 = document.querySelectorAll('.search_box')[1]; // 카테고리창
        searchBox1.value = query;
        searchBox2.value = proCatcode;

        // 페이징 구현
        // 브라우저 주소창에서 현재 페이지와 페이지당 보일 상품 개수 규칙을 가져옴
        const currentPage = Number('${param.currentPage}');
        const itemsPerPage = Number('${param.itemsPerPage}');
        const page_buttons = document.querySelector('.page_buttons_wrap'); // 페이징을 구현 할 div

        // << < 버튼은 현재 페이지가 1페이지가 아닐 경우 만듬
        if (currentPage > 1) page_buttons.innerHTML += '<a class="first page_button" href="/seller/productList?query=' + query + '&proCatcode=' + proCatcode + '&proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=10">&lt;&lt;</a>' + '<a class="prev page_button" href="/seller/productList??query=' + query + '&proCatcode=' + proCatcode + '&proUsrselid=' + userInfo.usrId + '&currentPage=' + (currentPage - 1) + '&itemsPerPage=10">&lt;</a>';
        // 数字ボタン, 現在ページ class -> current
        const productCount = Number('${productCount}'); // 백에서 따로 가져온 전체 상품 개수
        const pageCount = Math.ceil(productCount / itemsPerPage); // 전체 상품 개수를 페이지 당 보여줄 상품 개수로 나눠서 구현해야할 페이지 개수를 구한다
        page_buttons.innerHTML += Array.from({ length: pageCount }, (_, i) => '<a class="page_button' + (i + 1 === currentPage ? ' current' : '') + '" href="/seller/productList?query=' + query + '&proCatcode=' + proCatcode + '&proUsrselid=' + userInfo.usrId + '&currentPage=' + (i + 1) + '&itemsPerPage=10">' + (i + 1) + '</a>').join('');
        // > >> ボタン
        if (currentPage < pageCount) page_buttons.innerHTML += '<a class="next page_button" href="/seller/productList?query=' + query + '&proCatcode=' + proCatcode + '&proUsrselid=' + userInfo.usrId + '&currentPage=' + (currentPage + 1) + '&itemsPerPage=10">&gt;</a>' + '<a class="last page_button" href="/seller/productList?query=' + query + '&proCatcode=' + proCatcode + '&proUsrselid=' + userInfo.usrId + '&currentPage=' + pageCount + '&itemsPerPage=10">&gt;&gt;</a>';

        // 상품 리스트 구현
        let productList;
        const product_count = document.querySelector('.product_count');
        const table = document.querySelector('.product_list_table');
        if ('${productListByPage}' !== '') {
            productList = JSON.parse('${productListByPage}'); // 백에서 가져온 상품 데이터
            console.log(productList);
            refresh();
        }
        function refresh() {
            console.log('refresh starting');
            product_count.innerText = '全体' + productCount + '件'; // 상품 개수

            table.innerHTML = `
            <tr>
                <th>NO</th>
                <th>商品コード</th>
                <th>商品カテゴリ</th>
                <th>商品名</th>
                <th>販売価格</th>
                <th>在庫</th>
                <th>商品情報</th>
                <th>購買 URL</th>
            </tr>
    `;

            let html = '';
            let index = 0;
            let reverseIndex = productList.length;
            productList.forEach(product => {
                html += '<tr>';
                html += '<td>' + reverseIndex-- + '</td>'; // 거꾸로 정렬
                html += '<td>' + product.proCode.toString().padStart(4, '0') + '</td>'; // 출력 형식 변경 1 -> 0001
                html += '<td>' + product.catName + '</td>';
                html += '<td>' + product.proName + '</td>';
                html += '<td>￥' + product.proPrice + '</td>';
                html += '<td>' + product.proStock + '</td>';
                html += '<td><button onclick="openModal(' + index++ + ')">商品情報</button></td>'; // 상품 정보, 사진, 판매자 상품 상세로 이동할 버튼이 있는 모달 창을 만들어주는 함수
                html += '<td class="td_url"><input value="http://localhost/product/' + product.proUsrselid + '/' + product.proCode + '" /><button>URL コピー</button>';
                html += '</tr>'; // 구매자 상품 상세 이동 링크
            });
            table.innerHTML += html;
        }
        // 모달창 구현
        const modal = document.querySelector('.modal');

        // 카드
        const img_g = document.querySelector('.img_g'); // 이미지
        const txt_brand = document.querySelector('.txt_brand'); // 상품명
        const txt_product = document.querySelector('.txt_product'); // 정보
        const txt_yen = document.querySelector('.txt_yen'); //가격
        // 테이블
        const modal_product_info_proCode = document.querySelector('#modal_product_info_proCode');
        const modal_product_info_catName = document.querySelector('#modal_product_info_catName');
        const modal_product_info_proName = document.querySelector('#modal_product_info_proName');
        const modal_product_info_proPrice = document.querySelector('#modal_product_info_proPrice');
        const modal_product_info_proStock = document.querySelector('#modal_product_info_proStock');
        const modal_product_info_proInfo = document.querySelector('#modal_product_info_proInfo');

        // 섬네일 아닌 사진들
        const modal_product_non_thumbnail_images = document.querySelector('.modal_product_non_thumbnail_images');
        // 상품 수정 활성화, 저장, 돌아가기 버튼
        const modal_product_info_button = document.querySelectorAll('.modal_product_info_button');

        function openModal(index) {
            modal.style.display = 'flex';
            const product = productList[index];
            // 카드
            if (product.productImage.length !== 0) {
                product.productImage.forEach(pig => {
                    if (pig.pigIsthumbnail === 'T') {
                        img_g.src = pig.pigPath;
                        return;
                    }
                });
            } else {
                img_g.src = '/res/img/whitebox_logo_p.png';
            }

            txt_brand.innerText = product.proName;
            txt_product.innerText = product.proInfo;
            txt_yen.innerText = product.proPrice;
            // 상품 정보 미니 테이블
            modal_product_info_catName.setAttribute('disabled', true);
            modal_product_info_proName.setAttribute('disabled', true);
            modal_product_info_proPrice.setAttribute('disabled', true);
            modal_product_info_proStock.setAttribute('disabled', true);
            modal_product_info_proInfo.setAttribute('disabled', true);

            modal_product_info_proCode.value = product.proCode.toString().padStart(4, '0');
            modal_product_info_catName.value = product.proCatcode;
            modal_product_info_proName.value = product.proName;
            modal_product_info_proPrice.value = product.proPrice;
            modal_product_info_proStock.value = product.proStock;
            modal_product_info_proInfo.value = product.proInfo;

            // 섬네일 아닌 사진들
            let html = '<div class=""></div>'; // + 버튼
            product.productImage
                .filter(pig => pig.pigIsthumbnail === 'F')
                .forEach(pig => {
                    html += '<img src="' + pig.pigPath + '"/>';
                });

            modal_product_non_thumbnail_images.innerHTML = html;

            // 상품 수정 버튼 -> enableUpdate()
            // modal_product_info_button.setAttribute('onclick', 'updateProduct(' + index + ')');
        }
        function closeModal() {
            // 닫기 버튼
            document.querySelector('.modal').style.display = 'none';
        }
        function updateProduct() {
            const keys = ['proCode', 'proCatcode', 'proName', 'proPrice', 'proStock', 'proInfo'];
            const values = [modal_product_info_proCode.value, modal_product_info_catName.value, modal_product_info_proName.value, modal_product_info_proPrice.value, modal_product_info_proStock.value, modal_product_info_proInfo.value];

            const formData = makeFormData(keys, values);
            console.log(formData);

            sendAjaxPost('updateProduct', formData, 'updateProductCallBack');
        }
        function updateProductCallBack(data) {
            console.log('back');
            console.log(data);
            productList = productList.map(product => {
                if (product.proCode === data.proCode) {
                    return data;
                }
                return product;
            });
            console.log('productList after iteration: ');
            console.log(productList);
            disableUpdate();
            refresh();
        }
        function deleteProduct() {
            const key = 'proCode';
            const value = Number(modal_product_info_proCode.value);
            const formData = makeFormData(key, value);
            console.log(formData);
            sendAjaxPost('deleteProduct', formData, 'deleteProductCallBack');
        }
        function deleteProductCallBack(data) {
            console.log('back from delete');
            console.log(data);
            productList = productList.filter(product => product.proCode !== data.proCode);
            console.log('refreshed productList: ');
            console.log(productList);
            refresh();
            closeModal();
        }
        function enableUpdate() {
            // 수정 활성화
            modal_product_info_catName.removeAttribute('disabled');
            modal_product_info_proName.removeAttribute('disabled');
            modal_product_info_proPrice.removeAttribute('disabled');
            modal_product_info_proStock.removeAttribute('disabled');
            modal_product_info_proInfo.removeAttribute('disabled');
            // 저장 버튼 활성화
            modal_product_info_button[1].style.display = 'block';
        }
        function disableUpdate() {
            modal_product_info_catName.setAttribute('disabled', true);
            modal_product_info_proName.setAttribute('disabled', true);
            modal_product_info_proPrice.setAttribute('disabled', true);
            modal_product_info_proStock.setAttribute('disabled', true);
            modal_product_info_proInfo.setAttribute('disabled', true);
            modal_product_info_button[1].style.display = 'none';
        }
        /*
파일 경로 
    /res/img/productImg/판매자id/상품코드/original/파일이름.png 원본
    /res/img/productImg/판매자id/상품코드/small/파일이름.png    대량 출력용 저화질 변환물

남은 할일:
    상품 이미지 추가/삭제 ajax로 구현 
*/
    </script>
</html>
