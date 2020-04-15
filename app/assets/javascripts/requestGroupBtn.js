var groupBtn = document.querySelector("#group-btn");
var chatBtn = document.querySelector("#chat-btn")
var form = document.getElementById("group-form")

function groupBtnDisabled(text){
    groupBtn.value = text
    groupBtn.disabled = true
}

if(gon.group_flg){
    var text = "グループメンバーです"
    groupBtnDisabled(text)
    chatBtn.disabled = false    //フレンドの人にはボタンを活性化する
}else if(gon.group_request_flg){
    var text = "承認待ち"
    groupBtnDisabled(text)
}
// フレンド申請ボタンが押されたとき非活性にする
groupBtn.addEventListener("mouseup" , () =>{
    var text = "承認待ち"
    groupBtnDisabled(text)
    form.submit()
});