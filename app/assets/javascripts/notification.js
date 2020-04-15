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
    var tr =  document.createElement("tr");
    tr.setAttribute("data-id" , doc.id);

    var userNameTd = document.createElement("td");
    var notificationTd = document.createElement("td");

    var btnTd = document.createElement("td");
    var div = document.createElement("div");

    var approvalBtn = document.createElement("button");
    approvalBtn.type = "button";
    approvalBtn.classList.add("btn" , "btn-primary" , "btn-sm" , "mr-3");
    approvalBtn.textContent = "承認"

    var rejectionBtn = document.createElement("button");
    rejectionBtn.type = "button";
    rejectionBtn.classList.add("btn" , "btn-secondary" , "btn-sm" , "mr-3");
    rejectionBtn.textContent = "拒否"
    rejectionBtn.onclick = function() { devareNotification(doc.id); }

    getUserName(doc.data().postuserid , userNameTd)

    var notificationId = doc.data().notificationid;
    
    // notification_idごとにテーブルの色を分ける
    switch(String(notificationId).slice(0,1)){         //フレンド申請の通知
        case "0":
            tr.classList.add("table-success");
            notificationTd.textContent = "フレンド依頼を受け取りました。"
            approvalBtn.onclick = function () { friendAdd(doc.data().postuserid , doc.id); };
            break;
        case "1":  //グループの通知
            tr.classList.add("table-primary");
            getGroup(doc.data().groupid , notificationTd)
            approvalBtn.onclick = function () { groupAdd(doc.data().postuserid , doc.data().groupid , doc.id); }
            break;
        case "2":                                                //新規メッセージの通知 
            tr.classList.add("table-warning");
            notificationTd.textContent = "新規メッセージがあります。"
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
    var changes = snapshot.docChanges();
    changes.forEach(change => {
        if(change.type == "added"){
            notificationPrint(change.doc)
        }else if(change.type == "removed"){ 
            var tr = table.querySelector("[data-id=" + change.doc.id + "]");
            table.removeChild(tr);
        }
    });
});

function friendAdd (friend_id , notificationDocId){
    var messageId = createMessageId("F")
    //フレンド登録の通知を送るための関数
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
            });
            //通知を送った相手のデータベースに登録する
            db.collection("users").doc(docId).collection("friends").add({
                friendid: gon.user_id,
                messageid: messageId
            });
        });
        // //messageを追加する
        // db.collection("message").add({
        //     messageid: messageId
        // })
    }
    checkExistisMessageDoc(messageId , friendAddFun)    //messageidが存在しないことを確認しfriendとmessageを登録する
    devareNotification(notificationDocId)       //データベースからnotificationのdocumentを削除する
}

function groupAdd(userId , groupId, notificationDocId) {
    // 送ってきた相手のdocumentIDを取得
    db.collection("users").where("userid" , "==" , userId).get().then((snapshot) => {
        var docId
        snapshot.docs.forEach((doc) => {
            docId = doc.id
        });
    
        db.collection("users").doc(docId).collection("mygroup").add({
            groupid: groupId
            // messageid: messageId
        });
    });

    // groupのdocumentIdを取得する
    db.collection("groups").where("groupid" , "==" , groupId).get().then((snapshot) => {
        var docId
        snapshot.docs.forEach((doc) => {
            docId = doc.id
        });
        // 通知を送った相手をメンバに追加する。
        db.collection("groups").doc(docId).collection("members").add({
            memberid: userId
        });
    });
    devareNotification(notificationDocId)
}

//データベースからnotificationのdocumentを削除する関数
function devareNotification(docId){
    db.collection("users").doc(gon.user_doc_id).collection("notification").doc(docId).devare();
}

//messageidを自動生成する
function createMessageId(firstChar){
    var random = Math.floor(Math.random() * Math.pow(10 , 16));
    return firstChar + random
}

//messageidが存在しないことを確認し追加する関数を処理しmessageを登録する
function checkExistisMessageDoc(messageId , AddFunction){
    db.collection("message").where("messageid" , "==" , messageId).get().then((snapshot) => {
        var user
        snapshot.docs.forEach((doc) => {
            user = doc.id
        })
        console.log(messageId)
        if(user == undefined){
            AddFunction()
            //messageを追加する
            db.collection("message").add({
                messageid: messageId
            })
        }
    })
}

function getGroup(groupId , td){
    console.log(groupId)
    db.collection("groups").where("groupid" , "==" , groupId).get().then((snapshot) => {
        var group
        snapshot.docs.forEach((doc) => {
            group = doc.data()
        })
        td.textContent = group.groupname + "グループに入りたいです。"
    })
    }