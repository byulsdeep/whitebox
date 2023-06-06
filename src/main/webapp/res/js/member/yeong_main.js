// product_search
let viewCount = 0;

productSearch = () => {
    
    // 백 작업 시 수정
    let productList = new Array();
    // data.forEach(e => {
    //     let product = new Object();
    //     product.selid = e.pro_selid;
    //     product.code = e.pro_code;
    //     product.name = e.pro_name;
    //     product.info = e.pro_info;
    //     product.price = e.pro_price;

    //     productList.push(product);
    // });
    
    productSearchContentView(productList);
}

productSearchContentView = (productList) => {
    // let products = productList;
    let products = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
    let viewProduct = '';

    console.log(typeof products);
    
    productList != null ?(
    viewCount = 6,
    document.querySelector('.product_search_wrap_content_more').style.display = 'block'
    ): (viewCount += 6);

    products.map((e,i) => {
        if(i < viewCount){
            viewProduct += '<div class="card_product"><span class="wrap_thumb"><img cuimg="" uselazyloading="" class="img_g"src="https://img1.kakaocdn.net/thumb/C306x306@2x.q82.fwebp/?fname=https%3A%2F%2Fst.kakaocdn.net%2Fproduct%2Fgift%2Fproduct%2F20230315154042_18142860e30348aa81b257f108b94c26.jpg"alt="ボディウォッシュ"></span><span class="wrap_info"><strong><a class="txt_brand">[ TAMBURINS ] ギフトラッピング _ ボディウォッシュ (4種択1)</a></strong><div><a class="txt_product">4つの雨の物語を盛り込んだシャワーボディウォッシ</a></div><div class="txt_price"><strong>¥<span class="txt_yen">3,300</span></strong><span class="txt_tax">税込</span></div></span></div>';
            if(i == products.length-1){
                document.querySelector('.product_search_wrap_content_more').style.display = 'none'
            }
        }
    });
    document.querySelector('.product_search_wrap_content').innerHTML = viewProduct;
}

productSearchRangeInput = (e) => {
    e.value=Math.min(e.value,e.parentNode.childNodes[5].value-1);
    var value=(100/(parseInt(e.max)-parseInt(e.min)))*parseInt(e.value)-(100/(parseInt(e.max)-parseInt(e.min)))*parseInt(e.min);
    var children = e.parentNode.childNodes[1].childNodes;
    children[1].style.width=value+'%';
    children[5].style.left=value+'%';
    children[7].style.left=value+'%';
    document.querySelector('.product_search_wrap_head_bottom_price_min_input').value = (e.value <= 50 ? e.value * 1000 : (e.value <= 95 ? e.value * 10000 - 450000 : e.value * 100000 - 9000000));
}

productSearchRangeInput2 = (e) => {
    e.value=Math.max(e.value,e.parentNode.childNodes[3].value-(-1));
    var value=(100/(parseInt(e.max)-parseInt(e.min)))*parseInt(e.value)-(100/(parseInt(e.max)-parseInt(e.min)))*parseInt(e.min);
    var children = e.parentNode.childNodes[1].childNodes;
    children[3].style.width=(100-value)+'%';
    children[5].style.right=(100-value)+'%';
    children[9].style.left=value+'%';
    document.querySelector('.product_search_wrap_head_bottom_price_max_input').value = (e.value <= 50 ? e.value * 1000 : (e.value <= 95 ? e.value * 10000 - 450000 : e.value * 100000 - 9000000));
}

productSearchWrapOrder = (e) => {
    let buttons = e.parentNode;
    let active = buttons.querySelector('.active');
    active ? active.classList.remove('active'):'';
    e.classList.add('active');
}