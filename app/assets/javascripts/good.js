var form = document.getElementsByName("goodForm")

// formごとにイベントリスナーを作成
for(var i = 0 ; i < form.length; i++){
  form[i].addEventListener('click' , goodClick , false)
}

// クリックされたgoodのフォームを取得しサーバに送信する
function goodClick(e){
  let goodUserId = e.target.getAttribute('data-id')  
  let goodFlg = e.target.getAttribute('data-flg')   //どのdata-idがクリックされたかdata-idで判断する。
  // クリックされた場所がgoodアイコンなのか確認する
  if(goodFlg == "false" && goodUserId != null){
    let submitForm = e.currentTarget  //クリックされたフォームを取得する
    submitForm.childNodes[5].innerHTML = parseInt(submitForm.childNodes[5].textContent , 10) + 1  //gootの文字列を数値に変換し１増やす。
    console.log(submitForm.childNodes[3])
    submitForm.childNodes[3].dataset.flg = 'true';
    submitForm.childNodes[3].style.color = "blue"
    submitForm.submit()
  }else if(goodFlg == "true" && goodUserId != null){
    let submitForm = e.currentTarget  //クリックされたフォームを取得する
    submitForm.childNodes[5].innerHTML = parseInt(submitForm.childNodes[5].textContent , 10) - 1  //gootの文字列を数値に変換し１増やす。
    console.log(submitForm.childNodes[3])
    submitForm.childNodes[3].dataset.flg = 'false';
    submitForm.childNodes[3].style.color = "#6c757d"
    submitForm.submit()
  }
}