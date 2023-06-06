<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>商品登録</title>
        <script src="https://kit.fontawesome.com/e59267a363.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/res/css/reset.css" />
        <!-- navbar CSS -->
        <link rel="stylesheet" href="/res/css/seller/navbar.css" />
        <!-- footer css-->
        <link rel="stylesheet" href="/res/css/seller/footer.css" />
        <link rel="stylesheet" href="/res/css/seller/hh_selProductRegist.css" />
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar"></nav>
        <!-- NAVBAR JS -->
        <script src="/res/js/seller/navbar.js"></script>
        <hr />
        <h1 class="pro_title">商品登録</h1>
        <div class="pro_info">
            <form id="pro_form" class="pro_form" action="/seller/proRegist" method="post" enctype="multipart/form-data">
                <div class="pro_info_box">
                    <div class="pro_info_name">
                        <label for="proName">商品名</label>
                    </div>
                    <div class="pro_info_contents">
                        <input type="text" id="proName" name="proName" placeholder="商品名を入力しなさい。" />
                    </div>
                </div>
                <div class="pro_info_box">
                    <div class="pro_info_name">
                        <label for="proCatcode">カテゴリー</label>
                    </div>
                    <div class="pro_info_contents">
                        <select name="proCatcode">
                            <option value="CC">ファッション</option>
                            <option value="CE">電子機器</option>
                            <option value="CB">誕生日</option>
                            <option value="CM">結婚/引っ越し祝い</option>
                            <option value="CK">出産/キッズ</option>
                            <option value="CL">ブランド</option>
                        </select>
                    </div>
                </div>
                <div class="pro_info_box">
                    <div class="pro_info_name">
                        <label for="proPrice">価格</label>
                    </div>
                    <div class="pro_info_contents">
                        <input type="text" id="proPrice" name="proPrice" placeholder="商品価格を数字で入力しなさい。" />
                    </div>
                </div>
                <div class="pro_info_box">
                    <div class="pro_info_name">
                        <label for="proStock">在庫</label>
                    </div>
                    <div class="pro_info_contents">
                        <input type="text" id="proStock" name="proStock" placeholder="商品在庫を数字で入力しなさい。" />
                    </div>
                </div>
                <div class="pro_info_box">
                    <div class="pro_info_name">
                        <label for="proInfo">商品情報</label>
                    </div>
                    <div class="pro_info_contents">
                        <textarea id="proInfo" name="proInfo" placeholder="商品情報を入力しなさい。" style="height: 200px"></textarea>
                    </div>
                </div>
                <div class="pro_info_box">
                    <div class="pro_info_name">
                        <label for="productImage">商品のイメージ</label>
                    </div>
                    <div class="pro_info_contents">
                        <div class="pro_image_container">
                            <div class="pro_image_item empty">
                                <div class="empty-text">X</div>
                            </div>
                        </div>
                        <input type="file" name="proImage" multiple />
                        <input type="hidden" name="productThumbnail" value="" />
                    </div>
                </div>
                <input type="submit" onclick="showAlert(event)" value="登録" />
            </form>
        </div>
        <div class="pro_image_container"></div>
        <!-- footer -->
        <footer class="footer_container"></footer>
        <script src="/res/js/seller/footer.js"></script>
    </body>
    <script>
        if ('${message}' !== '') {
            alert('${message}');
        }

        if ('${userInfo}' !== '') {
            userInfo = JSON.parse('${userInfo}');
            changeNavbar(userInfo);
        }
        function showAlert(event) {
            const proName = document.querySelector('#proName');
            const proPrice = document.querySelector('#proPrice');
            const proStock = document.querySelector('#proStock');
            const proInfo = document.querySelector('#proInfo');

            /* NULL확인 */ // proName proPrice proStock proInfo
            let isValid = [false, false, false, false];

            function validateProName() {
                if (!proName.value) {
                    isValid[0] = false;
                    return;
                }
                isValid[0] = true;
            }

            function validateProPrice() {
                const format = /^[0-9]+$/;
                if (!proPrice.value) {
                    isValid[1] = false;
                    return;
                } else if (!format.test(proPrice.value)) {
                    alert('가격을 숫자로 입력해주세요.');
                    isValid[1] = false;
                    return;
                }
                isValid[1] = true;
            }

            function validateProStock() {
                const format = /^[0-9]+$/;
                if (!proStock.value) {
                    isValid[2] = false;
                    return;
                } else if (!format.test(proStock.value)) {
                    alert('재고를 숫자로 입력해주세요.');
                    isValid[2] = false;
                    return;
                }
                isValid[2] = true;
            }

            function validateProInfo() {
                if (!proInfo.value) {
                    isValid[3] = false;
                    return;
                }
                isValid[3] = true;
            }

            function proValidate() {
                if (!isValid.every(value => value)) {
                    event.preventDefault();
                    alert('기입란을 모두 입력했는지 다시 확인해주세요.');
                } else if (isValid.every(value => value)) {
                    // alert('상품이 등록되었습니다.');
                    document.getElementById('pro_form').submit();
                }
            }
            validateProName();
            validateProPrice();
            validateProStock();
            validateProInfo();

            proValidate();
        }

        const input = document.querySelector('input[type="file"]');
        let images = [];
        let selectedImages = [];
        const container = document.querySelector('.pro_image_container');

        input.addEventListener('change', event => {
            const files = event.target.files;

            // 기존 등록된 이미지 초기화
            images = [];
            selectedImages = [];
            container.innerHTML = '';

            [...files].forEach((file, index) => {
                if (!file.type.startsWith('image/')) {
                    return;
                }

                // 이미 등록된 이미지인 경우 추가하지 않음
                if (images.findIndex(image => image.name === file.name) !== -1) {
                    return;
                }

                // "X" 박스 삭제
                const emptyItem = container.querySelector('.pro_image_item.empty');
                if (emptyItem) {
                    emptyItem.remove();
                }

                const item = document.createElement('div');
                item.classList.add('pro_image_item');

                const img = document.createElement('img');
                img.classList.add('thumbnail');
                img.alt = file.name;
                img.name = 'productImage';

                const reader = new FileReader();
                reader.onload = event => {
                    img.src = event.target.result;
                };

                reader.readAsDataURL(file);
                item.appendChild(img);

                container.insertBefore(item, container.firstChild); // 이미지를 맨 앞에 추가

                if (selectedImages.length < 1) {
                    selectedImages.push(img);
                    item.classList.add('selected');
                    img.name = 'productThumbnail';
                    const hiddenInput = document.querySelector('input[name="productThumbnail"]');
                    hiddenInput.value = img.alt;
                }
            });
        });

        container.addEventListener('click', event => {
            const item = event.target.closest('.pro_image_item');
            if (item && !item.classList.contains('empty')) {
                // empty 클래스가 없는 요소를 클릭한 경우에만 선택 처리
                const img = item.querySelector('img');
                if (selectedImages.length === 1 && selectedImages[0] === img) {
                    return; // 이미 선택된 이미지를 클릭한 경우, 선택 변경 없이 종료
                }

                const selectedItem = container.querySelector('.pro_image_item.selected');

                if (selectedItem) {
                    selectedItem.classList.remove('selected');
                    const selectedImg = selectedItem.querySelector('img');
                    selectedImg.name = 'productImage'; // 선택 해제된 이미지의 name을 변경
                }

                selectedImages.push(img);
                item.classList.add('selected');
                img.name = 'productThumbnail'; //선택된 이미지의 name을 변경

                const hiddenInput = document.querySelector('input[name="productThumbnail"]');
                hiddenInput.value = img.alt; // 선택된 이미지의 파일명을 value 값으로 설정
            }
        });

/*         const submitBtn = document.querySelector('.submit-btn');

        submitBtn.addEventListener('click', event => {
            if (selectedImages.length < 1) {
                const lastEmptyItem = container.querySelector('.pro_image_item.empty:last-child');
                if (lastEmptyItem) {
                    lastEmptyItem.remove();
                }
            }

            selectedImages.forEach(selectedImage => {
                const selectedFile = images.find(file => file.name === selectedImage.alt);
                if (selectedFile) {
                    formData.append('selected_images', selectedFile);
                }
            });
        }); */
    </script>
</html>
