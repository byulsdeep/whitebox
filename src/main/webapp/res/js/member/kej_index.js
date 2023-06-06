//$(document).ready(function () {
//  $(".prdList").slick({
//    infinite: false,
//    slidesToShow: 3,
//    slidesToScroll: 1,
//    dots: true, // 인디케이터 표시
//    autoplay: false,
//    centerMode: false,
//    centerPadding: "0",
//    draggable: true,
//    swipeToSlide: true,
//    prevArrow: false,
//    nextArrow: false,
//    responsive: [
//      {
//        breakpoint: 768,
//        settings: {
//          slidesToShow: 1,
//        },
//      },
//    ],
//  });
//
//  // 스타일 수정 - 1개씩 보여지는 경우 인디케이터 위치 수정
//  $(".prdList.slick-initialized.slick-slider .slick-dots").css(
//    "bottom",
//    "-40px"
//  );
//});
////상품리스트 더보기 / 접기
//$(function () {
//  let more = $("#load");
//  more.text("▼ 더보기 / 접기");
//  const initCount = 1; // 초기 갯수
//  let shownCount = initCount;
//  $(".proList_3x3").slice(0, shownCount).show();
//  $("#load").click(function (e) {
//    e.preventDefault();
//    if (more.text() === "▼ 더보기 / 접기") {
//      shownCount += initCount; // 클릭시 추가될 갯수
//      $(".proList_3x3:hidden").slice(0, initCount).show();
//      if ($(".proList_3x3:hidden").length === 0) {
//        more.text("▲ 더보기 / 접기");
//      }
//    } else {
//      shownCount = initCount; // 초기 갯수로 되돌리기
//      $(".proList_3x3").slice(shownCount).hide();
//      more.text("▼ 더보기 / 접기");
//    }
//  });
//});
