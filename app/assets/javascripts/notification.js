// バグがあるからリロード
if (window.name != "reload"){
	location.reload();
	window.name = "reload";
}else{
    window.name = "";
}

// 通知テーブルの通知を表示する
 var table = document.querySelector("#notification-table")

 // データベースからとった値をテーブルのレコードとして表示する
 function notificationPrint(doc){
    
    // 表示するタグを作成しクラスと文字列をつける
    let tr =  document.createElement("tr");
    tr.setAttribute("data-id" , doc.id);

    let userNameTd = document.createElement("td");
    let notificationTd = document.createElement("td");

    let btnTd = document.createElement("td");
    let div = document.createElement("div");

    let approvalBtn = document.createElement("button");
    approvalBtn.type = "button";
    approvalBtn.classList.add("btn" , "btn-primary" , "btn-sm" , "mr-3");
    approvalBtn.textContent = "承認"

    let rejectionBtn = document.createElement("button");
    rejectionBtn.type = "button";
    rejectionBtn.classList.add("btn" , "btn-secondary" , "btn-sm" , "mr-3");
    rejectionBtn.textContent = "拒否"

    getUserName(doc.data().postuserid , userNameTd)

    let notificationId = doc.data().notificationid;
    
    // notification_idごとにテーブルの色を分ける
    switch(String(notificationId).slice(0,1)){         //フレンド申請の通知
        case "0":
            tr.classList.add("table-primary");
            notificationTd.textContent = "フレンド依頼を受け取りました"
            approvalBtn.onclick = function () { friendAdd(doc.data().postuserid , doc.id); };
            break;
        case "1":  //グループの通知
            tr.classList.add("table-secondary");
            notificationTd.textContent = "グループに誘われました"
            break;
        case "2":                                                //新規メッセージの通知 
            tr.classList.add("table-warning");
            notificationTd.textContent = "新規メッセージがあります"
            approvalBtn.classList.add("d-none");
            rejectionBtn.classList.add("d-none");
            break;
    }

    tr.appendChild(userNameTd);
    tr.appendChild(notificationTd);
    div.appendChild(approvalBtn);
    div.appendChild(rejectionBtn);
    btnTd.appendChild(div);
    tr.appendChild(btnTd);
    table.appendChild(tr);
}

// ユーザの名前を取得しtdにセットする
function getUserName(userId , td){
    db.collection("users").where("userid", "==", userId).get().then((snapshot) => {
        snapshot.docs.forEach((doc) => {
            td.textContent = doc.data().name;
        });
    });
}

//データベースに変化があったとき処理をする
db.collection("users").doc(gon.user_doc_id).collection("notification").orderBy("date").onSnapshot(snapshot => {
    let changes = snapshot.docChanges();
    changes.forEach(change => {
        if(change.type == "added"){
            notificationPrint(change.doc)
        }else if(change.type == "removed"){ 
            let tr = table.querySelector("[data-id=" + change.doc.id + "]");
            table.removeChild(tr);
        }
    });
});


function friendAdd (friend_id , notificationDocId){
    var messageId = createMessageId("F")
    //フレンド登録するための関数
    var friendAddFun = function(){
        //ログインしているユーザのデータベースに登録する
        //登録するのはcheckExistisDocで行う
        db.collection("users").doc(gon.user_doc_id).collection("friends").add({
            friendid: friend_id,
            messageid: messageId
        })
        //通知を送った相手のdocumentidを取得する
        db.collection("users").where("userid" , "==" , friend_id).get().then((snapshot) => {
            var docId
            snapshot.docs.forEach((doc) => {
                docId = doc.id
            })
            //通知を送った相手のデータベースに登録する
            db.collection("users").doc(docId).collection("friends").add({
                friendid: gon.user_id,
                messageid: messageId
            })
        })
        //messageを追加する
        db.collection("message").add({
            messageid: messageId
        })
    }
    checkExistisMessageDoc(messageId , friendAddFun)    //messageidが存在しないことを確認しfriendとmessageを登録する
    deleteNotification(notificationDocId)       //データベースからnotificationのdocumentを削除する
}

//データベースからnotificationのdocumentを削除する関数
function deleteNotification(docId){
    db.collection("users").doc(gon.user_doc_id).collection("notification").doc(docId).delete();
}

//messageidを自動生成する
function createMessageId(firstChar){
    var random = Math.floor(Math.random() * Math.pow(10 , 16));
    return firstChar + random
}

//messageidが存在しないことを確認しfriendとmessageを登録する
function checkExistisMessageDoc(messageId , friendAddFun){
    
    db.collection("message").where("messageid" , "==" , messageId).get().then((snapshot) => {
        var user
        snapshot.docs.forEach((doc) => {
            user = doc.id
        })
        console.log(messageId)
        if(user == undefined){
            friendAddFun()
        }
    })
}