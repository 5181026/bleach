var friendBtn = document.querySelector("#friend-btn");
var form = document.getElementById("friend-form")

function friendBtnDisabled(text){
    friendBtn.value = text
    friendBtn.disabled = true
}

if(gon.friend_flg){
    let text = "フレンドです"
    friendBtnDisabled(text)
}else if(gon.friend_request_flg){
    let text = "送信済み"
    friendBtnDisabled(text)
}
// フレンド申請ボタンが押されたとき非活性にする
friendBtn.addEventListener("mouseup" , () =>{
    let text = "送信済み"
    friendBtnDisabled(text)
    form.submit()
});