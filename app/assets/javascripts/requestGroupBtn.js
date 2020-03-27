var groupBtn = document.querySelector("#group-btn");
var chatBtn = document.querySelector("#chat-btn")
var form = document.getElementById("group-form")

function groupBtnDisabled(text){
    groupBtn.value = text
    groupBtn.disabled = true
}

if(gon.group_flg){
    let text = "グループメンバーです"
    groupBtnDisabled(text)
    chatBtn.disabled = false    //フレンドの人にはボタンを活性化する
}else if(gon.group_request_flg){
    let text = "承認待ち"
    groupBtnDisabled(text)
}
// フレンド申請ボタンが押されたとき非活性にする
groupBtn.addEventListener("mouseup" , () =>{
    let text = "承認待ち"
    groupBtnDisabled(text)
    form.submit()
});