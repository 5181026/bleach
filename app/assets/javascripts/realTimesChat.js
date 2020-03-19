// TODO　chatが複数表示されるバグがあるとりあえずリロードすることでバグは出ない

// バグがあるからリロード
if (window.name != "reload"){
	location.reload();
	window.name = "reload";
}else{
    window.name = "";
}

var msg_form = document.querySelector("form");
var btn = document.getElementById("form-btn");

// テスト用チャットの追加用関数
function chatsPrint(doc){
    let chats = document.querySelector("#chat-view");

    let message_div = document.createElement("div");
    message_div.classList.add("d-flex" , "mt-5");

    let message_image_div = document.createElement("div");
    let message_text_div = document.createElement("div");
    // 自分が投降したメッセージと相手のメッセージのスタイルを分ける        
    if (doc.data().postid != gon.user_id){
        message_div.classList.add("d-flex" , "mt-5");
        message_image_div.classList.add("offset-1");
        message_text_div.classList.add("align-self-center" , "chat-format");
    }else{
        message_div.classList.add("d-flex" , "flex-row-reverse" , "col-11" , "mt-5");
        message_text_div.classList.add("align-self-center" , "my-chat-format");
    };
    //画像の処理を書く
    let message_image = document.createElement("img");
    message_image.src = "https://picsum.photos/200/300";
    message_image.classList.add("chat-image");
    
    // firestoreから送られたテキストをHTML要素にセットする
    message_text_div.textContent = doc.data().text;

    // 表示する準備をする
    message_image_div.appendChild(message_image);
    message_div.appendChild(message_image_div);
    message_div.appendChild(message_text_div);

    // 表示する
    chats.appendChild(message_div);
}

// 送信ボタンが押されたときにfirestoreにチャットデータを保存をする。(doc_idは本人のだけ使うからrailsから送る)
//バグあり
btn.addEventListener("click" , (e) =>{
    e.preventDefault();
    db.collection("message").doc(gon.doc_id).collection("content").add({
        date: new Date(),
        postid: gon.user_id,
        text: msg_form.msgText.value
    })
    .then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
    form.msgText.value = "";
});

// 始めにfirestoreからデータをもらいchatsPrintにデータを渡す
// そのあとリアルタイムでfirestoreに変化があれば更新する
db.collection("message").doc(gon.doc_id).collection("content").orderBy("date").onSnapshot(snapshot => {
    let changes = snapshot.docChanges();
    changes.forEach(change => {
        chatsPrint(change.doc);
    });
});

