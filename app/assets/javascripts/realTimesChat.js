// TODO　chatが複数表示されるバグがあるとりあえずリロードすることでバグは出ない

// バグがあるからリロード
if (window.name != "reload"){
	location.reload();
	window.name = "reload";
}else{
    window.name = "";
}

var msgForm = document.querySelector("form");
var btn = document.getElementById("form-btn");

// テスト用チャットの追加用関数
function chatsPrint(doc){
    var chats = document.querySelector("#chat-view");

    var messageDiv = document.createElement("div");
    var nameDiv = document.createElement("div");
    var messageImageDiv = document.createElement("div");
    var messageTextDiv = document.createElement("div");

    getName(doc.data().postid , nameDiv);
    nameDiv.classList.add("ml-2");
    messageDiv.classList.add("d-flex" , "mt-5");
    // 自分が投降したメッセージと相手のメッセージのスタイルを分ける        
    if (doc.data().postid != gon.user_id){
        messageDiv.classList.add("d-flex" , "mt-5");
        messageImageDiv.classList.add("offset-1");
        messageTextDiv.classList.add("align-self-center" , "chat-format");
    }else{
        messageDiv.classList.add("d-flex" , "flex-row-reverse" , "col-11" , "mt-5");
        messageTextDiv.classList.add("align-self-center" , "my-chat-format");
    };
    //画像の処理を書く
    var messageImage = document.createElement("img");
    // messageImage.src = "https://picsum.photos/200/300";
    // messageImage.setAttribute = ("data-userid" , doc.data().postid);
    // messageImage.name = "user-image";
    messageImage.classList.add("chat-image");
    
    // firestoreから送られたテキストをHTML要素にセットする
    messageTextDiv.textContent = doc.data().text;

    // 表示する準備をする
    messageImageDiv.appendChild(nameDiv);
    messageImageDiv.appendChild(messageImage);
    messageDiv.appendChild(messageImageDiv);
    messageDiv.appendChild(messageTextDiv);

    // 表示する
    chats.appendChild(messageDiv);
    scrollBottom();
    //printImage.jsから呼び出している。
    printImage(doc.data().postid , messageImage)
}

// 送信ボタンが押されたときにfirestoreにチャットデータを保存をする。
btn.addEventListener("click" , (e) =>{
    e.preventDefault();
    db.collection("message").doc(gon.doc_id).collection("content").add({
        date: new Date(),
        postid: gon.user_id,
        text: msgForm.msgText.value
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
    var changes = snapshot.docChanges();
    changes.forEach(change => {
        if(change.type == "added"){
            chatsPrint(change.doc);
        }
    });
});

function getName(userId , element){
    console.log(userId)
    console.log(element)
    db.collection("users").where("userid" , "==" , userId).get().then((snapshot) => {
        var user
        snapshot.docs.forEach((doc) => {
            user = doc.data().name
        })
        element.textContent = user
    })
}


function scrollBottom(){
    var elementHtml = document.documentElement;
    var bottom = elementHtml.scrollHeight - elementHtml.clientHeight;
    window.scroll(0 , bottom)
}

