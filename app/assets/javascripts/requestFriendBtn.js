var friendBtn = document.querySelector("#friend-btn");
var chatBtn = document.querySelector("#chat-btn")
var form = document.getElementById("friend-form")

function friendBtnDisabled(text){
    friendBtn.value = text
    friendBtn.disabled = true
}

if(gon.friend_flg){
    var text = "フレンドです"
    friendBtnDisabled(text)
    chatBtn.disabled = false    //フレンドの人にはボタンを活性化する
}else if(gon.friend_request_flg){
    var text = "送信済み"
    friendBtnDisabled(text)
}
// フレンド申請ボタンが押されたとき非活性にする
friendBtn.addEventListener("mouseup" , () =>{
    var text = "送信済み"
    friendBtnDisabled(text)
    form.submit()
});