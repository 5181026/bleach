var userImages = document.getElementsByName("user-image")
if(userImages != null){
    window.addEventListener("turbolinks:load" , () => {
        for (var i in userImages){
            printImage(userImages[i].id , userImages[i])
        }
    });
}


//イメージタグとuseridを引数とし画像を表示する
function printImage(userId , img){
    var storageRef = storage.child("image/" + userId + "/userimage");
    storageRef.getDownloadURL().then(function(url){
        img.src = url;
    }).catch((error) => {
        // console.log(error)
        switch (error.code) {
            case 'storage/object-not-found':
                var storageRef = storage.child("image/" + "notimage.png");
                storageRef.getDownloadURL().then(function(url){
                    img.src = url;
                })
                break;
            case 'storage/unauthorized':
                console.log("認証エラー")
                alert("エラーが発生しました。\n画像が表示できませんでした")
                break;
            case 'storage/unknown':
                console.log("サーバエラー")
                alert("サーバエラーが発生しました。\n画像が表示できませんでした")
              break;
          }
    })
}
