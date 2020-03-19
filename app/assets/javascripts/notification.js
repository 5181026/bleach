 // 通知テーブルの通知を表示する
 function notificationPrint(doc){
    // 表示するタグを作成しクラスと文字列をつける
    const table = document.getElementById("notification-table")
    let tr =  document.createElement("tr");

    let user_name_td = document.createElement("td");
    let notification_td = document.createElement("td");

    let btn_td = document.createElement("td");
    let div = document.createElement("div");

    let approval_btn = document.createElement("button");
    approval_btn.type = "button";
    approval_btn.classList.add("btn" , "btn-primary" , "btn-sm" , "mr-3");
    approval_btn.textContent = "承認"

    let rejection_btn = document.createElement("button");
    rejection_btn.type = "button";
    rejection_btn.classList.add("btn" , "btn-secondary" , "btn-sm" , "mr-3");
    rejection_btn.textContent = "拒否"

    get_user_name(doc.data().postuserid , user_name_td)

    let notification_id = doc.data().notificationid;
    
    // notification_idごとにテーブルの色を分ける
    switch(String(notification_id).slice(0,1)){         //フレンド申請の通知
        case "0":
            tr.classList.add("table-primary");
            notification_td.textContent = "フレンド依頼を受け取りました"
            break;
        case "1":  //グループの通知
            tr.classList.add("table-secondary");
            notification_td.textContent = "グループに誘われました"
            break;
        case "2":                                                //新規メッセージの通知 
            tr.classList.add("table-warning");
            notification_td.textContent = "新規メッセージがあります"
            break;
    }

    tr.appendChild(user_name_td);
    tr.appendChild(notification_td);
    div.appendChild(approval_btn);
    div.appendChild(rejection_btn);
    btn_td.appendChild(div);
    tr.appendChild(btn_td);
    table.appendChild(tr);
}


function get_user_name(user_id , td){
    db.collection("users").where("userid", "==", user_id).get().then((snapshot) => {
        snapshot.docs.forEach((doc) => {
            td.textContent = doc.data().name;
        });
    });
}


db.collection("users").doc("0JUDhZLTs9dtgKcscDty").collection("notification").orderBy("date").onSnapshot(snapshot => {
    let changes = snapshot.docChanges();
    changes.forEach(change => {
        if(change.type == "added"){
            notificationPrint(change.doc)
        }
    });
});