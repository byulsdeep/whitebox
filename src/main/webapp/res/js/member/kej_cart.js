//프로필 선택 모달창
const modal = document.getElementById("modal");
const btnModal = document.getElementById("btn-modal");
// btnModal.addEventListener("click", (e) => {
//   modal.style.display = "flex";
// });
const closeBtn = modal.querySelector(".close-area");
closeBtn.addEventListener("click", (e) => {
  modal.style.display = "none";
});
const closeBtn2 = modal.querySelector(".cart_fri_btn");
closeBtn2.addEventListener("click", (e) => {
  modal.style.display = "none";
});
//수량 모달
// const modal_sum = document.querySelector(".modal_sum");
// const btnModal_sum = document.querySelector(".btn-modal_sum");
// btnModal_sum.addEventListener("click", (e) => {
//    modal_sum.style.display = "flex";
// });
const closeBtn_sum = modal_sum.querySelector("#close-area_sum");
closeBtn_sum.addEventListener("click", (e) => {
  modal_sum.style.display = "none";
});
const closeBtn_sum1 = modal_sum.querySelector("#close-area_sum_info");
closeBtn_sum1.addEventListener("click", (e) => {
  modal_sum.style.display = "none";
});
//수량
function count(type) {
  // 결과를 표시할 element
  const resultElement = document.getElementById("result");

  // 현재 화면에 표시된 값
  let number = resultElement.innerText;

  // 더하기/빼기
  if (type === "plus") {
    number = parseInt(number) + 1;
  } else if (type === "minus" && number > 1) {
    number = parseInt(number) - 1;
  }
  // 결과 출력
  resultElement.innerText = number;
  
}
